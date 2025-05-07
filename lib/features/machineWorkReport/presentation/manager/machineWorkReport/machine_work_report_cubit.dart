import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/machine_work_report_model.dart';
import '../../../data/repositories/machine_work_report_repo.dart';

part 'machine_work_report_state.dart';

class MachineWorkReportCubit extends Cubit<MachineWorkReportState> {
  MachineWorkReportCubit(this.machineWorkReportRepo) : super(MachineWorkReportInitial());
  final MachineWorkReportRepo machineWorkReportRepo;

  Future<void> getMachineWorkReport({
    required Map<String, dynamic> bodyRequest,
    required int numberOfPage,
    required int dropdownValueOfLimit,
  }) async {
    emit(MachineWorkReportLoading());
    Either<Failure, MachineWorkReportModel> result = await machineWorkReportRepo.getMachineWorkReport(bodyRequest: bodyRequest);
    result.fold((failure) {
      emit(MachineWorkReportFailure(failure.errorMassage));
    }, (result) {
      emit(
          MachineWorkReportSuccess(dropdownValue: dropdownValueOfLimit, machineWorkReportData: result, numberPage: numberOfPage));
    });
  }
}
