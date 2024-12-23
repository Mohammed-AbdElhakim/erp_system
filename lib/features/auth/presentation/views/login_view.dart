import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../data/repositories/login/login_repo_impl.dart';
import '../manager/loginCubit/login_cubit.dart';
import '../widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => LoginCubit(
            getIt.get<LoginRepoImpl>(),
          ),
          child: const LoginViewBody(),
        ),
      ),
    );
  }
}
