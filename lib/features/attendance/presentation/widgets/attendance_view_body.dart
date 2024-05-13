import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../manager/attendanceCubit/attendance_cubit.dart';
import 'pending_admin_or_in_valid.dart';
import 'presence_and_departure.dart';

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
