part of 'get_page_details_table_cubit.dart';

sealed class GetPageDetailsTableState extends Equatable {
  const GetPageDetailsTableState();
  @override
  List<Object> get props => [];
}

final class GetPageDetailsTableInitial extends GetPageDetailsTableState {}

final class GetPageDetailsTableLoading extends GetPageDetailsTableState {}

final class GetPageDetailsTableFailure extends GetPageDetailsTableState {
  final String errorMassage;

  const GetPageDetailsTableFailure(this.errorMassage);
}

final class GetPageDetailsTableSuccess extends GetPageDetailsTableState {
  final ScreenModel screenModel;

  const GetPageDetailsTableSuccess(
    this.screenModel,
  );
}
