import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/dailyFrenchCash/data/models/daily_french_cash_model.dart';

part 'daily_french_cash_state.dart';

class DailyFrenchCashCubit extends Cubit<DailyFrenchCashState> {
  DailyFrenchCashCubit() : super(DailyFrenchCashInitial());
}
