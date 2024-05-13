part of 'get_all_dropdown_list_cubit.dart';

sealed class GetAllDropdownListState extends Equatable {
  const GetAllDropdownListState();
  @override
  List<Object> get props => [];
}

final class GetAllDropdownListInitial extends GetAllDropdownListState {}

final class GetAllDropdownListLoading extends GetAllDropdownListState {}

final class GetAllDropdownListFailure extends GetAllDropdownListState {
  final String errorMassage;

  const GetAllDropdownListFailure(this.errorMassage);
}

final class GetAllDropdownListSuccess extends GetAllDropdownListState {
  final List<AllDropdownModel> allDropdownModelList;

  const GetAllDropdownListSuccess(this.allDropdownModelList);
}
