part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginFailure extends LoginState {
  final String errorMassage;

  const LoginFailure(this.errorMassage);
}

final class LoginSuccess extends LoginState {
  final LoginModel loginModel;

  const LoginSuccess(this.loginModel);
}
