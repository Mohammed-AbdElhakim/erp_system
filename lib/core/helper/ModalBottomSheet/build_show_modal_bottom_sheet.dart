import 'package:erp_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

buildShowModalBottomSheet({
  required BuildContext context,
  required String textButton1,
  required String textButton2,
  required Function() onTapButton1,
  required Function() onTapButton2,
}) {
  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.black38,
    backgroundColor: AppColors.white.withOpacity(.01),
    enableDrag: false,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    isDismissible: false,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onTapButton1,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: AppColors.white,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(
                textButton1,
                style: TextStyle(fontSize: 18, color: AppColors.blueDark),
              ),
            ),
          ),
          Divider(
              color: AppColors.blueGreyDark.withOpacity(.7),
              height: 1,
              thickness: 1.5),
          GestureDetector(
            onTap: onTapButton2,
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                color: AppColors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                textButton2,
                style: TextStyle(fontSize: 18, color: AppColors.blueDark),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(
                S.of(context).cancel,
                style: TextStyle(fontSize: 18, color: AppColors.blueDark),
              ),
            ),
          ),
        ],
      );
    },
  );
}
