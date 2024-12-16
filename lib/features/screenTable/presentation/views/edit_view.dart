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
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/screen_model.dart';
import '../widgets/tableSrcPageDetails/addOrEditExcel/edit_excel_view_body.dart';
import '../widgets/tableSrcPageDetails/addSalesEdit/edit_sales.dart';
import '../widgets/tableSrcPageDetails/extractionSupplierTable/edit_extraction_supplier_table.dart';
import '../widgets/tableSrcPageDetails/productProcess/edit_product_process.dart';
import '../widgets/tableSrcPageDetails/productProcessOut/edit_product_process_out.dart';
import '../widgets/tableSrcPageDetails/productionProsecc/edit_production_prosecc.dart';
import '../widgets/tableSrcPageDetails/purchases/edit_purchases.dart';

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
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
          appBar: const CustomAppBar(
            isPortrait: true,
            title: "",
          ),
          body: BlocProvider(
            create: (context) =>
                GetPageDetailsCubit(getIt.get<ScreenRepoImpl>())
                  ..getPageDetails(widget.pageData.pageId),
            child: BlocBuilder<GetPageDetailsCubit, GetPageDetailsState>(
              builder: (context, state) {
                if (state is GetPageDetailsSuccess) {
                  String listName = state.tapModel.list.isEmpty
                      ? ""
                      : state.tapModel.list[0].listName;
                  return BlocProvider(
                    create: (context) =>
                        GetListSetupsCubit(getIt.get<ScreenRepoImpl>())
                          ..getListSetups(listName),
                    child: getMyWidget(
                        state.tapModel.list.isEmpty
                            ? ""
                            : state.tapModel.list[0].tableSrc,
                        state),
                  );
                } else if (state is GetPageDetailsFailure) {
                  return CustomErrorMassage(errorMassage: state.errorMassage);
                } else {
                  return const CustomLoadingWidget();
                }
              },
            ),
          )),
    );
  }

  getMyWidget(String tableSrc, GetPageDetailsSuccess state) {
    switch (tableSrc) {
      case "entry":
        return EditExcelViewBody(
          tapData: state.tapModel.list[0],
          pageData: widget.pageData,
          listKey: widget.listKey,
        );
      case "salesDetails":
        return EditSales(
          tapData: state.tapModel.list[0],
          pageData: widget.pageData,
          listKey: widget.listKey,
        );
      case "Purchases":
        return EditPurchases(
          tapData: state.tapModel.list[0],
          pageData: widget.pageData,
          listKey: widget.listKey,
        );
      case "extractionSupplierTable":
        return EditExtractionSupplierTable(
            tapData: state.tapModel.list[0],
            pageData: widget.pageData,
            listKey: widget.listKey);
      case "ProductProcess":
        return EditProductProcess(
            tapData: state.tapModel.list[0],
            pageData: widget.pageData,
            listKey: widget.listKey);
      case "ProductProcessOut":
        return EditProductProcessOut(
            tapData: state.tapModel.list[0],
            pageData: widget.pageData,
            listKey: widget.listKey);
      case "productionProsecc":
        return EditProductionProsecc(
            tapData: state.tapModel.list[0],
            pageData: widget.pageData,
            listKey: widget.listKey);
      default:
        return Center(child: Text("TableSrc Details =>$tableSrc"));
    }
  }
}
