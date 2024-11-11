import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/notifications/data/repositories/notifications_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/pages_for_notifications_model.dart';
import '../manager/notifications/notifications_cubit.dart';
import '../widgets/sub_notifications_view_body.dart';

class SubNotificationsView extends StatelessWidget {
  const SubNotificationsView(
      {super.key,
      required this.pagesForNotificationsModel,
      required this.body});

  final PagesForNotificationsModel pagesForNotificationsModel;
  final Map<String, dynamic> body;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationsCubit(getIt.get<NotificationsRepoImpl>())
            ..getNotifications(body: body),
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: CustomAppBar(
            isPortrait: isOrientationPortrait(context),
            isTitleInPortrait: true,
            title: pagesForNotificationsModel.pageNotification!.pageDisplay!,
          ),
          body: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsSuccess) {
                List<Map<String, dynamic>> notificationListItem =
                    state.notificationsModel.notificationItem!;
                return SubNotificationsViewBody(
                  notificationListItem: notificationListItem,
                  pagesForNotificationsModel: pagesForNotificationsModel,
                );
              } else if (state is NotificationsFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else {
                return const CustomLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}
