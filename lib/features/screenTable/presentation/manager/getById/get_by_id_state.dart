part of 'get_by_id_cubit.dart';

sealed class GetByIdState extends Equatable {
  const GetByIdState();
  @override
  List<Object> get props => [];
}

final class GetByIdInitial extends GetByIdState {}

final class GetByIdLoading extends GetByIdState {}

final class GetByIdFailure extends GetByIdState {
  final String errorMassage;

  const GetByIdFailure(this.errorMassage);
}

final class GetByIdSuccess extends GetByIdState {
  final Map<String, dynamic> valueGetById;

  const GetByIdSuccess(this.valueGetById);
}
