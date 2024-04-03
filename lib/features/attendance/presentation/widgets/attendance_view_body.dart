import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/attendance/presentation/manager/attendanceCubit/attendance_cubit.dart';
import 'package:erp_system/features/attendance/presentation/widgets/pending_admin_or_inValid.dart';
import 'package:erp_system/features/attendance/presentation/widgets/presence_and_departure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';

class AttendanceViewBody extends StatelessWidget {
  const AttendanceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceCubit, AttendanceState>(
      builder: (context, state) {
        if (state is ValidDeviceSuccess) {
          if (state.validDeviceModel.status == "Valid") {
            return const PresenceAndDeparture();
          } else if (state.validDeviceModel.status == "PendingAdmin") {
            return PendingAdminORInValid(
              massage: S.of(context).massage_permission,
            );
          } else {
            return PendingAdminORInValid(
              massage: S.of(context).massage_no_permission,
            );
          }
        } else if (state is AttendanceFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
