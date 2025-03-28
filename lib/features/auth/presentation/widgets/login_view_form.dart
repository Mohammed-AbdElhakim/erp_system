import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../manager/loginCubit/login_cubit.dart';

class LoginViewForm extends StatefulWidget {
  const LoginViewForm({super.key});

  @override
  State<LoginViewForm> createState() => _LoginViewFormState();
}

class _LoginViewFormState extends State<LoginViewForm> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String userName = '', password = '';
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
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
              obscureText: obscureText,
              prefixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon:
                    Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              ),
              onSaved: (value) {
                password = value!;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Pref.saveStringToPref(
                        key: AppStrings.tokenKey,
                        value: state.loginModel.token);
                    Pref.saveStringToPref(
                        key: AppStrings.userNameKey,
                        value: state.loginModel.userName);
                    Pref.saveStringToPref(
                        key: AppStrings.companyIDKey,
                        value: state.loginModel.companyID);
                    Pref.saveStringToPref(
                        key: AppStrings.companyNameKey,
                        value: state.loginModel.companyName);
                    Pref.saveStringToPref(
                        key: AppStrings.employeeIDKey,
                        value: state.loginModel.employeeID);
                    Pref.saveBoolToPref(
                        key: AppStrings.isLoginKey, value: true);
                    GoRouter.of(context)
                        .pushReplacement(AppRouter.kBottomNavigationBarView);
                  } else if (state is LoginFailure) {
                    CustomAlertDialog.alertWithButton(
                        context: context,
                        type: AlertType.error,
                        title: S.of(context).error,
                        desc: state.errorMassage);
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const CustomLoadingWidget();
                  } else {
                    return CustomButton(
                      text: S.of(context).login,
                      width: 150,
                      height: 35,
                      onTap: () {
                        if (formState.currentState!.validate()) {
                          formState.currentState!.save();
                          BlocProvider.of<LoginCubit>(context).loginUser(
                            username: userName,
                            password: password,
                          );
                          // GoRouter.of(context)
                          //     .pushReplacement(AppRouter.kHomeView);
                          // Pref.saveBoolToPref(
                          //     key: AppStrings.isLoginKey, value: true);
                        } else {
                          autoValidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
