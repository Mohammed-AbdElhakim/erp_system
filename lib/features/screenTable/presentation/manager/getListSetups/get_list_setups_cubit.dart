import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_list_setups_state.dart';

class GetListSetupsCubit extends Cubit<GetListSetupsState> {
  GetListSetupsCubit() : super(GetListSetupsInitial());
}
