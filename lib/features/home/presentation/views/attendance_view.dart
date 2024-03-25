import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:erp_system/core/widgets/custom_app_bar.dart';
import 'package:erp_system/features/home/presentation/widgets/attendance_view_body.dart';
import 'package:flutter/material.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChangeStatusBarColor(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: AttendanceViewBody(),
      ),
    );
  }
}
