part of 'get_screen_cubit.dart';

@immutable
sealed class GetScreenState extends Equatable{
  const GetScreenState();
  @override
  List<Object> get props => [];
}

final class GetScreenInitial extends GetScreenState {}


final class GetScreenLoading extends GetScreenState {}

final class GetScreenFailure extends GetScreenState {
  final String errorMassage;

   const GetScreenFailure(this.errorMassage);
}

final class GetScreenSuccess extends GetScreenState {
  final MenuModel menu;

  const GetScreenSuccess(this.menu);
}

