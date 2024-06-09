import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erp_system/features/screenTable/data/models/item_list_setup_model.dart';

part 'get_list_setups_state.dart';

class GetListSetupsCubit extends Cubit<GetListSetupsState> {
  GetListSetupsCubit() : super(GetListSetupsInitial());
}
