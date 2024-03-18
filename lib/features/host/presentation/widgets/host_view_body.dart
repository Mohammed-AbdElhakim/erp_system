import 'package:erp_system/core/helper/SharedPreferences/pref.dart';
import 'package:erp_system/core/utils/app_router.dart';
import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';

class HostViewBody extends StatefulWidget {
  const HostViewBody({super.key});

  @override
  State<HostViewBody> createState() => _HostViewBodyState();
}

class _HostViewBodyState extends State<HostViewBody> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String host = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: viewPadding,
      child: Form(
        key: formState,
        autovalidateMode: autoValidateMode,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              label: S.of(context).host_view,
              onSaved: (value) {
                host = value!;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              width: 150,
              text: 'ok',
              onTap: () {
                if (formState.currentState!.validate()) {
                  formState.currentState!.save();
                  Pref.saveStringToPref(key: AppStrings.host, value: host);
                  GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
                } else {
                  autoValidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
