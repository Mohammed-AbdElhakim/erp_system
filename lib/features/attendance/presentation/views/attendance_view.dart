import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/features/attendance/data/repositories/attendance_repo_impl.dart';
import 'package:erp_system/features/attendance/presentation/manager/attendanceCubit/attendance_cubit.dart';
import 'package:erp_system/features/attendance/presentation/widgets/attendance_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_container.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key, required this.pageData});
  final Pages pageData;

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceCubit(
        getIt.get<AttendanceRepoImpl>(),
      )..checkValidDevice(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            CustomContainer(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  lang == AppStrings.enLangKey
                      ? widget.pageData.nameEn
                      : widget.pageData.nameAr,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle26,
                ),
              ),
            ),
            const AttendanceViewBody(),
          ],
        ),
      ),
    );
  }
}