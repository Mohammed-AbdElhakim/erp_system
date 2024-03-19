import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomAlertDialog {
  static alertWithButton({
    required BuildContext context,
    required AlertType type,
    required String title,
    required String desc,
    String? textButton,
    void Function()? onPressed,
  }) {
    return Alert(
      context: context,
      type: type,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          onPressed: onPressed ??
              () {
                Navigator.pop(context);
              },
          width: 120,
          child: Text(
            textButton ?? "OK",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
}
