part of 'list_setup_cubit.dart';

sealed class ListSetupState extends Equatable {
  const ListSetupState();

  @override
  List<Object> get props => [];
}

final class ListSetupInitial extends ListSetupState {}

final class ListSetupLoading extends ListSetupState {}

final class ListSetupFailure extends ListSetupState {
  final String errorMassage;

  const ListSetupFailure(this.errorMassage);
}

final class ListSetupSuccess extends ListSetupState {
  final List<dynamic> data;

  const ListSetupSuccess(this.data);
}
