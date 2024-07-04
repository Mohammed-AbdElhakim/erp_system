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
import '../widgets/addEditView/edit_view_body.dart';
import '../widgets/mainview/group/table_group.dart';

class EditView extends StatefulWidget {
  const EditView(
      {super.key,
      required this.columnList,
      required this.pageData,
      required this.listKey});

  final List<ColumnList> columnList;
  final Pages pageData;

  final List<dynamic> listKey;

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  @override
  void dispose() {
    TableGroup.rowData = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
          appBar: const CustomAppBar(
            isPortrait: true,
            title: "",
          ),
          body: widget.pageData.editSrc == AppStrings.addOrEditExcel
              ? BlocProvider(
                  create: (context) =>
                      GetPageDetailsCubit(getIt.get<ScreenRepoImpl>())
                        ..getPageDetails(widget.pageData.pageId),
                  child: BlocBuilder<GetPageDetailsCubit, GetPageDetailsState>(
                    builder: (context, state) {
                      if (state is GetPageDetailsSuccess) {
                        String listName = state.tapModel.list[0].listName;
                        return BlocProvider(
                          create: (context) =>
                              GetListSetupsCubit(getIt.get<ScreenRepoImpl>())
                                ..getListSetups(listName),
                          child: EditViewBody(
                            tapData: state.tapModel.list[0],
                            pageData: widget.pageData,
                            listKey: widget.listKey,
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
                        ..getListSetups(widget.pageData.listName),
                  child: EditViewBody(
                    pageData: widget.pageData,
                    listKey: widget.listKey,
                  ),
                )),
    );
  }
}
