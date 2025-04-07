import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../hive_constants.dart';
import '../../models/word_model.dart';

part 'read_data_state.dart';

class ReadDataCubit extends Cubit<ReadDataState> {
  ReadDataCubit() : super(ReadDataInitial());

  final Box _box = Hive.box(HiveConstants.wordsBox);
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.descending; //from newest to latest
  void updateFilterLanguage(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
  }

  void updateSortingBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
  }

  void updateSortingType(SortingType sortingType) {
    this.sortingType = sortingType;
  }

  void getWords() {
    emit(ReadDataLoadingState());
    try {
      List<WordModel> wordsToReturn = List.from(
          _box
              .get(HiveConstants.wordList, defaultValue: [])).cast<
          WordModel>(); //لو مش مكرييتين يعني اول مرة نفتح هيرجع null واجنا بدناش هيك ! , تاني مشكلة في الرن تايم هيكون List<dynamic < ,هيكون انه انه نت سب تايب اوف ورد مودل فبنعمله كاست >
      _removeUnWantedWords(wordsToReturn);
      _sortingBy(wordsToReturn);
      emit(ReadDataSuccessState(words: wordsToReturn));
    } catch (e) {
      emit(ReadDataFailedState(message: e.toString()));
    }
  }

  void _removeUnWantedWords(List<WordModel> words) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (int i = 0; i < words.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              words[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              words[i].isArabic == true)) {
        words.removeAt(i);
        i--;
      }
    }
  }

  void _sortingBy(List<WordModel> words) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.ascending) {
        return; //صاعدي من اول كلمة لاخر كلمة حسب الوقت
      } else {
        _reverse(words);
      }
    } else {
      words.sort((WordModel a, WordModel b) => a.text.length.compareTo(b.text.length),); //نصاعدي
      if(sortingType==SortingType.ascending){
        return ;
      }else{
        _reverse(words);
      }
    }
  }

  void _reverse(List<WordModel> words) {
    for (int i = 0; i < words.length / 2; i++) {
      final temp = words[i];
      words[i] = words[words.length - 1 - i];
      words[words.length - 1 - i] = temp;
    }
  }
}

enum LanguageFilter {
  arabicOnly,
  englishOnly,
  allWords, //
}

enum SortedBy {
  time, //
  wordLength,
}

enum SortingType {
  ascending, //
  descending,
}
