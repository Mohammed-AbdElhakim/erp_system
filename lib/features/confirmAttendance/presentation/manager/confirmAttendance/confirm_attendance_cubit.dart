import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/confirm_attendance_repo.dart';

part 'confirm_attendance_state.dart';

class ConfirmAttendanceCubit extends Cubit<ConfirmAttendanceState> {
  ConfirmAttendanceCubit(this.confirmAttendanceRepo) : super(ConfirmAttendanceInitial());
  final ConfirmAttendanceRepo confirmAttendanceRepo;

  Future<void> confirmAttendance({
    required List<Map<String, dynamic>> bodyRequest,
  }) async {
    emit(ConfirmAttendanceLoading());
    Either<Failure, String> result = await confirmAttendanceRepo.confirmAttendance(bodyRequest: bodyRequest);
    result.fold((failure) {
      emit(ConfirmAttendanceFailure(failure.errorMassage));
    }, (dataList) {
      emit(const ConfirmAttendanceSuccess());
    });
  }
}
