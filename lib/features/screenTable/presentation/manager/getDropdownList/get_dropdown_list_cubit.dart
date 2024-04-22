import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_dropdown_list_state.dart';

class GetDropdownListCubit extends Cubit<GetDropdownListState> {
  GetDropdownListCubit() : super(GetDropdownListInitial());
}
