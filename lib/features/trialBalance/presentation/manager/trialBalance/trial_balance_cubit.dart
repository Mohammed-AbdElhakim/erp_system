import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/trialBalance/data/models/trial_balance_model.dart';

part 'trial_balance_state.dart';

class TrialBalanceCubit extends Cubit<TrialBalanceState> {
  TrialBalanceCubit() : super(TrialBalanceInitial());
}
