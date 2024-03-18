import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

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
    return Form(
      key: formState,
      autovalidateMode: autoValidateMode,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextFormField(
            label: 'Username',
            onSaved: (value) {
              userName = value!;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            label: 'Password',
            onSaved: (value) {
              password = value!;
            },
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () {},
              child: const Text("Forget Password?"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            text: "Login",
            width: 150,
            textStyle: const TextStyle(fontSize: 14, color: Colors.white),
            onTap: () {
              if (formState.currentState!.validate()) {
                formState.currentState!.save();
                Pref.saveBoolToPref(key: AppStrings.isLoginKey, value: true);
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
              } else {
                autoValidateMode = AutovalidateMode.always;
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
