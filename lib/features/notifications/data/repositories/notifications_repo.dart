import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/notifications_model.dart';
import '../models/pages_for_notifications_model.dart';

abstract class NotificationsRepo {
  Future<Either<Failure, List<PagesForNotificationsModel>>>
      getPagesNotifications();
  Future<Either<Failure, NotificationsModel>> getNotifications(
      {required Map<String, dynamic> body});
}
