import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/profile_model.dart';
import '../../../data/repositories/profile_repo.dart';

part 'profile_data_state.dart';

class ProfileDataCubit extends Cubit<ProfileDataState> {
  ProfileDataCubit(this.profileRepo) : super(ProfileDataInitial());

  final ProfileRepo profileRepo;
  Future<void> getProfileData() async {
    emit(ProfileDataLoading());
    Either<Failure, ProfileModel> result = await profileRepo.getProfileData();
    result.fold((failure) {
      emit(ProfileDataFailure(failure.errorMassage));
    }, (result) {
      emit(ProfileDataSuccess(result));
    });
  }
}
