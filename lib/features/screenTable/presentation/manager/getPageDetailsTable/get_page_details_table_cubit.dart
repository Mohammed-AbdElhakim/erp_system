import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_page_details_table_state.dart';

class GetPageDetailsTableCubit extends Cubit<GetPageDetailsTableState> {
  GetPageDetailsTableCubit() : super(GetPageDetailsTableInitial());
}
