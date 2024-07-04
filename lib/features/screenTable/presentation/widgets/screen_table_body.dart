import 'package:erp_system/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/menu_model/pages.dart';
import 'mainview/general/table_general.dart';
import 'mainview/group/table_group.dart';

class ScreenTableBody extends StatelessWidget {
  const ScreenTableBody({super.key, required this.pageData});
  final Pages pageData;
  @override
  Widget build(BuildContext context) {
    if (pageData.tableSrc == AppStrings.tableGroup) {
      return TableGroup(
        pageData: pageData,
      );
    } else {
      return TableGeneral(
        pageData: pageData,
      );
    }
  }
}
