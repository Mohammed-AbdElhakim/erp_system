part of 'get_header_table_cubit.dart';

sealed class GetHeaderTableState extends Equatable {
  const GetHeaderTableState();
  @override
  List<Object> get props => [];
}

final class GetHeaderTableInitial extends GetHeaderTableState {}

final class GetHeaderTableLoading extends GetHeaderTableState {}

final class GetHeaderTableFailure extends GetHeaderTableState {
  final String errorMassage;

  const GetHeaderTableFailure(this.errorMassage);
}

final class GetHeaderTableSuccess extends GetHeaderTableState {
  final List<HeaderModel> headerList;

  const GetHeaderTableSuccess(this.headerList);
}
