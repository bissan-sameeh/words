class WordModel {
  final int indexAtDataBase;
  final String text;
  final bool isArabic;
  final int colorCode;
  final List<String> arabicSimilarWords;
  final List<String> englishSimilarWord;
  final List<String> arabicExamples;
  final List<String> englishExamples;

  const WordModel(
      {required this.indexAtDataBase,
      required this.text,
      required this.isArabic,
      required this.colorCode,
      this.arabicSimilarWords = const [],
      this.englishSimilarWord = const [],
      this.arabicExamples = const [],
      this.englishExamples = const []});

  deleteSimilarWold(int indexSimilarWord,bool isArabic){
    List<String> newSimilarWorlds = _initNewSimilarWord(isArabic);
    newSimilarWorlds.removeAt(indexSimilarWord);
    return wordModel(newSimilarWorlds: newSimilarWorlds, isArabicSimilarWord: isArabic);
  }

  WordModel wordModel(
      {required List<String> newSimilarWorlds, required bool isArabicSimilarWord}){
    return WordModel(
        indexAtDataBase: indexAtDataBase,
        text: text,
        isArabic: isArabic,
        colorCode: colorCode,
        englishSimilarWord: !isArabicSimilarWord?newSimilarWorlds :englishSimilarWord,
        arabicSimilarWords: isArabicSimilarWord ? newSimilarWorlds : arabicSimilarWords,
        englishExamples: englishExamples,
        arabicExamples: arabicExamples
    );
  }



  WordModel decrementIndexAtDataBase(){
    return WordModel(indexAtDataBase: indexAtDataBase -1 , text: text, isArabic: isArabic, colorCode: colorCode);
  }


  _initNewSimilarWord(bool isArabicSimilarWord){
    if (isArabicSimilarWord) {
     return List.from(arabicSimilarWords);
    } else {
      return  List.from(englishSimilarWord);
    }

  }

  _initNewExamples(bool isArabicExamples){
    if (isArabicExamples) {
      return List.from(arabicExamples);
    } else {
      return  List.from(englishExamples);
    }
  }

  WordModel addSimilarWord(String similarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWorlds = _initNewSimilarWord(isArabicSimilarWord);
    newSimilarWorlds.add(similarWord);
    return wordModel(
        newSimilarWorlds:newSimilarWorlds, isArabicSimilarWord: isArabicSimilarWord);

  }

  WordModel addExample(bool isArabicExamples,String exampleWord){
    List<String> newExamples= _initNewExamples(isArabicExamples);
    newExamples.add(exampleWord);
    return wordModelExamples(isArabicExamples,newExamples);
  }

  WordModel deleteExample(bool isArabicExamples,int indexAtDataBase){
    List<String> newExamples= _initNewExamples(isArabicExamples);
    newExamples.removeAt(indexAtDataBase);

    return wordModelExamples(isArabicExamples,newExamples);
  }


  WordModel wordModelExamples(bool isArabicExample,List<String> newExamples){
    return WordModel(indexAtDataBase: indexAtDataBase, text: text, isArabic: isArabic, colorCode: colorCode,
        arabicExamples: isArabicExample ? newExamples :arabicExamples ,
        englishExamples: !isArabicExample ?newExamples :englishExamples);


  }
}


