import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/app_router.dart';
import 'package:erp_system/core/utils/constants.dart';
import 'package:erp_system/core/widgets/custom_button.dart';
import 'package:erp_system/features/auth/presentation/widgets/login_view_form.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewPadding2,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 12),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: CustomButton(
                  text: "Change Hods",
                  width: 100,
                  height: 35,
                  textStyle: const TextStyle(fontSize: 14, color: Colors.white),
                  onTap: () {
                    GoRouter.of(context).pushReplacement(AppRouter.kHostView);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35, top: 50),
              child: Text(
                "ERP System",
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
          ],
        ),
      ),
    );
  }
}
