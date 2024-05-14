import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/permission_model.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_permissions_state.dart';

class GetPermissionsCubit extends Cubit<GetPermissionsState> {
  GetPermissionsCubit(this.screenRepo) : super(GetPermissionsInitial());
  final ScreenRepo screenRepo;
  Future<void> getPagePermissions(String pageId) async {
    emit(GetPermissionLoading());
    Either<Failure, PermissionModel> result =
        await screenRepo.getPagePermissions(pageId);
    result.fold((failure) {
      emit(GetPermissionFailure(failure.errorMassage));
    }, (permission) {
      emit(GetPermissionSuccess(permission));
    });
  }
}
