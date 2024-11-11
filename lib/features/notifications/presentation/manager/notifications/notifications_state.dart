part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();
  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsFailure extends NotificationsState {
  final String errorMassage;

  const NotificationsFailure(this.errorMassage);
}

final class NotificationsSuccess extends NotificationsState {
  final NotificationsModel notificationsModel;

  const NotificationsSuccess(this.notificationsModel);
}
