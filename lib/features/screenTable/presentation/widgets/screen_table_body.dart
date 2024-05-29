import 'package:flutter/material.dart';

import '../../../../core/models/menu_model/pages.dart';
import 'table_general.dart';

class ScreenTableBody extends StatelessWidget {
  const ScreenTableBody({super.key, required this.pageData});
  final Pages pageData;
  @override
  Widget build(BuildContext context) {
    if (pageData.tableSrc == "") {
      return Container();
    } else {
      return TableGeneral(
        pageData: pageData,
      );
    }
  }
}
