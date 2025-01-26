part of 'profile_data_cubit.dart';

sealed class ProfileDataState extends Equatable {
  const ProfileDataState();
  @override
  List<Object> get props => [];
}

final class ProfileDataInitial extends ProfileDataState {}

final class ProfileDataLoading extends ProfileDataState {}

final class ProfileDataFailure extends ProfileDataState {
  final String errorMassage;

  const ProfileDataFailure(this.errorMassage);
}

final class ProfileDataSuccess extends ProfileDataState {
  final ProfileModel profileModel;

  const ProfileDataSuccess(this.profileModel);
}
