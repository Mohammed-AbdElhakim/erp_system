import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/screen_model.dart';
import '../../data/repositories/screen_repo_impl.dart';
import '../manager/getListSetups/get_list_setups_cubit.dart';
import '../manager/getPageDetails/get_page_details_cubit.dart';
import '../widgets/tableSrcPageDetails/addOrEditExcel/add_excel_view_body.dart';
import '../widgets/tableSrcPageDetails/addSalesEdit/add_sales.dart';
import '../widgets/tableSrcPageDetails/extractionSupplierTable/add_extraction_supplier_table.dart';
import '../widgets/tableSrcPageDetails/productProcess/add_product_process.dart';
import '../widgets/tableSrcPageDetails/productionProsecc/add_production_prosecc.dart';
import '../widgets/tableSrcPageDetails/purchases/add_purchases.dart';

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
                  child: getMyWidget(state.tapModel.list[0].tableSrc, state),
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

  getMyWidget(String tableSrc, GetPageDetailsSuccess state) {
    switch (tableSrc) {
      case "entry":
        return AddExcelViewBody(
          tapData: state.tapModel.list[0],
          pageData: pageData,
          listKey: listKey,
        );
      case "salesDetails":
        return AddSales(
          tapData: state.tapModel.list[0],
          pageData: pageData,
          listKey: listKey,
        );
      case "Purchases":
        return AddPurchases(
          tapData: state.tapModel.list[0],
          pageData: pageData,
          listKey: listKey,
        );
      case "extractionSupplierTable":
        return AddExtractionSupplierTable(
            tapData: state.tapModel.list[0],
            pageData: pageData,
            listKey: listKey);
      case "ProductProcess":
        return AddProductProcess(
            tapData: state.tapModel.list[0],
            pageData: pageData,
            listKey: listKey);

      case "productionProsecc":
        return AddProductionProsecc(
            tapData: state.tapModel.list[0],
            pageData: pageData,
            listKey: listKey);

      default:
        return Center(child: Text("TableSrc Details =>$tableSrc"));
    }
  }
}
