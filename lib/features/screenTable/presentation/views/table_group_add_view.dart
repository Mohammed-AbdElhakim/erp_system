import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class TableGroupAddView extends StatelessWidget {
  const TableGroupAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChangeStatusBarColor(
      child: Scaffold(
        appBar: CustomAppBar(
          isPortrait: true,
          title: "",
        ),
        body: Center(
          child: Text("Add"),
        ),
      ),
    );
  }
}