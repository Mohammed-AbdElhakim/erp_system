import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';

class HostViewForm extends StatefulWidget {
  const HostViewForm({super.key});

  @override
  State<HostViewForm> createState() => _HostViewFormState();
}

class _HostViewFormState extends State<HostViewForm> {
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String host = '', companyIdentifier = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      autovalidateMode: autoValidateMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              hintText: S.of(context).host_view,
              onSaved: (value) {
                host = value!;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hintText: S.of(context).company_identifier,
              onSaved: (value) {
                companyIdentifier = value!;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              width: 150,
              text: S.of(context).ok,
              onTap: () {
                if (formState.currentState!.validate()) {
                  formState.currentState!.save();
                  Pref.saveStringToPref(key: AppStrings.hostKey, value: host);
                  Pref.saveStringToPref(
                      key: AppStrings.companyIdentifierKey,
                      value: companyIdentifier);
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
