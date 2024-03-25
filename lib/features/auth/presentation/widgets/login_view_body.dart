import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/features/auth/presentation/widgets/login_view_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/alert_dialog.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../generated/l10n.dart';
import 'login_view_header.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        const LoginViewHeader(),
        const LoginViewForm(),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 12, start: 8),
            child: TextButton(
              onPressed: () {
                CustomAlertDialog.alertWithButton(
                    context: context,
                    type: AlertType.warning,
                    title: S.of(context).change_host,
                    desc: S.of(context).change_host_description,
                    onPressed: () {
                      Pref.saveStringToPref(key: AppStrings.hostKey, value: '');
                      Pref.saveStringToPref(
                          key: AppStrings.companyIdentifierKey, value: '');
                      GoRouter.of(context).pushReplacement(AppRouter.kHostView);
                    });
              },
              child: Text(
                S.of(context).change_host,
                style: TextStyle(color: AppColors.blueDark.withOpacity(.7)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
