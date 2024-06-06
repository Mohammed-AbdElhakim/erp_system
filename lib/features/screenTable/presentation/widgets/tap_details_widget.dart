import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/screenTable/data/models/tap_model.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getPageDetailsTable/get_page_details_table_cubit.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/table_general.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/table_group.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/table_page_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/screen_model.dart';
import '../../data/repositories/screen_repo_impl.dart';
import 'pagination_widget.dart';

class TapDetailsWidget extends StatefulWidget {
  const TapDetailsWidget(
      {super.key, required this.tap, required this.pageData});

  final ListTaps tap;
  final Pages pageData;
  static late String orderBy;
  static late bool isDesc;
  static late int numberPage;
  static late int dropdownValue;

  @override
  State<TapDetailsWidget> createState() => _TapDetailsWidgetState();
}

class _TapDetailsWidgetState extends State<TapDetailsWidget> {
  String? lang;
  late int allPages;
  List<int> listNumberItemInList = [10, 25, 50, 100];
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    TapDetailsWidget.numberPage = 1;
    TapDetailsWidget.isDesc = widget.tap.isDesc!;
    TapDetailsWidget.orderBy = widget.tap.orderBy;
    TapDetailsWidget.dropdownValue = listNumberItemInList[0];
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedShape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Text(
        widget.tap.displayArabic,
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
                        pageID: widget.tap.pageID,
                        pageDisplay: widget.tap.pageDisplay,
                        masterName: widget.tap.masterName,
                        modulName: widget.tap.modulName,
                        masterID: widget.tap.masterID,
                        modulID: widget.tap.modulID,
                        detailId: widget.tap.detailId,
                        listName: widget.tap.listName,
                        tableName: widget.tap.tableName,
                        primary: widget.tap.primary,
                        controllerName: widget.tap.controllerName,
                        tableSrc: widget.tap.tableSrc,
                        editSrc: widget.tap.editSrc,
                        isCompany: widget.tap.isCompany,
                        companyName: widget.tap.companyName,
                        showPrint: widget.tap.showPrint,
                        showExport: widget.tap.showExport,
                        showSearch: widget.tap.showSearch,
                        showEdit: widget.tap.showEdit,
                        showDelete: widget.tap.showDelete,
                        showRowPrint: widget.tap.showRowPrint,
                        showNew: widget.tap.showNew,
                        searchFirst: widget.tap.searchFirst,
                        showSetting: widget.tap.showSetting,
                        showMasterButton: widget.tap.showMasterButton,
                        canDrag: widget.tap.canDrag,
                        canGroup: widget.tap.canGroup,
                        showSum: widget.tap.showSum,
                        showColumnSetting: widget.tap.showColumnSetting,
                        showRefersh: widget.tap.showRefersh,
                        canSort: widget.tap.canSort,
                        showPaging: widget.tap.showPaging,
                        showGroup: widget.tap.showGroup,
                        dataSourceApi: widget.tap.dataSourceApi,
                        limit: 10,
                        orderBy: widget.tap.orderBy,
                        tailCondition: widget.tap.tailCondition,
                        master: widget.tap.master,
                        foreignKey: widget.tap.foreignKey,
                        foreignKeyValue: widget.tap.foreignKeyValue,
                        groupLayout: widget.tap.groupLayout,
                        groupColumn: widget.tap.groupColumn,
                        outSiderGroupColumn: widget.tap.outSiderGroupColumn,
                        editOnly: widget.tap.editOnly,
                        listMaster: widget.tap.listMaster,
                        excel: widget.tap.excel,
                        excelNew: widget.tap.excelNew,
                        showInPopUp: widget.tap.showInPopUp,
                        pageAttributeId: widget.tap.pageAttributeId,
                        displayArabic: widget.tap.displayArabic,
                        displayEnglish: widget.tap.displayEnglish,
                        displayChinese: widget.tap.displayChinese,
                        columnColor: widget.tap.columnColor,
                        enName: widget.tap.enName,
                        isDesc: widget.tap.isDesc,
                        unaryColumn: widget.tap.unaryColumn,
                        numberOfEmptyRow: widget.tap.numberOfEmptyRow,
                        offset: 0),
                    numberOfPage: 1,
                    dropdownValueOfLimit: 10),
          child:
              BlocBuilder<GetPageDetailsTableCubit, GetPageDetailsTableState>(
            builder: (context, state) {
              if (state is GetPageDetailsTableSuccess) {
                int? numberOfRecords = state.screenModel.numberOfRecords;
                List<dynamic>? listData = state.screenModel.dataList;
                List<dynamic>? listSum = state.screenModel.summedColumns;
                List<String> listHeader = [];
                List<dynamic> listKey = [];
                List<ColumnList> listColumn = [];
                List<String> category = [];
                for (var item in state.screenModel.columnList!) {
                  listHeader.add(lang == AppStrings.enLangKey
                      ? item.enColumnLabel!
                      : item.arColumnLabel!);
                  listKey.add(item.columnName);
                  listColumn.add(item);
                  category.add(item.categoryName!);
                }
                TapDetailsWidget.numberPage = state.numberPage;
                TapDetailsWidget.dropdownValue = state.dropdownValue;
                allPages =
                    (numberOfRecords! % TapDetailsWidget.dropdownValue) == 0
                        ? (numberOfRecords ~/ TapDetailsWidget.dropdownValue)
                        : (numberOfRecords ~/ TapDetailsWidget.dropdownValue) +
                            1;
                return SizedBox(
                  height: 300,
                  child: TablePageDetailsWidget(
                    listSum: listSum,
                    listHeader: listHeader,
                    listData: listData!,
                    listKey: listKey,
                    listColumn: listColumn,
                    allDropdownModelList:
                        widget.pageData.tableSrc == AppStrings.tableGroup
                            ? TableGroup.myAllDropdownModelList
                            : TableGeneral.myAllDropdownModelList,
                    tap: widget.tap,
                    onTapHeader: (titleHeader) {
                      setState(() {
                        TapDetailsWidget.orderBy = titleHeader;
                        TapDetailsWidget.isDesc = !TapDetailsWidget.isDesc;
                      });

                      BlocProvider.of<GetPageDetailsTableCubit>(context)
                          .getPageDetailsTable(
                              tapData: ListTaps(
                                  pageID: widget.tap.pageID,
                                  pageDisplay: widget.tap.pageDisplay,
                                  masterName: widget.tap.masterName,
                                  modulName: widget.tap.modulName,
                                  masterID: widget.tap.masterID,
                                  modulID: widget.tap.modulID,
                                  detailId: widget.tap.detailId,
                                  listName: widget.tap.listName,
                                  tableName: widget.tap.tableName,
                                  primary: widget.tap.primary,
                                  controllerName: widget.tap.controllerName,
                                  tableSrc: widget.tap.tableSrc,
                                  editSrc: widget.tap.editSrc,
                                  isCompany: widget.tap.isCompany,
                                  companyName: widget.tap.companyName,
                                  showPrint: widget.tap.showPrint,
                                  showExport: widget.tap.showExport,
                                  showSearch: widget.tap.showSearch,
                                  showEdit: widget.tap.showEdit,
                                  showDelete: widget.tap.showDelete,
                                  showRowPrint: widget.tap.showRowPrint,
                                  showNew: widget.tap.showNew,
                                  searchFirst: widget.tap.searchFirst,
                                  showSetting: widget.tap.showSetting,
                                  showMasterButton: widget.tap.showMasterButton,
                                  canDrag: widget.tap.canDrag,
                                  canGroup: widget.tap.canGroup,
                                  showSum: widget.tap.showSum,
                                  showColumnSetting:
                                      widget.tap.showColumnSetting,
                                  showRefersh: widget.tap.showRefersh,
                                  canSort: widget.tap.canSort,
                                  showPaging: widget.tap.showPaging,
                                  showGroup: widget.tap.showGroup,
                                  dataSourceApi: widget.tap.dataSourceApi,
                                  limit: TapDetailsWidget.dropdownValue,
                                  orderBy: TapDetailsWidget.orderBy,
                                  tailCondition: widget.tap.tailCondition,
                                  master: widget.tap.master,
                                  foreignKey: widget.tap.foreignKey,
                                  foreignKeyValue: widget.tap.foreignKeyValue,
                                  groupLayout: widget.tap.groupLayout,
                                  groupColumn: widget.tap.groupColumn,
                                  outSiderGroupColumn:
                                      widget.tap.outSiderGroupColumn,
                                  editOnly: widget.tap.editOnly,
                                  listMaster: widget.tap.listMaster,
                                  excel: widget.tap.excel,
                                  excelNew: widget.tap.excelNew,
                                  showInPopUp: widget.tap.showInPopUp,
                                  pageAttributeId: widget.tap.pageAttributeId,
                                  displayArabic: widget.tap.displayArabic,
                                  displayEnglish: widget.tap.displayEnglish,
                                  displayChinese: widget.tap.displayChinese,
                                  columnColor: widget.tap.columnColor,
                                  enName: widget.tap.enName,
                                  isDesc: TapDetailsWidget.isDesc,
                                  unaryColumn: widget.tap.unaryColumn,
                                  numberOfEmptyRow: widget.tap.numberOfEmptyRow,
                                  offset: (TapDetailsWidget.numberPage *
                                          TapDetailsWidget.dropdownValue) -
                                      TapDetailsWidget.dropdownValue),
                              numberOfPage: TapDetailsWidget.numberPage,
                              dropdownValueOfLimit:
                                  TapDetailsWidget.dropdownValue);
                    },
                    paginationWidget: PaginationWidget(
                      allPages: allPages,
                      dropdownValue: TapDetailsWidget.dropdownValue,
                      listNumberItemInList: listNumberItemInList,
                      myPage: TapDetailsWidget.numberPage,
                      numberOfRecords: numberOfRecords,
                      paddingBottom: 15,
                      onChangeLimit: (limit) {
                        setState(() {
                          TapDetailsWidget.dropdownValue = limit;
                          TapDetailsWidget.numberPage = 1;
                          allPages = (numberOfRecords %
                                      TapDetailsWidget.dropdownValue) ==
                                  0
                              ? (numberOfRecords ~/
                                  TapDetailsWidget.dropdownValue)
                              : (numberOfRecords ~/
                                      TapDetailsWidget.dropdownValue) +
                                  1;
                        });

                        BlocProvider.of<GetPageDetailsTableCubit>(context)
                            .getPageDetailsTable(
                                tapData: ListTaps(
                                    pageID: widget.tap.pageID,
                                    pageDisplay: widget.tap.pageDisplay,
                                    masterName: widget.tap.masterName,
                                    modulName: widget.tap.modulName,
                                    masterID: widget.tap.masterID,
                                    modulID: widget.tap.modulID,
                                    detailId: widget.tap.detailId,
                                    listName: widget.tap.listName,
                                    tableName: widget.tap.tableName,
                                    primary: widget.tap.primary,
                                    controllerName: widget.tap.controllerName,
                                    tableSrc: widget.tap.tableSrc,
                                    editSrc: widget.tap.editSrc,
                                    isCompany: widget.tap.isCompany,
                                    companyName: widget.tap.companyName,
                                    showPrint: widget.tap.showPrint,
                                    showExport: widget.tap.showExport,
                                    showSearch: widget.tap.showSearch,
                                    showEdit: widget.tap.showEdit,
                                    showDelete: widget.tap.showDelete,
                                    showRowPrint: widget.tap.showRowPrint,
                                    showNew: widget.tap.showNew,
                                    searchFirst: widget.tap.searchFirst,
                                    showSetting: widget.tap.showSetting,
                                    showMasterButton:
                                        widget.tap.showMasterButton,
                                    canDrag: widget.tap.canDrag,
                                    canGroup: widget.tap.canGroup,
                                    showSum: widget.tap.showSum,
                                    showColumnSetting:
                                        widget.tap.showColumnSetting,
                                    showRefersh: widget.tap.showRefersh,
                                    canSort: widget.tap.canSort,
                                    showPaging: widget.tap.showPaging,
                                    showGroup: widget.tap.showGroup,
                                    dataSourceApi: widget.tap.dataSourceApi,
                                    limit: TapDetailsWidget.dropdownValue,
                                    orderBy: widget.tap.orderBy,
                                    tailCondition: widget.tap.tailCondition,
                                    master: widget.tap.master,
                                    foreignKey: widget.tap.foreignKey,
                                    foreignKeyValue: widget.tap.foreignKeyValue,
                                    groupLayout: widget.tap.groupLayout,
                                    groupColumn: widget.tap.groupColumn,
                                    outSiderGroupColumn:
                                        widget.tap.outSiderGroupColumn,
                                    editOnly: widget.tap.editOnly,
                                    listMaster: widget.tap.listMaster,
                                    excel: widget.tap.excel,
                                    excelNew: widget.tap.excelNew,
                                    showInPopUp: widget.tap.showInPopUp,
                                    pageAttributeId: widget.tap.pageAttributeId,
                                    displayArabic: widget.tap.displayArabic,
                                    displayEnglish: widget.tap.displayEnglish,
                                    displayChinese: widget.tap.displayChinese,
                                    columnColor: widget.tap.columnColor,
                                    enName: widget.tap.enName,
                                    isDesc: widget.tap.isDesc,
                                    unaryColumn: widget.tap.unaryColumn,
                                    numberOfEmptyRow:
                                        widget.tap.numberOfEmptyRow,
                                    offset: (TapDetailsWidget.numberPage *
                                            TapDetailsWidget.dropdownValue) -
                                        TapDetailsWidget.dropdownValue),
                                numberOfPage: TapDetailsWidget.numberPage,
                                dropdownValueOfLimit:
                                    TapDetailsWidget.dropdownValue);
                      },
                      onTapMin: () {
                        setState(() {
                          TapDetailsWidget.numberPage--;
                        });
                        BlocProvider.of<GetPageDetailsTableCubit>(context)
                            .getPageDetailsTable(
                                tapData: ListTaps(
                                    pageID: widget.tap.pageID,
                                    pageDisplay: widget.tap.pageDisplay,
                                    masterName: widget.tap.masterName,
                                    modulName: widget.tap.modulName,
                                    masterID: widget.tap.masterID,
                                    modulID: widget.tap.modulID,
                                    detailId: widget.tap.detailId,
                                    listName: widget.tap.listName,
                                    tableName: widget.tap.tableName,
                                    primary: widget.tap.primary,
                                    controllerName: widget.tap.controllerName,
                                    tableSrc: widget.tap.tableSrc,
                                    editSrc: widget.tap.editSrc,
                                    isCompany: widget.tap.isCompany,
                                    companyName: widget.tap.companyName,
                                    showPrint: widget.tap.showPrint,
                                    showExport: widget.tap.showExport,
                                    showSearch: widget.tap.showSearch,
                                    showEdit: widget.tap.showEdit,
                                    showDelete: widget.tap.showDelete,
                                    showRowPrint: widget.tap.showRowPrint,
                                    showNew: widget.tap.showNew,
                                    searchFirst: widget.tap.searchFirst,
                                    showSetting: widget.tap.showSetting,
                                    showMasterButton:
                                        widget.tap.showMasterButton,
                                    canDrag: widget.tap.canDrag,
                                    canGroup: widget.tap.canGroup,
                                    showSum: widget.tap.showSum,
                                    showColumnSetting:
                                        widget.tap.showColumnSetting,
                                    showRefersh: widget.tap.showRefersh,
                                    canSort: widget.tap.canSort,
                                    showPaging: widget.tap.showPaging,
                                    showGroup: widget.tap.showGroup,
                                    dataSourceApi: widget.tap.dataSourceApi,
                                    limit: TapDetailsWidget.dropdownValue,
                                    orderBy: widget.tap.orderBy,
                                    tailCondition: widget.tap.tailCondition,
                                    master: widget.tap.master,
                                    foreignKey: widget.tap.foreignKey,
                                    foreignKeyValue: widget.tap.foreignKeyValue,
                                    groupLayout: widget.tap.groupLayout,
                                    groupColumn: widget.tap.groupColumn,
                                    outSiderGroupColumn:
                                        widget.tap.outSiderGroupColumn,
                                    editOnly: widget.tap.editOnly,
                                    listMaster: widget.tap.listMaster,
                                    excel: widget.tap.excel,
                                    excelNew: widget.tap.excelNew,
                                    showInPopUp: widget.tap.showInPopUp,
                                    pageAttributeId: widget.tap.pageAttributeId,
                                    displayArabic: widget.tap.displayArabic,
                                    displayEnglish: widget.tap.displayEnglish,
                                    displayChinese: widget.tap.displayChinese,
                                    columnColor: widget.tap.columnColor,
                                    enName: widget.tap.enName,
                                    isDesc: widget.tap.isDesc,
                                    unaryColumn: widget.tap.unaryColumn,
                                    numberOfEmptyRow:
                                        widget.tap.numberOfEmptyRow,
                                    offset: (TapDetailsWidget.numberPage *
                                            TapDetailsWidget.dropdownValue) -
                                        TapDetailsWidget.dropdownValue),
                                numberOfPage: TapDetailsWidget.numberPage,
                                dropdownValueOfLimit:
                                    TapDetailsWidget.dropdownValue);
                      },
                      onTapAdd: () {
                        setState(() {
                          TapDetailsWidget.numberPage++;
                        });

                        BlocProvider.of<GetPageDetailsTableCubit>(context)
                            .getPageDetailsTable(
                                tapData: ListTaps(
                                    pageID: widget.tap.pageID,
                                    pageDisplay: widget.tap.pageDisplay,
                                    masterName: widget.tap.masterName,
                                    modulName: widget.tap.modulName,
                                    masterID: widget.tap.masterID,
                                    modulID: widget.tap.modulID,
                                    detailId: widget.tap.detailId,
                                    listName: widget.tap.listName,
                                    tableName: widget.tap.tableName,
                                    primary: widget.tap.primary,
                                    controllerName: widget.tap.controllerName,
                                    tableSrc: widget.tap.tableSrc,
                                    editSrc: widget.tap.editSrc,
                                    isCompany: widget.tap.isCompany,
                                    companyName: widget.tap.companyName,
                                    showPrint: widget.tap.showPrint,
                                    showExport: widget.tap.showExport,
                                    showSearch: widget.tap.showSearch,
                                    showEdit: widget.tap.showEdit,
                                    showDelete: widget.tap.showDelete,
                                    showRowPrint: widget.tap.showRowPrint,
                                    showNew: widget.tap.showNew,
                                    searchFirst: widget.tap.searchFirst,
                                    showSetting: widget.tap.showSetting,
                                    showMasterButton:
                                        widget.tap.showMasterButton,
                                    canDrag: widget.tap.canDrag,
                                    canGroup: widget.tap.canGroup,
                                    showSum: widget.tap.showSum,
                                    showColumnSetting:
                                        widget.tap.showColumnSetting,
                                    showRefersh: widget.tap.showRefersh,
                                    canSort: widget.tap.canSort,
                                    showPaging: widget.tap.showPaging,
                                    showGroup: widget.tap.showGroup,
                                    dataSourceApi: widget.tap.dataSourceApi,
                                    limit: TapDetailsWidget.dropdownValue,
                                    orderBy: widget.tap.orderBy,
                                    tailCondition: widget.tap.tailCondition,
                                    master: widget.tap.master,
                                    foreignKey: widget.tap.foreignKey,
                                    foreignKeyValue: widget.tap.foreignKeyValue,
                                    groupLayout: widget.tap.groupLayout,
                                    groupColumn: widget.tap.groupColumn,
                                    outSiderGroupColumn:
                                        widget.tap.outSiderGroupColumn,
                                    editOnly: widget.tap.editOnly,
                                    listMaster: widget.tap.listMaster,
                                    excel: widget.tap.excel,
                                    excelNew: widget.tap.excelNew,
                                    showInPopUp: widget.tap.showInPopUp,
                                    pageAttributeId: widget.tap.pageAttributeId,
                                    displayArabic: widget.tap.displayArabic,
                                    displayEnglish: widget.tap.displayEnglish,
                                    displayChinese: widget.tap.displayChinese,
                                    columnColor: widget.tap.columnColor,
                                    enName: widget.tap.enName,
                                    isDesc: widget.tap.isDesc,
                                    unaryColumn: widget.tap.unaryColumn,
                                    numberOfEmptyRow:
                                        widget.tap.numberOfEmptyRow,
                                    offset: (TapDetailsWidget.numberPage *
                                            TapDetailsWidget.dropdownValue) -
                                        TapDetailsWidget.dropdownValue),
                                numberOfPage: TapDetailsWidget.numberPage,
                                dropdownValueOfLimit:
                                    TapDetailsWidget.dropdownValue);
                      },
                    ),
                  ),
                );
              } else if (state is GetPageDetailsTableFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomLoadingWidget(),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
