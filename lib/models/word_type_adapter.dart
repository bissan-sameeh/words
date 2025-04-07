import 'package:hive/hive.dart';
import 'package:words/models/word_model.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
  return WordModel(indexAtDataBase: reader.readInt(), text: reader.readString(), isArabic: reader.readBool(), colorCode: reader.readInt(),arabicExamples: reader.readStringList(),englishExamples: reader.readStringList(),arabicSimilarWords: reader.readStringList(),englishSimilarWord: reader.readStringList());

  }


  @override
  // TODO: implement typeId
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
  writer.writeString(obj.text);
  writer.writeBool(obj.isArabic);
  writer.writeInt(obj.colorCode);
  writer.writeInt(obj.indexAtDataBase);
  writer.writeStringList(obj.englishExamples);
  writer.writeStringList(obj.arabicSimilarWords);
  writer.writeStringList(obj.englishExamples);
  writer.writeStringList(obj.englishSimilarWord);


  }






}