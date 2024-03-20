import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/constants.dart';
import 'package:erp_system/features/auth/presentation/widgets/login_view_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/alert_dialog.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewPadding2,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 35, top: 50),
            child: Text(
              "ERP System",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: AppColors.buttonColor,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: FlutterLogo(
              size: 100,
            ),
          ),
          const LoginViewForm(),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 50),
              child: TextButton(
                onPressed: () {
                  CustomAlertDialog.alertWithButton(
                      context: context,
                      type: AlertType.warning,
                      title: "Change Host",
                      desc:
                          "Once you click OK, the current host will be automatically deleted permanently.",
                      onPressed: () {
                        Pref.saveStringToPref(
                            key: AppStrings.hostKey, value: '');
                        GoRouter.of(context)
                            .pushReplacement(AppRouter.kHostView);
                      });
                },
                child: Text(
                  "Change Host",
                  style:
                      TextStyle(color: AppColors.buttonColor.withOpacity(.5)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
