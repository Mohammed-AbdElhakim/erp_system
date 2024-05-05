part of 'delete_cubit.dart';

sealed class DeleteState extends Equatable {
  const DeleteState();
}

final class DeleteInitial extends DeleteState {
  @override
  List<Object> get props => [];
}
