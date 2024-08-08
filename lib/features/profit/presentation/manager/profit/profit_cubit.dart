import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/profit_model.dart';

part 'profit_state.dart';

class ProfitCubit extends Cubit<ProfitState> {
  ProfitCubit() : super(ProfitInitial());
}
