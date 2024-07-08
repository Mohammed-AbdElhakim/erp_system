import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/screenTable/data/repositories/screen_repo_impl.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getListSetups/get_list_setups_cubit.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getPageDetails/get_page_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/screen_model.dart';
import '../widgets/editSrc/addOrEditExcel/add_excel_view_body.dart';
import '../widgets/editSrc/addSalesEdit/add_sales.dart';

class AddView extends StatelessWidget {
  const AddView(
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
        body: BlocProvider(
          create: (context) => GetPageDetailsCubit(getIt.get<ScreenRepoImpl>())
            ..getPageDetails(pageData.pageId),
          child: BlocBuilder<GetPageDetailsCubit, GetPageDetailsState>(
            builder: (context, state) {
              if (state is GetPageDetailsSuccess) {
                String listName = state.tapModel.list[0].listName;
                return BlocProvider(
                  create: (context) =>
                      GetListSetupsCubit(getIt.get<ScreenRepoImpl>())
                        ..getListSetups(listName),
                  child: getMyWidget(pageData.editSrc, state),
                );
              } else if (state is GetPageDetailsFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else {
                return const CustomLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  getMyWidget(String editSrc, GetPageDetailsSuccess state) {
    switch (editSrc) {
      case AppStrings.addOrEditExcel:
        return AddExcelViewBody(
          tapData: state.tapModel.list[0],
          pageData: pageData,
          listKey: listKey,
        );
      case AppStrings.addSalesEdit:
        return AddSales(
          tapData: state.tapModel.list[0],
          pageData: pageData,
          listKey: listKey,
        );
    }
  }
}

/*pageData.editSrc == AppStrings.addOrEditExcel
              ? BlocProvider(
                  create: (context) =>
                      GetPageDetailsCubit(getIt.get<ScreenRepoImpl>())
                        ..getPageDetails(pageData.pageId),
                  child: BlocBuilder<GetPageDetailsCubit, GetPageDetailsState>(
                    builder: (context, state) {
                      if (state is GetPageDetailsSuccess) {
                        String listName = state.tapModel.list[0].listName;
                        return BlocProvider(
                          create: (context) =>
                              GetListSetupsCubit(getIt.get<ScreenRepoImpl>())
                                ..getListSetups(listName),
                          child: AddExcelViewBody(
                            tapData: state.tapModel.list[0],
                            pageData: pageData,
                            listKey: listKey,
                          ),
                        );
                      } else if (state is GetPageDetailsFailure) {
                        return CustomErrorMassage(
                            errorMassage: state.errorMassage);
                      } else {
                        return const CustomLoadingWidget();
                      }
                    },
                  ),
                )
              : BlocProvider(
                  create: (context) =>
                      GetListSetupsCubit(getIt.get<ScreenRepoImpl>())
                        ..getListSetups(pageData.listName),
                  child: AddExcelViewBody(
                    pageData: pageData,
                    listKey: listKey,
                  ),
                )*/
