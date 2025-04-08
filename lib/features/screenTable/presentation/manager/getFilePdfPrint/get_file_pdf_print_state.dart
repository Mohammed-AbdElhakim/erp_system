part of 'get_file_pdf_print_cubit.dart';

sealed class GetFilePdfPrintState extends Equatable {
  const GetFilePdfPrintState();
  @override
  List<Object> get props => [];
}

final class GetFilePdfPrintInitial extends GetFilePdfPrintState {}

final class GetFilePdfPrintLoading extends GetFilePdfPrintState {}

final class GetFilePdfPrintFailure extends GetFilePdfPrintState {
  final String errorMassage;

  const GetFilePdfPrintFailure(this.errorMassage);
}

final class GetFilePdfPrintSuccess extends GetFilePdfPrintState {
  final Uint8List pdfData;

  const GetFilePdfPrintSuccess(this.pdfData);
}
