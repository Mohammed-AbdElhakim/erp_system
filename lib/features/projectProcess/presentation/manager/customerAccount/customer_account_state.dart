part of 'customer_account_cubit.dart';

sealed class ProjectProcessState extends Equatable {
  const ProjectProcessState();
  @override
  List<Object> get props => [];
}

final class ProjectProcessInitial extends ProjectProcessState {}

final class ProjectProcessLoading extends ProjectProcessState {}

final class ProjectProcessFailure extends ProjectProcessState {
  final String errorMassage;

  const ProjectProcessFailure(this.errorMassage);
}

final class ProjectProcessSuccess extends ProjectProcessState {
  final dynamic projectProcessModel;
  final int numberPage;
  final int dropdownValue;
  final int selectTap;

  const ProjectProcessSuccess({
    required this.projectProcessModel,
    required this.numberPage,
    required this.dropdownValue,
    required this.selectTap,
  });
}
