import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_by_id_state.dart';

class GetByIdCubit extends Cubit<GetByIdState> {
  GetByIdCubit() : super(GetByIdInitial());
}
