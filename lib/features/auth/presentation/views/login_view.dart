import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/features/auth/presentation/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primary,
      ),
      body: const LoginViewBody(),
    );
  }
}
