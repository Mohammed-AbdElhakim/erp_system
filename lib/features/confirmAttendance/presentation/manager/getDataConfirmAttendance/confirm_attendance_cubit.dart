import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/confirm_attendance_model.dart';
import '../../../data/repositories/confirm_attendance_repo.dart';

part 'confirm_attendance_state.dart';

class GetDataConfirmAttendanceCubit extends Cubit<GetDataConfirmAttendanceState> {
  GetDataConfirmAttendanceCubit(this.confirmAttendanceRepo) : super(GetDataConfirmAttendanceInitial());
  final ConfirmAttendanceRepo confirmAttendanceRepo;

  Future<void> getDataConfirmAttendance({
    required Map<String, dynamic> bodyRequest,
  }) async {
    emit(GetDataConfirmAttendanceLoading());
    Either<Failure, List<ConfirmAttendanceModel>> result =
        await confirmAttendanceRepo.getDataConfirmAttendanceList(bodyRequest: bodyRequest);
    result.fold((failure) {
      emit(GetDataConfirmAttendanceFailure(failure.errorMassage));
    }, (dataList) {
      emit(GetDataConfirmAttendanceSuccess(dataList));
    });
  }
}
