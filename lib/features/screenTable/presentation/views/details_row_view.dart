import 'package:erp_system/features/screenTable/presentation/manager/getPageDetails/get_page_details_cubit.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/details_row_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/repositories/screen_repo_impl.dart';

class DetailsRowView extends StatelessWidget {
  const DetailsRowView(
      {super.key, required this.pageData, required this.rowData});
  final Pages pageData;
  final Map<String, dynamic> rowData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetPageDetailsCubit(
        getIt.get<ScreenRepoImpl>(),
      )..getPageDetails(pageData.pageId),
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: const CustomAppBar(
            isPortrait: true,
            title: "",
          ),
          body: DetailsRowViewBody(
            pageData: pageData,
            rowData: rowData,
          ),
        ),
      ),
    );
  }
}
