import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerEmail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: CustomTextFormField(
            label: "Email",
            controller: controllerEmail,
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        CustomButton(
            text: "Reset Password",
            onTap: () async {
              if (formKey.currentState!.validate()) {
                GoRouter.of(context).pop();
              } else {
                autoValidateMode = AutovalidateMode.always;
                setState(() {});
              }
            }),
      ],
    );
  }
}
