import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/home_view_body.dart';
import '../../data/models/pages_for_notifications_model.dart';
import 'notification_list_item.dart';

class SubNotificationsViewBody extends StatelessWidget {
  const SubNotificationsViewBody(
      {super.key, required this.notificationListItem, required this.pagesForNotificationsModel});
  final List<Map<String, dynamic>> notificationListItem;
  final PagesForNotificationsModel pagesForNotificationsModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: notificationListItem.isNotEmpty
          ? ListView.separated(
              itemCount: notificationListItem.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              itemBuilder: (context, index) {
                return NotificationListItem(
                  onTap: () {
                    Pages? page = getPage(pagesForNotificationsModel.pageID);
                    if (page != null) {
                      GoRouter.of(context).push(AppRouter.kScreenView,
                          extra: getPage(pagesForNotificationsModel.pageID));
                    } else {
                      CustomAlertDialog.alertWithButton(
                          context: context,
                          type: AlertType.error,
                          title: S.of(context).error,
                          textButton: S.of(context).ok,
                          desc: "الصفحة غير متوفرة",
                          onPressed: () {
                            Navigator.of(context).pop();
                          });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${notificationListItem[index]['${pagesForNotificationsModel.viewEmployeeColumn}'] ?? ""}"),
                    ],
                  ),
                );
              },
            )
          : const Center(
              child: Text("لا يوجد اشعارات"),
            ),
    );
  }

  Pages? getPage(int? pageId) {
    for (var page in HomeViewBody.pagesList) {
      if (page.pageId == pageId) {
        return page;
      }
    }
    return null;
  }
}
