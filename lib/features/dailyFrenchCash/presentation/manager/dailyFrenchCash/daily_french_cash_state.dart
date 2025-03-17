part of 'daily_french_cash_cubit.dart';

sealed class DailyFrenchCashState extends Equatable {
  const DailyFrenchCashState();
  @override
  List<Object> get props => [];
}

final class DailyFrenchCashInitial extends DailyFrenchCashState {}

final class DailyFrenchCashLoading extends DailyFrenchCashState {}

final class DailyFrenchCashFailure extends DailyFrenchCashState {
  final String errorMassage;

  const DailyFrenchCashFailure(this.errorMassage);
}

final class DailyFrenchCashSuccess extends DailyFrenchCashState {
  final DailyFrenchCashModel dailyFrenchCashModel;

  const DailyFrenchCashSuccess(this.dailyFrenchCashModel);
}
