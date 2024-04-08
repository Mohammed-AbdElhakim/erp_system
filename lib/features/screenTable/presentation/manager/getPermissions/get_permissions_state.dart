part of 'get_permissions_cubit.dart';

sealed class GetPermissionsState extends Equatable {
  const GetPermissionsState();
  @override
  List<Object> get props => [];
}

final class GetPermissionsInitial extends GetPermissionsState {}

final class GetPermissionLoading extends GetPermissionsState {}

final class GetPermissionFailure extends GetPermissionsState {
  final String errorMassage;

  const GetPermissionFailure(this.errorMassage);
}

final class GetPermissionSuccess extends GetPermissionsState {
  final PermissionModel permissionModel;

  const GetPermissionSuccess(this.permissionModel);
}
