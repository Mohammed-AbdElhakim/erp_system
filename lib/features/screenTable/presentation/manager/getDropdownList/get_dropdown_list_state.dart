part of 'get_dropdown_list_cubit.dart';

sealed class GetDropdownListState extends Equatable {
  const GetDropdownListState();
}

final class GetDropdownListInitial extends GetDropdownListState {
  @override
  List<Object> get props => [];
}
