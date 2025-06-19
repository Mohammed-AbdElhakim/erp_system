part of 'get_file_word_print_cubit.dart';

sealed class GetFileWordPrintState extends Equatable {
  const GetFileWordPrintState();

  @override
  List<Object> get props => [];
}

final class GetFileWordPrintInitial extends GetFileWordPrintState {}

final class GetFileWordPrintLoading extends GetFileWordPrintState {}

final class GetFileWordPrintFailure extends GetFileWordPrintState {
  final String errorMassage;

  const GetFileWordPrintFailure(this.errorMassage);
}

final class GetFileWordPrintSuccess extends GetFileWordPrintState {
  final Uint8List wordData;

  const GetFileWordPrintSuccess(this.wordData);
}
