part of 'get_money_cubit.dart';

sealed class GetMoneyState extends Equatable {
  const GetMoneyState();

  @override
  List<Object> get props => [];
}

final class GetMoneyInitial extends GetMoneyState {}

final class GetMoneyLoading extends GetMoneyState {}

final class GetMoneyFailure extends GetMoneyState {
  final String errorMassage;

  const GetMoneyFailure(this.errorMassage);
}

final class GetMoneySuccess extends GetMoneyState {
  final double data;

  const GetMoneySuccess(this.data);
}
