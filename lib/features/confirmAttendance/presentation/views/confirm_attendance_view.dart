import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/repositories/confirm_attendance_repo_impl.dart';
import '../manager/confirmAttendance/confirm_attendance_cubit.dart';
import '../manager/getDataConfirmAttendance/confirm_attendance_cubit.dart';
import 'confirm_attendance_view_body.dart';

class ConfirmAttendanceView extends StatefulWidget {
  const ConfirmAttendanceView({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<ConfirmAttendanceView> createState() => _ConfirmAttendanceViewState();
}

class _ConfirmAttendanceViewState extends State<ConfirmAttendanceView> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        appBar: CustomAppBar(
          isPortrait: isOrientationPortrait(context),
          isTitleInPortrait: true,
          title: lang == AppStrings.enLangKey ? widget.pageData.nameEn : widget.pageData.nameAr,
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetDataConfirmAttendanceCubit(getIt.get<ConfirmAttendanceRepoImpl>()),
            ),
            BlocProvider(
              create: (context) => ConfirmAttendanceCubit(getIt.get<ConfirmAttendanceRepoImpl>()),
            ),
          ],
          child: const ConfirmAttendanceViewBody(),
        ),
      ),
    );
  }
}
