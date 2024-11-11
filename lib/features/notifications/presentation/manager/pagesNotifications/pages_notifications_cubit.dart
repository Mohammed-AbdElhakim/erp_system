import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/pages_for_notifications_model.dart';
import '../../../data/repositories/notifications_repo.dart';

part 'pages_notifications_state.dart';

class PagesNotificationsCubit extends Cubit<PagesNotificationsState> {
  PagesNotificationsCubit(this.notificationsRepo)
      : super(PagesNotificationsInitial());
  final NotificationsRepo notificationsRepo;
  Future<void> getPagesNotifications() async {
    emit(PagesNotificationsLoading());
    Either<Failure, List<PagesForNotificationsModel>> result =
        await notificationsRepo.getPagesNotifications();
    result.fold((failure) {
      emit(PagesNotificationsFailure(failure.errorMassage));
    }, (result) {
      emit(PagesNotificationsSuccess(result));
    });
  }
}
