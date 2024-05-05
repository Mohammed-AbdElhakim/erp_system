part of 'delete_cubit.dart';

sealed class DeleteState extends Equatable {
  const DeleteState();
  @override
  List<Object> get props => [];
}

final class DeleteInitial extends DeleteState {}

final class DeleteLoading extends DeleteState {}

final class DeleteFailure extends DeleteState {
  final String errorMassage;

  const DeleteFailure(this.errorMassage);
}

final class DeleteSuccess extends DeleteState {}
