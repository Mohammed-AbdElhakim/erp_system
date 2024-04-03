import 'package:erp_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../generated/l10n.dart';
import '../../utils/constants.dart';

class CustomAlertDialog {
  static alertWithButton({
    required BuildContext context,
    required AlertType type,
    required String title,
    required String desc,
    String? textButton,
    void Function()? onPressed,
    bool isOverlayTapDismiss = true,
    bool isCloseButton = true,
  }) {
    return Alert(
      context: context,
      type: type,
      title: title,
      desc: desc,
      style: AlertStyle(
          titleStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.blueLight),
          descStyle: const TextStyle(
            fontSize: 18,
          ),
          isOverlayTapDismiss: isOverlayTapDismiss,
          isCloseButton: isCloseButton),
      buttons: [
        DialogButton(
          onPressed: onPressed ??
              () {
                Navigator.pop(context);
              },
          gradient: gradientButton,
          width: 120,
          color: AppColors.blueDark,
          child: Text(
            textButton ?? S.of(context).ok,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
    ).show();
  }
}
