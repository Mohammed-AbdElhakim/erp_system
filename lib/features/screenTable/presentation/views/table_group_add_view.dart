import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/screen_model.dart';
import '../widgets/table_group_add_view_body.dart';

class TableGroupAddView extends StatelessWidget {
  const TableGroupAddView(
      {super.key,
      required this.columnList,
      required this.pageData,
      required this.listKey});
  final List<ColumnList> columnList;
  final Pages pageData;

  final List<dynamic> listKey;

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        appBar: const CustomAppBar(
          isPortrait: true,
          title: "",
        ),
        body: TableGroupAddViewBody(
          pageData: pageData,
          columnList: columnList,
          listKey: listKey,
        ),
      ),
    );
  }
}
