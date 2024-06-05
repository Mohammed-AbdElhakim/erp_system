import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_page_details_state.dart';

class GetPageDetailsCubit extends Cubit<GetPageDetailsState> {
  GetPageDetailsCubit() : super(GetPageDetailsInitial());
}
