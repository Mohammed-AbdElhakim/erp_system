part of 'get_file_excel_cubit.dart';

sealed class GetFileExcelState extends Equatable {
  const GetFileExcelState();
  @override
  List<Object> get props => [];
}

final class GetFileExcelInitial extends GetFileExcelState {}

final class GetFileExcelLoading extends GetFileExcelState {}

final class GetFileExcelFailure extends GetFileExcelState {
  final String errorMassage;

  const GetFileExcelFailure(this.errorMassage);
}

final class GetFileExcelSuccess extends GetFileExcelState {
  final ScreenModel screenModel;

  const GetFileExcelSuccess(this.screenModel);
}
