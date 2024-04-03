import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/features/attendance/data/repositories/attendance_repo_impl.dart';
import 'package:erp_system/features/attendance/presentation/manager/attendanceCubit/attendance_cubit.dart';
import 'package:erp_system/features/attendance/presentation/widgets/attendance_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceView extends StatelessWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceCubit(
        getIt.get<AttendanceRepoImpl>(),
      )..checkValidDevice(),
      child: const AttendanceViewBody(),
    );
  }
}
