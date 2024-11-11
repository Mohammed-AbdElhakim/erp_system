part of 'pages_notifications_cubit.dart';

sealed class PagesNotificationsState extends Equatable {
  const PagesNotificationsState();
  @override
  List<Object> get props => [];
}

final class PagesNotificationsInitial extends PagesNotificationsState {}

final class PagesNotificationsLoading extends PagesNotificationsState {}

final class PagesNotificationsFailure extends PagesNotificationsState {
  final String errorMassage;

  const PagesNotificationsFailure(this.errorMassage);
}

final class PagesNotificationsSuccess extends PagesNotificationsState {
  final List<PagesForNotificationsModel> pagesNotificationsModel;

  const PagesNotificationsSuccess(this.pagesNotificationsModel);
}
