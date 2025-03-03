import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/project_process_model0.dart';
import '../../../data/models/project_process_model1.dart';
import '../../../data/models/project_process_model2.dart';
import '../../../data/models/project_process_model3.dart';
import '../../../data/repositories/project_process_repo.dart';

part 'project_process_state.dart';

class ProjectProcessCubit extends Cubit<ProjectProcessState> {
  ProjectProcessCubit(this.projectProcessRepo) : super(ProjectProcessInitial());
  final ProjectProcessRepo projectProcessRepo;

  Future<void> getTableProjectProcess({
    required Map<String, dynamic> objectData,
    required String link,
    required int numberOfPage,
    required int dropdownValueOfLimit,
    required int selectTab,
  }) async {
    emit(ProjectProcessLoading());
    Either<Failure, Map<String, dynamic>> result = await projectProcessRepo
        .getTableProjectProcess(objectData: objectData, link: link);
    result.fold((failure) {
      emit(ProjectProcessFailure(failure.errorMassage));
    }, (projectProcessModel) {
      if (selectTab == 0) {
        ProjectProcessModel0 projectProcessModel0 =
            ProjectProcessModel0.fromJson(projectProcessModel);
        emit(ProjectProcessSuccess(
            projectProcessModel: projectProcessModel0,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 1) {
        ProjectProcessModel1 projectProcessModel1 =
            ProjectProcessModel1.fromJson(projectProcessModel);
        emit(ProjectProcessSuccess(
            projectProcessModel: projectProcessModel1,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 2) {
        ProjectProcessModel2 projectProcessModel2 =
            ProjectProcessModel2.fromJson(projectProcessModel);
        emit(ProjectProcessSuccess(
            projectProcessModel: projectProcessModel2,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 3) {
        ProjectProcessModel3 projectProcessModel3 =
            ProjectProcessModel3.fromJson(projectProcessModel);
        emit(ProjectProcessSuccess(
            projectProcessModel: projectProcessModel3,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
    });
  }
}
