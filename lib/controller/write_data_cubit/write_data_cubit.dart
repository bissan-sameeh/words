import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:words/hive_constants.dart';
import 'package:words/models/word_model.dart';

part 'write_data_state.dart';

class WriteDataCubit extends Cubit<WriteDataState> {

  static WriteDataCubit get(context) => BlocProvider.of(context);
  WriteDataCubit() : super(WriteDataInitial());

  final Box _box=Hive.box(HiveConstants.wordsBox);
  String text='';
  bool isArabic=true;
  int colorCode=0xFF4A47A3;


  void updateText(String text){
    this.text=text;

  } void updateIsArabic(bool isArabic){
    this.isArabic=isArabic;
    emit(WriteDataInitial());
  }
  void updateColorCode(int colorCode){
    this.colorCode=colorCode;
    emit(WriteDataInitial());

  }


  void addSimilarWord(int indexAtDataBase){
    emit(WriteDataLoadingState());
    tryAndCatch(methodToExcute: () {
      List<WordModel> words=_getList();
      words[indexAtDataBase]=words[indexAtDataBase].addSimilarWord(text, isArabic);
      _box.put(HiveConstants.wordList, words[indexAtDataBase]);

    }, message: 'Cannot Add Similar Word!');


  }
  void addExamples(int indexAtDataBase){
    emit(WriteDataLoadingState());
    tryAndCatch(methodToExcute: () {
      List<WordModel> words=_getList();
      words[indexAtDataBase]=words[indexAtDataBase].addExample(isArabic, text);
      _box.put(HiveConstants.wordList, words);
    }, message: 'Cannot Add Example Word');
  }

  void deleteExamples(int indexAtDataBase, int index,bool isArabicWord){
    emit(WriteDataLoadingState());
    tryAndCatch(methodToExcute: () {
      List<WordModel> words=_getList();
      words[indexAtDataBase]=words[indexAtDataBase].deleteExample(isArabic, index);
      _box.put(HiveConstants.wordList, words);
    }, message: 'Cannot Add Example Word');
  }


  void deleteSimilarWord(int indexAtDataBase, int index,bool isArabicWord){
  tryAndCatch(methodToExcute: () {
    List<WordModel> words=_getList();
    words[indexAtDataBase]=words[indexAtDataBase].deleteSimilarWold(index, isArabicWord);
    _box.put(HiveConstants.wordList, isArabic);

  }, message: 'Cannot delete Similar Word');
  }

  void addWord(){
    emit(WriteDataLoadingState());
    tryAndCatch(methodToExcute: () {
      List<WordModel> words=_getList();
      words.add(WordModel(indexAtDataBase: words.length, text: text, isArabic: isArabic, colorCode: colorCode));
      _box.put(HiveConstants.wordList, words);
    }, message: 'Cannot add new word!,please try again!');
  }
  void deleteWord(int index){
    emit(WriteDataLoadingState());

    tryAndCatch(methodToExcute: () {
      List<WordModel> words=_getList();
      words.removeAt(index);
      for(int i=index ;i <words.length ; i++){
        words[i] =words[i].decrementIndexAtDataBase();
      }
      _box.put(HiveConstants.wordList, words);
    },
      message: 'Cannot add new word!,please try again!'

    );

  }

 List<WordModel>  _getList(){
    return List.from(_box.get(HiveConstants.wordList,defaultValue: []),).cast<WordModel>();
  }

  void tryAndCatch({required VoidCallback methodToExcute, required String message}){
    try{
      methodToExcute.call();
      emit(WriteDataSuccessState());

    }catch(e){
      emit(WriteDataErrorState(message: message));
    }
  }

}
