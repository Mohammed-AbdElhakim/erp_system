import 'package:erp_system/features/auth/presentation/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/change_status_bar_color.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChangeStatusBarColor(
      child: Scaffold(
        body: LoginViewBody(),
      ),
    );
  }
}
