import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/models/menu_model/menu_model.dart';

part 'get_screen_state.dart';

class GetScreenCubit extends Cubit<GetScreenState> {
  GetScreenCubit() : super(GetScreenInitial());
}
