import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/tap_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_page_details_state.dart';

class GetPageDetailsCubit extends Cubit<GetPageDetailsState> {
  GetPageDetailsCubit(this.screenRepo) : super(GetPageDetailsInitial());
  final ScreenRepo screenRepo;
  Future<void> getPageDetails(int pageId) async {
    emit(GetPageDetailsLoading());
    Either<Failure, TapModel> result =
        await screenRepo.getPageDetails(pageID: pageId);
    result.fold((failure) {
      emit(GetPageDetailsFailure(failure.errorMassage));
    }, (tapDetails) {
      emit(GetPageDetailsSuccess(tapDetails));
    });
  }
}
