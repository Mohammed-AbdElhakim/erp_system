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
