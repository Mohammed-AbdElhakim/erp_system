part of 'get_page_details_cubit.dart';

sealed class GetPageDetailsState extends Equatable {
  const GetPageDetailsState();
  @override
  List<Object> get props => [];
}

final class GetPageDetailsInitial extends GetPageDetailsState {}

final class GetPageDetailsLoading extends GetPageDetailsState {}

final class GetPageDetailsFailure extends GetPageDetailsState {
  final String errorMassage;

  const GetPageDetailsFailure(this.errorMassage);
}

final class GetPageDetailsSuccess extends GetPageDetailsState {
  final TapModel tapModel;

  const GetPageDetailsSuccess(this.tapModel);
}
