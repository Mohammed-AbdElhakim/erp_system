import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/notifications/data/repositories/notifications_repo_impl.dart';
import 'package:erp_system/features/notifications/presentation/manager/notifications/notifications_cubit.dart';
import 'package:erp_system/features/notifications/presentation/manager/pagesNotifications/pages_notifications_cubit.dart';
import 'package:erp_system/features/notifications/presentation/views/sub_notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/models/pages_for_notifications_model.dart';

class NotificationsViewBody extends StatefulWidget {
  const NotificationsViewBody({super.key});
  @override
  State<NotificationsViewBody> createState() => _NotificationsViewBodyState();
}

class _NotificationsViewBodyState extends State<NotificationsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<PagesNotificationsCubit, PagesNotificationsState>(
        builder: (context, state) {
          if (state is PagesNotificationsSuccess) {
            List<PagesForNotificationsModel> pagesNotificationsList = [];
            for (var page in state.pagesNotificationsModel) {
              if (page.isAlarm == true) {
                pagesNotificationsList.add(page);
              }
            }
            return OrientationBuilder(
              builder: (context, orientation) {
                int crossAxisCount =
                    orientation == Orientation.portrait ? 2 : 4;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    // crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 5 / 2.2,
                  ),
                  padding: const EdgeInsets.all(10),
                  itemCount: pagesNotificationsList.length,
                  itemBuilder: (context, index) {
                    PagesForNotificationsModel pagesForNotificationsModel =
                        pagesNotificationsList[index];
                    Map<String, dynamic> body = {
                      "pageId": pagesForNotificationsModel.pageId,
                      "primary": pagesForNotificationsModel.primary,
                      "tableName": pagesForNotificationsModel.tableName,
                    };
                    return BlocProvider(
                      create: (context) =>
                          NotificationsCubit(getIt.get<NotificationsRepoImpl>())
                            ..getNotifications(body: body),
                      child:
                          BlocBuilder<NotificationsCubit, NotificationsState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubNotificationsView(
                                    pagesForNotificationsModel:
                                        pagesForNotificationsModel,
                                    body: body,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              alignment: AlignmentDirectional.centerStart,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.blueLight),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.grey.withOpacity(.8),
                                      offset: const Offset(-2, 2),
                                      blurRadius: 2,
                                      spreadRadius: 1)
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Text(
                                      pagesForNotificationsModel
                                          .pageNotification!.pageDisplay!,
                                      style:
                                          TextStyle(color: AppColors.blueDark),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: CircleAvatar(
                                        radius: 13,
                                        child: Text(
                                          state is NotificationsSuccess
                                              ? "${state.notificationsModel.numberofrecords}"
                                              : "",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: AppColors.blueLight),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is PagesNotificationsFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
