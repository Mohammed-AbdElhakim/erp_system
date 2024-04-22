import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/screenTable/data/models/dropdown_model.dart';

part 'get_dropdown_list_state.dart';

class GetDropdownListCubit extends Cubit<GetDropdownListState> {
  GetDropdownListCubit() : super(GetDropdownListInitial());
}
