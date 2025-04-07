part of 'write_data_cubit.dart';

@immutable
abstract class WriteDataState {}

 class WriteDataInitial extends WriteDataState {}
 class WriteDataLoadingState extends WriteDataState {}
 class WriteDataSuccessState extends WriteDataState {}
class WriteDataErrorState extends WriteDataState {
 final String message;

  WriteDataErrorState({required this.message});
}

