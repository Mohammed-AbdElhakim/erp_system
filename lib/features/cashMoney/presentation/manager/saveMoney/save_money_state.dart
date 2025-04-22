part of 'save_money_cubit.dart';

sealed class SaveMoneyState extends Equatable {
  const SaveMoneyState();

  @override
  List<Object> get props => [];
}

final class SaveMoneyInitial extends SaveMoneyState {}

final class SaveMoneyLoading extends SaveMoneyState {}

final class SaveMoneyFailure extends SaveMoneyState {
  final String errorMassage;

  const SaveMoneyFailure(this.errorMassage);
}

final class SaveMoneySuccess extends SaveMoneyState {
  const SaveMoneySuccess();
}
