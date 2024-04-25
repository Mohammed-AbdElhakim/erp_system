import 'package:flutter/material.dart';

bool isOrientationPortrait(BuildContext context) {
  Orientation orientation = MediaQuery.of(context).orientation;
  bool isPortrait = orientation == Orientation.portrait;
  return isPortrait;
}
