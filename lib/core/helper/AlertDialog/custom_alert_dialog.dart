import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../generated/l10n.dart';
import '../../utils/app_colors.dart';
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

  static alertDelete({
    required BuildContext context,
    required Widget contentButton,
  }) {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: S.of(context).sure,
      desc: S.of(context).massage_delete,
      content: contentButton,
      style: AlertStyle(
          titleStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.blueLight),
          descStyle: const TextStyle(
            fontSize: 18,
          ),
          isButtonVisible: false,
          buttonAreaPadding: const EdgeInsets.symmetric(vertical: 5),
          isOverlayTapDismiss: false,
          isCloseButton: true),
    ).show();
  }

  static alertWithCustomContent({
    required BuildContext context,
    required String title,
    required Widget content,
    bool isOverlayTapDismiss = true,
    bool isCloseButton = true,
  }) {
    return Alert(
      context: context,
      title: title,
      content: content,
      style: AlertStyle(
        titleStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.blueLight),
        isOverlayTapDismiss: isOverlayTapDismiss,
        isCloseButton: isCloseButton,
        isButtonVisible: false,
        alertPadding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        buttonAreaPadding: const EdgeInsets.symmetric(vertical: 5),
        titlePadding: const EdgeInsets.symmetric(vertical: 5),
      ),
    ).show();
  }
}
