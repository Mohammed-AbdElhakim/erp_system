part of 'get_dropdown_list_cubit.dart';

sealed class GetDropdownListState extends Equatable {
  const GetDropdownListState();
  @override
  List<Object> get props => [];
}

final class GetDropdownListInitial extends GetDropdownListState {}

final class GetDropdownListLoading extends GetDropdownListState {}

final class GetDropdownListFailure extends GetDropdownListState {
  final String errorMassage;

  const GetDropdownListFailure(this.errorMassage);
}

final class GetDropdownListSuccess extends GetDropdownListState {
  final DropdownModel dropdownModel;

  const GetDropdownListSuccess(this.dropdownModel);
}
