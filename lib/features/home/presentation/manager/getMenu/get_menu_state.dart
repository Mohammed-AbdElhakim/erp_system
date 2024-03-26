part of 'get_menu_cubit.dart';

sealed class GetMenuState extends Equatable {
  const GetMenuState();
  @override
  List<Object> get props => [];
}

final class GetMenuInitial extends GetMenuState {}

final class GetMenuLoading extends GetMenuState {}

final class GetMenuFailure extends GetMenuState {
  final String errorMassage;

  const GetMenuFailure(this.errorMassage);
}

final class GetMenuSuccess extends GetMenuState {
  final List<MenuModel> menu;

  const GetMenuSuccess(this.menu);
}
