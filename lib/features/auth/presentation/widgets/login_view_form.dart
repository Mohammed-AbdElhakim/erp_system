import 'package:erp_system/features/auth/presentation/manager/loginCubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';

class LoginViewForm extends StatefulWidget {
  const LoginViewForm({super.key});

  @override
  State<LoginViewForm> createState() => _LoginViewFormState();
}

class _LoginViewFormState extends State<LoginViewForm> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String userName = '', password = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Form(
          key: formState,
          autovalidateMode: autoValidateMode,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextFormField(
                  hintText: S.of(context).username_or_email,
                  onSaved: (value) {
                    userName = value!;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormField(
                  hintText: S.of(context).password,
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CustomButton(
                    text: S.of(context).login,
                    width: 150,
                    height: 35,
                    onTap: () {
                      // if (formState.currentState!.validate()) {
                      //   formState.currentState!.save();
                      //   BlocProvider.of<LoginCubit>(context)
                      //       .loginUser(
                      //     username: userName,
                      //     password: password,
                      //   )
                      //       .then((value) {
                      //     if (state is LoginSuccess) {
                      //       Pref.saveBoolToPref(
                      //           key: AppStrings.isLoginKey, value: true);
                      //       GoRouter.of(context)
                      //           .pushReplacement(AppRouter.kHomeView);
                      //     } else if (state is LoginFailure) {
                      //       showDialog(
                      //         context: context,
                      //         builder: (context) => CustomErrorMassage(
                      //             errorMassage: state.errorMassage),
                      //       );
                      //     } else {
                      //       showDialog(
                      //         context: context,
                      //         builder: (context) => const CustomLoadingWidget(),
                      //       );
                      //     }
                      //   });
                      // } else {
                      //   autoValidateMode = AutovalidateMode.always;
                      //   setState(() {});
                      // }
                      Pref.saveBoolToPref(
                          key: AppStrings.isLoginKey, value: true);
                      GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
