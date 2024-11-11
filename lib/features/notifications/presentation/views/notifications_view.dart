import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/features/notifications/data/repositories/notifications_repo_impl.dart';
import 'package:erp_system/features/notifications/presentation/manager/pagesNotifications/pages_notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../generated/l10n.dart';
import '../../../bottomNavigationBar/presentation/widgets/my_drawer.dart';
import '../widgets/notifications_view_body.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key, this.studentId});

  final int? studentId;

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PagesNotificationsCubit(getIt.get<NotificationsRepoImpl>())
            ..getPagesNotifications(),
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: CustomAppBar(
          isPortrait: isOrientationPortrait(context),
          title: S.of(context).notifications,
          isTitleInPortrait: true,
        ),
        body: const NotificationsViewBody(),
      ),
    );
  }
}
