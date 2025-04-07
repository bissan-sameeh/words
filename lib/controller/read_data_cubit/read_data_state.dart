part of 'read_data_cubit.dart';

@immutable
abstract class ReadDataState {}

final class ReadDataInitial extends ReadDataState {}

class ReadDataLoadingState extends ReadDataState{}
class ReadDataSuccessState extends ReadDataState{
  final List<WordModel> words;

  ReadDataSuccessState({required this.words});
}
class ReadDataFailedState extends ReadDataState{
  final String message;

  ReadDataFailedState({required this.message});
}