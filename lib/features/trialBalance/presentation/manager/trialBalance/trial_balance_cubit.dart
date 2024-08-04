import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trial_balance_state.dart';

class TrialBalanceCubit extends Cubit<TrialBalanceState> {
  TrialBalanceCubit() : super(TrialBalanceInitial());
}
