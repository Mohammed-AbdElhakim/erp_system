part of 'progress_cubit.dart';

sealed class ProgressState extends Equatable {
  const ProgressState();
  @override
  List<Object> get props => [];
}

final class ProgressInitial extends ProgressState {}

final class ProgressLoading extends ProgressState {}

final class ProgressFailure extends ProgressState {
  final String errorMassage;

  const ProgressFailure(this.errorMassage);
}


final class AllProgressSuccess extends ProgressState {
  final List<ProgressModel> listProgress;

  const AllProgressSuccess(this.listProgress);
}


final class AddProgressSuccess extends ProgressState {
}
final class UpdateProgressSuccess extends ProgressState {
}
final class DeleteProgressSuccess extends ProgressState {
}