import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/column_data_model.dart';

part 'get_screen_state.dart';

class GetScreenCubit extends Cubit<GetScreenState> {
  GetScreenCubit() : super(GetScreenInitial());
}
