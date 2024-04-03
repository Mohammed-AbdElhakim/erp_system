import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../generated/l10n.dart';
import '../manager/attendanceCubit/attendance_cubit.dart';

class PendingAdminORInValid extends StatelessWidget {
  const PendingAdminORInValid({
    super.key,
    required this.massage,
  });
  final String massage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(textAlign: TextAlign.center, massage),
          ),
          const SizedBox(height: 50),
          CustomButton(
            text: massage == S.of(context).massage_permission
                ? S.of(context).refresh
                : S.of(context).back,
            width: 110,
            onTap: () {
              if (massage == S.of(context).massage_permission) {
                BlocProvider.of<AttendanceCubit>(context).checkValidDevice();
              } else {
                GoRouter.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
