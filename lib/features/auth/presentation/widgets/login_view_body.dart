import 'package:erp_system/core/utils/app_assets.dart';
import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/app_styles.dart';
import 'package:erp_system/features/auth/presentation/widgets/login_view_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/alert_dialog.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../generated/l10n.dart';
import 'container_custom_clipper.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        ClipPath(
          clipper: ContainerCustomClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * .52,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
                  AppColors.blueDark,
                  AppColors.blueLight,
                ],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    S.of(context).welcome,
                    textAlign: TextAlign.center,
                    style: AppStyles.textStyle32,
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      AppAssets.logo,
                      height: 170,
                      width: 170,
                    ),
                    Text(
                      S.of(context).dynamic_pro,
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyle20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
                    title: "Change Host",
                    desc:
                        "Once you click OK, the current host will be automatically deleted permanently.",
                    onPressed: () {
                      Pref.saveStringToPref(key: AppStrings.hostKey, value: '');
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
