import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/features/screenTable/data/models/tap_model.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getPageDetailsTable/get_page_details_table_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/repositories/screen_repo_impl.dart';
import 'tap_details_widget_body.dart';

class TapDetailsWidget extends StatelessWidget {
  const TapDetailsWidget(
      {super.key, required this.tap, required this.pageData, required this.id});

  final ListTaps tap;
  final Pages pageData;
  final String id;

  @override
  Widget build(BuildContext context) {

    return ExpansionTile(
      collapsedShape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Text(
        tap.displayArabic,
        style: AppStyles.textStyle18.copyWith(color: Colors.black),
      ),
      backgroundColor: AppColors.blueGreyLight.withOpacity(.3),
      collapsedBackgroundColor: AppColors.blueGreyLight,
      children: [
        BlocProvider(
          create: (context) =>
              GetPageDetailsTableCubit(getIt.get<ScreenRepoImpl>())
                ..getPageDetailsTable(
                    tapData: ListTaps(
                      pageID: tap.pageID,
                      pageDisplay: tap.pageDisplay,
                      masterName: tap.masterName,
                      modulName: tap.modulName,
                      masterID: tap.masterID,
                      modulID: tap.modulID,
                      detailId: tap.detailId,
                      listName: tap.listName,
                      tableName: tap.tableName,
                      primary: tap.primary,
                      controllerName: tap.controllerName,
                      tableSrc: tap.tableSrc,
                      editSrc: tap.editSrc,
                      isCompany: tap.isCompany,
                      companyName: tap.companyName,
                      showPrint: tap.showPrint,
                      showExport: tap.showExport,
                      showSearch: tap.showSearch,
                      showEdit: tap.showEdit,
                      showDelete: tap.showDelete,
                      showRowPrint: tap.showRowPrint,
                      showNew: tap.showNew,
                      searchFirst: tap.searchFirst,
                      showSetting: tap.showSetting,
                      showMasterButton: tap.showMasterButton,
                      canDrag: tap.canDrag,
                      canGroup: tap.canGroup,
                      showSum: tap.showSum,
                      showColumnSetting: tap.showColumnSetting,
                      showRefersh: tap.showRefersh,
                      canSort: tap.canSort,
                      showPaging: tap.showPaging,
                      showGroup: tap.showGroup,
                      dataSourceApi: tap.dataSourceApi,
                      limit: 10,
                      orderBy: tap.orderBy,
                      tailCondition: tap.tailCondition,
                      master: tap.master,
                      foreignKey: tap.foreignKey,
                      foreignKeyValue: tap.foreignKeyValue,
                      groupLayout: tap.groupLayout,
                      groupColumn: tap.groupColumn,
                      outSiderGroupColumn: tap.outSiderGroupColumn,
                      editOnly: tap.editOnly,
                      listMaster: tap.listMaster,
                      excel: tap.excel,
                      excelNew: tap.excelNew,
                      showInPopUp: tap.showInPopUp,
                      pageAttributeId: tap.pageAttributeId,
                      displayArabic: tap.displayArabic,
                      displayEnglish: tap.displayEnglish,
                      displayChinese: tap.displayChinese,
                      columnColor: tap.columnColor,
                      enName: tap.enName,
                      isDesc: tap.isDesc,
                      unaryColumn: tap.unaryColumn,
                      numberOfEmptyRow: tap.numberOfEmptyRow,
                      offset: 0,
                      statment: "and ${tap.foreignKey}  =  $id ",
                    ),
                    numberOfPage: 1,
                    dropdownValueOfLimit: 10),
          child: TapDetailsWidgetBody(
            id: id,
            pageData: pageData,
            tap: tap,
          ),
        )
      ],
    );
  }
}
