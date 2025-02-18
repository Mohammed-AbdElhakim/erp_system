import 'package:flutter/material.dart';

import 'app_colors.dart';

const viewPadding1 = EdgeInsets.symmetric(horizontal: 24, vertical: 12);
const viewPadding2 = EdgeInsets.only(top: 30, left: 24, right: 24);
LinearGradient gradientButton = LinearGradient(
  begin: AlignmentDirectional.topCenter,
  end: AlignmentDirectional.bottomCenter,
  colors: [
    AppColors.blueLight,
    AppColors.blueDark,
  ],
);
LinearGradient gradientButtonCancel = LinearGradient(
  begin: AlignmentDirectional.topCenter,
  end: AlignmentDirectional.bottomCenter,
  colors: [
    AppColors.grey,
    // AppColors.grey.withOpacity(.2),
    AppColors.grey.withAlpha(51),
  ],
);

LinearGradient gradientContainer = LinearGradient(
  begin: AlignmentDirectional.topStart,
  end: AlignmentDirectional.bottomEnd,
  colors: [
    AppColors.blueDark,
    AppColors.blueLight,
  ],
);
