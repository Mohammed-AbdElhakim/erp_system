import 'package:erp_system/features/screenTable/presentation/widgets/details/build_alert_search_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../../core/models/menu_model/pages.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/custom_error_massage.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../data/models/passData/add_pass_data_model.dart';
import '../../../data/models/screen_model.dart';
import '../../../data/models/tap_model.dart';
import '../../manager/addEdit/add_edit_cubit.dart';
import '../../manager/delete/delete_cubit.dart';
import '../../manager/getPageDetailsTable/get_page_details_table_cubit.dart';
import '../../views/screen_table.dart';
import '../pagination_widget.dart';
import 'build_alert_add_details.dart';
import 'build_alert_delete_details.dart';
import 'build_alert_edit_details.dart';
import 'table_page_details_widget.dart';

class TapDetailsWidgetBody extends StatefulWidget {
  const TapDetailsWidgetBody(
      {super.key, required this.tap, required this.pageData, required this.id});
  final ListTaps tap;
  final Pages pageData;
  final String id;
  static late String orderBy;
  static late bool isDesc;
  static late int numberPage;
  static late int dropdownValue;
  static List<AllDropdownModel> myAllDropdownModelList = [];
  static bool isSearch = false;
  static List<Map<String, dynamic>> rowData = [];
  static List<String> listCategory = [];

  @override
  State<TapDetailsWidgetBody> createState() => _TapDetailsWidgetBodyState();
}

class _TapDetailsWidgetBodyState extends State<TapDetailsWidgetBody> {
  String? lang;
  late int allPages;
  List<int> listNumberItemInList = [10, 25, 50, 100];
  bool showSettings = false;
  // String st = '';
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    TapDetailsWidgetBody.numberPage = 1;
    TapDetailsWidgetBody.isDesc = widget.tap.isDesc!;
    TapDetailsWidgetBody.orderBy = widget.tap.orderBy;
    TapDetailsWidgetBody.dropdownValue = listNumberItemInList[0];
    BuildAlertSearchDetails.statement =
        "and ${widget.tap.foreignKey}  =  ${widget.id} ";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPageDetailsTableCubit, GetPageDetailsTableState>(
      builder: (context, state) {
        if (state is GetPageDetailsTableSuccess) {
          int? numberOfRecords = state.screenModel.numberOfRecords;
          List<dynamic>? listData = state.screenModel.dataList;
          List<dynamic>? listSum = state.screenModel.summedColumns;
          List<String> listHeader = [];
          List<dynamic> listKey = [];
          List<ColumnList> listColumn = [];
          List<String> listHeaderInTable = [];
          List<dynamic> listKeyInTable = [];
          List<ColumnList> listColumnInTable = [];
          List<String> category = [];
          for (var item in state.screenModel.columnList!) {
            if (item.visible == true) {
              listHeaderInTable.add(lang == AppStrings.enLangKey
                  ? item.enColumnLabel!
                  : item.arColumnLabel!);
              listKeyInTable.add(item.columnName);
              listColumnInTable.add(item);
            }
            listHeader.add(lang == AppStrings.enLangKey
                ? item.enColumnLabel!
                : item.arColumnLabel!);
            listKey.add(item.columnName);
            listColumn.add(item);
            category.add(item.categoryName!);
          }
          TapDetailsWidgetBody.numberPage = state.numberPage;
          TapDetailsWidgetBody.dropdownValue = state.dropdownValue;
          allPages =
              (numberOfRecords! % TapDetailsWidgetBody.dropdownValue) == 0
                  ? (numberOfRecords ~/ TapDetailsWidgetBody.dropdownValue)
                  : (numberOfRecords ~/ TapDetailsWidgetBody.dropdownValue) + 1;
          return SizedBox(
            height: 400,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (showSettings == false) {
                          setState(() {
                            showSettings = true;
                          });
                        } else {
                          setState(() {
                            showSettings = false;
                          });
                        }
                      },
                      icon: Icon(
                        showSettings == true ? Icons.close : Icons.settings,
                      ),
                      color: AppColors.white,
                      style: IconButton.styleFrom(
                          backgroundColor: AppColors.blueLight),
                    ),
                    if (widget.tap.showSearch != false && showSettings == true)
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: Text(
                                    S.of(context).btn_search,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blueLight),
                                  ),
                                ),
                                content: BuildAlertSearchDetails(
                                  mainId: widget.id,
                                  columnList: listColumn,
                                  tap: widget.tap,
                                  oldStatement:
                                      BuildAlertSearchDetails.statement,
                                  pageData: widget.pageData,
                                  onTapClean: () {
                                    TapDetailsWidgetBody.isSearch = false;
                                    BuildAlertSearchDetails.statement =
                                        "and ${widget.tap.foreignKey}  =  ${widget.id} ";
                                  },
                                  onTapSearch: (myStatement) {
                                    BuildAlertSearchDetails.statement =
                                        myStatement;
                                    TapDetailsWidgetBody.isSearch = true;
                                  },
                                ),
                              );
                            },
                          ).then(
                            (value) {
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
                                        controllerName:
                                            widget.tap.controllerName,
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
                                        limit: 10,
                                        orderBy: widget.tap.orderBy,
                                        tailCondition: widget.tap.tailCondition,
                                        master: widget.tap.master,
                                        foreignKey: widget.tap.foreignKey,
                                        foreignKeyValue:
                                            widget.tap.foreignKeyValue,
                                        groupLayout: widget.tap.groupLayout,
                                        groupColumn: widget.tap.groupColumn,
                                        outSiderGroupColumn:
                                            widget.tap.outSiderGroupColumn,
                                        editOnly: widget.tap.editOnly,
                                        listMaster: widget.tap.listMaster,
                                        excel: widget.tap.excel,
                                        excelNew: widget.tap.excelNew,
                                        showInPopUp: widget.tap.showInPopUp,
                                        pageAttributeId:
                                            widget.tap.pageAttributeId,
                                        displayArabic: widget.tap.displayArabic,
                                        displayEnglish:
                                            widget.tap.displayEnglish,
                                        displayChinese:
                                            widget.tap.displayChinese,
                                        columnColor: widget.tap.columnColor,
                                        enName: widget.tap.enName,
                                        isDesc: widget.tap.isDesc,
                                        unaryColumn: widget.tap.unaryColumn,
                                        numberOfEmptyRow:
                                            widget.tap.numberOfEmptyRow,
                                        offset: 0,
                                        statment:
                                            BuildAlertSearchDetails.statement,
                                      ),
                                      numberOfPage: 1,
                                      dropdownValueOfLimit: 10);
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.search,
                        ),
                        color: AppColors.white,
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.blue),
                      ),
                    if (widget.tap.showEdit != false && showSettings == true)
                      IconButton(
                        onPressed: () {
                          if (widget.pageData.tableSrc ==
                              AppStrings.tableGroup) {
                            GoRouter.of(context).push(AppRouter.kEditView,
                                extra: AddPassDataModel(
                                  pageData: widget.pageData,
                                  columnList: listColumn,
                                  listKey: listKey,
                                ));
                          } else {
                            if (TapDetailsWidgetBody.rowData.isNotEmpty) {
                              List<String> listId = [];
                              for (var item in TapDetailsWidgetBody.rowData) {
                                listId.add(item[widget.tap.primary].toString());
                              }
                              if (listId.length > 1) {
                                CustomAlertDialog.alertWithButton(
                                    context: context,
                                    type: AlertType.error,
                                    title: S.of(context).error,
                                    desc: S.of(context).massage_no_edit);
                              } else if (listId.length == 1) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Center(
                                        child: Text(
                                          S.of(context).btn_edit,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.blueLight),
                                        ),
                                      ),
                                      content: BuildAlertEditDetails(
                                        columnList: listColumn,
                                        pageData: widget.pageData,
                                        tap: widget.tap,
                                        mainId: widget.id,
                                        onTapEdit: (newRowData) {
                                          BlocProvider.of<AddEditCubit>(context)
                                              .edit(
                                                  controllerName:
                                                      widget.tap.controllerName,
                                                  body: newRowData);
                                        },
                                      ),
                                    );
                                  },
                                ).then(
                                  (value) {
                                    BlocProvider.of<GetPageDetailsTableCubit>(
                                            context)
                                        .getPageDetailsTable(
                                            tapData: ListTaps(
                                              pageID: widget.tap.pageID,
                                              pageDisplay:
                                                  widget.tap.pageDisplay,
                                              masterName: widget.tap.masterName,
                                              modulName: widget.tap.modulName,
                                              masterID: widget.tap.masterID,
                                              modulID: widget.tap.modulID,
                                              detailId: widget.tap.detailId,
                                              listName: widget.tap.listName,
                                              tableName: widget.tap.tableName,
                                              primary: widget.tap.primary,
                                              controllerName:
                                                  widget.tap.controllerName,
                                              tableSrc: widget.tap.tableSrc,
                                              editSrc: widget.tap.editSrc,
                                              isCompany: widget.tap.isCompany,
                                              companyName:
                                                  widget.tap.companyName,
                                              showPrint: widget.tap.showPrint,
                                              showExport: widget.tap.showExport,
                                              showSearch: widget.tap.showSearch,
                                              showEdit: widget.tap.showEdit,
                                              showDelete: widget.tap.showDelete,
                                              showRowPrint:
                                                  widget.tap.showRowPrint,
                                              showNew: widget.tap.showNew,
                                              searchFirst:
                                                  widget.tap.searchFirst,
                                              showSetting:
                                                  widget.tap.showSetting,
                                              showMasterButton:
                                                  widget.tap.showMasterButton,
                                              canDrag: widget.tap.canDrag,
                                              canGroup: widget.tap.canGroup,
                                              showSum: widget.tap.showSum,
                                              showColumnSetting:
                                                  widget.tap.showColumnSetting,
                                              showRefersh:
                                                  widget.tap.showRefersh,
                                              canSort: widget.tap.canSort,
                                              showPaging: widget.tap.showPaging,
                                              showGroup: widget.tap.showGroup,
                                              dataSourceApi:
                                                  widget.tap.dataSourceApi,
                                              limit: 10,
                                              orderBy: widget.tap.orderBy,
                                              tailCondition:
                                                  widget.tap.tailCondition,
                                              master: widget.tap.master,
                                              foreignKey: widget.tap.foreignKey,
                                              foreignKeyValue:
                                                  widget.tap.foreignKeyValue,
                                              groupLayout:
                                                  widget.tap.groupLayout,
                                              groupColumn:
                                                  widget.tap.groupColumn,
                                              outSiderGroupColumn: widget
                                                  .tap.outSiderGroupColumn,
                                              editOnly: widget.tap.editOnly,
                                              listMaster: widget.tap.listMaster,
                                              excel: widget.tap.excel,
                                              excelNew: widget.tap.excelNew,
                                              showInPopUp:
                                                  widget.tap.showInPopUp,
                                              pageAttributeId:
                                                  widget.tap.pageAttributeId,
                                              displayArabic:
                                                  widget.tap.displayArabic,
                                              displayEnglish:
                                                  widget.tap.displayEnglish,
                                              displayChinese:
                                                  widget.tap.displayChinese,
                                              columnColor:
                                                  widget.tap.columnColor,
                                              enName: widget.tap.enName,
                                              isDesc: widget.tap.isDesc,
                                              unaryColumn:
                                                  widget.tap.unaryColumn,
                                              numberOfEmptyRow:
                                                  widget.tap.numberOfEmptyRow,
                                              offset: 0,
                                              statment:
                                                  "and ${widget.tap.foreignKey}  =  ${widget.id} ",
                                            ),
                                            numberOfPage: 1,
                                            dropdownValueOfLimit: 10);
                                  },
                                );
                              }
                            } else {
                              CustomAlertDialog.alertWithButton(
                                  context: context,
                                  type: AlertType.error,
                                  title: S.of(context).error,
                                  desc: S.of(context).massage_choose_edit);
                            }
                          }
                        },
                        icon: const Icon(Icons.edit_note),
                        color: AppColors.white,
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.blueGreyDark),
                      ),
                    if (widget.tap.showNew != false && showSettings == true)
                      IconButton(
                        onPressed: () {
                          if (widget.pageData.tableSrc ==
                              AppStrings.tableGroup) {
                            GoRouter.of(context).push(AppRouter.kAddView,
                                extra: AddPassDataModel(
                                  pageData: widget.pageData,
                                  columnList: listColumn,
                                  listKey: listKey,
                                ));
                          } else {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Center(
                                    child: Text(
                                      S.of(context).btn_add,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blueLight),
                                    ),
                                  ),
                                  content: BuildAlertAddDetails(
                                    columnList: listColumn,
                                    pageData: widget.pageData,
                                    tap: widget.tap,
                                    mainId: widget.id,
                                    onTapAdd: (newRowData) {
                                      BlocProvider.of<AddEditCubit>(context)
                                          .add(
                                              controllerName:
                                                  widget.tap.controllerName,
                                              body: newRowData);
                                    },
                                  ),
                                );
                              },
                            ).then(
                              (value) {
                                BlocProvider.of<GetPageDetailsTableCubit>(
                                        context)
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
                                          controllerName:
                                              widget.tap.controllerName,
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
                                          dataSourceApi:
                                              widget.tap.dataSourceApi,
                                          limit: 10,
                                          orderBy: widget.tap.orderBy,
                                          tailCondition:
                                              widget.tap.tailCondition,
                                          master: widget.tap.master,
                                          foreignKey: widget.tap.foreignKey,
                                          foreignKeyValue:
                                              widget.tap.foreignKeyValue,
                                          groupLayout: widget.tap.groupLayout,
                                          groupColumn: widget.tap.groupColumn,
                                          outSiderGroupColumn:
                                              widget.tap.outSiderGroupColumn,
                                          editOnly: widget.tap.editOnly,
                                          listMaster: widget.tap.listMaster,
                                          excel: widget.tap.excel,
                                          excelNew: widget.tap.excelNew,
                                          showInPopUp: widget.tap.showInPopUp,
                                          pageAttributeId:
                                              widget.tap.pageAttributeId,
                                          displayArabic:
                                              widget.tap.displayArabic,
                                          displayEnglish:
                                              widget.tap.displayEnglish,
                                          displayChinese:
                                              widget.tap.displayChinese,
                                          columnColor: widget.tap.columnColor,
                                          enName: widget.tap.enName,
                                          isDesc: widget.tap.isDesc,
                                          unaryColumn: widget.tap.unaryColumn,
                                          numberOfEmptyRow:
                                              widget.tap.numberOfEmptyRow,
                                          offset: 0,
                                          statment:
                                              "and ${widget.tap.foreignKey}  =  ${widget.id} ",
                                        ),
                                        numberOfPage: 1,
                                        dropdownValueOfLimit: 10);
                              },
                            );
                          }
                        },
                        icon: const Icon(Icons.add),
                        color: AppColors.white,
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.blueLight),
                      ),
                    if (widget.tap.showDelete != false && showSettings == true)
                      IconButton(
                        onPressed: () {
                          if (TapDetailsWidgetBody.rowData.isNotEmpty) {
                            List<String> listId = [];
                            for (var item in TapDetailsWidgetBody.rowData) {
                              listId.add(item[widget.tap.primary].toString());
                            }
                            CustomAlertDialog.alertDelete(
                              context: context,
                              contentButton: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: BuildAlertDeleteDetails(
                                  onTapDelete: () {
                                    BlocProvider.of<DeleteCubit>(context)
                                        .deleteItems(
                                            controllerName:
                                                widget.tap.controllerName,
                                            listId: listId)
                                        .then((value) {
                                      TapDetailsWidgetBody.rowData = [];
                                      return BlocProvider.of<
                                              GetPageDetailsTableCubit>(context)
                                          .getPageDetailsTable(
                                              tapData: ListTaps(
                                                pageID: widget.tap.pageID,
                                                pageDisplay:
                                                    widget.tap.pageDisplay,
                                                masterName:
                                                    widget.tap.masterName,
                                                modulName: widget.tap.modulName,
                                                masterID: widget.tap.masterID,
                                                modulID: widget.tap.modulID,
                                                detailId: widget.tap.detailId,
                                                listName: widget.tap.listName,
                                                tableName: widget.tap.tableName,
                                                primary: widget.tap.primary,
                                                controllerName:
                                                    widget.tap.controllerName,
                                                tableSrc: widget.tap.tableSrc,
                                                editSrc: widget.tap.editSrc,
                                                isCompany: widget.tap.isCompany,
                                                companyName:
                                                    widget.tap.companyName,
                                                showPrint: widget.tap.showPrint,
                                                showExport:
                                                    widget.tap.showExport,
                                                showSearch:
                                                    widget.tap.showSearch,
                                                showEdit: widget.tap.showEdit,
                                                showDelete:
                                                    widget.tap.showDelete,
                                                showRowPrint:
                                                    widget.tap.showRowPrint,
                                                showNew: widget.tap.showNew,
                                                searchFirst:
                                                    widget.tap.searchFirst,
                                                showSetting:
                                                    widget.tap.showSetting,
                                                showMasterButton:
                                                    widget.tap.showMasterButton,
                                                canDrag: widget.tap.canDrag,
                                                canGroup: widget.tap.canGroup,
                                                showSum: widget.tap.showSum,
                                                showColumnSetting: widget
                                                    .tap.showColumnSetting,
                                                showRefersh:
                                                    widget.tap.showRefersh,
                                                canSort: widget.tap.canSort,
                                                showPaging:
                                                    widget.tap.showPaging,
                                                showGroup: widget.tap.showGroup,
                                                dataSourceApi:
                                                    widget.tap.dataSourceApi,
                                                limit: 10,
                                                orderBy: widget.tap.orderBy,
                                                tailCondition:
                                                    widget.tap.tailCondition,
                                                master: widget.tap.master,
                                                foreignKey:
                                                    widget.tap.foreignKey,
                                                foreignKeyValue:
                                                    widget.tap.foreignKeyValue,
                                                groupLayout:
                                                    widget.tap.groupLayout,
                                                groupColumn:
                                                    widget.tap.groupColumn,
                                                outSiderGroupColumn: widget
                                                    .tap.outSiderGroupColumn,
                                                editOnly: widget.tap.editOnly,
                                                listMaster:
                                                    widget.tap.listMaster,
                                                excel: widget.tap.excel,
                                                excelNew: widget.tap.excelNew,
                                                showInPopUp:
                                                    widget.tap.showInPopUp,
                                                pageAttributeId:
                                                    widget.tap.pageAttributeId,
                                                displayArabic:
                                                    widget.tap.displayArabic,
                                                displayEnglish:
                                                    widget.tap.displayEnglish,
                                                displayChinese:
                                                    widget.tap.displayChinese,
                                                columnColor:
                                                    widget.tap.columnColor,
                                                enName: widget.tap.enName,
                                                isDesc: widget.tap.isDesc,
                                                unaryColumn:
                                                    widget.tap.unaryColumn,
                                                numberOfEmptyRow:
                                                    widget.tap.numberOfEmptyRow,
                                                offset: 0,
                                                statment:
                                                    "and ${widget.tap.foreignKey}  =  ${widget.id} ",
                                              ),
                                              numberOfPage: 1,
                                              dropdownValueOfLimit: 10);
                                    });
                                  },
                                ),
                              ),
                            );
                          } else {
                            CustomAlertDialog.alertWithButton(
                                context: context,
                                type: AlertType.error,
                                title: S.of(context).error,
                                desc: S.of(context).massage_choose_delete);
                          }
                        },
                        icon: const Icon(Icons.delete),
                        color: AppColors.white,
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.red),
                      ),
                  ],
                ),
                Expanded(
                  child: TablePageDetailsWidget(
                    listSum: listSum,
                    listHeader: listHeaderInTable,
                    listData: listData!,
                    listKey: listKeyInTable,
                    listColumn: listColumnInTable,
                    allDropdownModelList: ScreenTable.myAllDropdownModelList,
                    tap: widget.tap,
                    onTapHeader: (titleHeader) {
                      setState(() {
                        TapDetailsWidgetBody.orderBy = titleHeader;
                        TapDetailsWidgetBody.isDesc =
                            !TapDetailsWidgetBody.isDesc;
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
                                showColumnSetting: widget.tap.showColumnSetting,
                                showRefersh: widget.tap.showRefersh,
                                canSort: widget.tap.canSort,
                                showPaging: widget.tap.showPaging,
                                showGroup: widget.tap.showGroup,
                                dataSourceApi: widget.tap.dataSourceApi,
                                limit: TapDetailsWidgetBody.dropdownValue,
                                orderBy: TapDetailsWidgetBody.orderBy,
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
                                isDesc: TapDetailsWidgetBody.isDesc,
                                unaryColumn: widget.tap.unaryColumn,
                                numberOfEmptyRow: widget.tap.numberOfEmptyRow,
                                offset: (TapDetailsWidgetBody.numberPage *
                                        TapDetailsWidgetBody.dropdownValue) -
                                    TapDetailsWidgetBody.dropdownValue,
                                statment: TapDetailsWidgetBody.isSearch == true
                                    ? BuildAlertSearchDetails.statement
                                    : "and ${widget.tap.foreignKey}  =  ${widget.id} ",
                              ),
                              numberOfPage: TapDetailsWidgetBody.numberPage,
                              dropdownValueOfLimit:
                                  TapDetailsWidgetBody.dropdownValue);
                    },
                    paginationWidget: PaginationWidget(
                      allPages: allPages,
                      dropdownValue: TapDetailsWidgetBody.dropdownValue,
                      listNumberItemInList: listNumberItemInList,
                      myPage: TapDetailsWidgetBody.numberPage,
                      numberOfRecords: numberOfRecords,
                      paddingBottom: 15,
                      onChangeLimit: (limit) {
                        setState(() {
                          TapDetailsWidgetBody.dropdownValue = limit;
                          TapDetailsWidgetBody.numberPage = 1;
                          allPages = (numberOfRecords %
                                      TapDetailsWidgetBody.dropdownValue) ==
                                  0
                              ? (numberOfRecords ~/
                                  TapDetailsWidgetBody.dropdownValue)
                              : (numberOfRecords ~/
                                      TapDetailsWidgetBody.dropdownValue) +
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
                                  limit: TapDetailsWidgetBody.dropdownValue,
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
                                  numberOfEmptyRow: widget.tap.numberOfEmptyRow,
                                  offset: (TapDetailsWidgetBody.numberPage *
                                          TapDetailsWidgetBody.dropdownValue) -
                                      TapDetailsWidgetBody.dropdownValue,
                                  statment: TapDetailsWidgetBody.isSearch ==
                                          true
                                      ? BuildAlertSearchDetails.statement
                                      : "and ${widget.tap.foreignKey}  =  ${widget.id} ",
                                ),
                                numberOfPage: TapDetailsWidgetBody.numberPage,
                                dropdownValueOfLimit:
                                    TapDetailsWidgetBody.dropdownValue);
                      },
                      onTapMin: () {
                        setState(() {
                          TapDetailsWidgetBody.numberPage--;
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
                                  limit: TapDetailsWidgetBody.dropdownValue,
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
                                  numberOfEmptyRow: widget.tap.numberOfEmptyRow,
                                  offset: (TapDetailsWidgetBody.numberPage *
                                          TapDetailsWidgetBody.dropdownValue) -
                                      TapDetailsWidgetBody.dropdownValue,
                                  statment: TapDetailsWidgetBody.isSearch ==
                                          true
                                      ? BuildAlertSearchDetails.statement
                                      : "and ${widget.tap.foreignKey}  =  ${widget.id} ",
                                ),
                                numberOfPage: TapDetailsWidgetBody.numberPage,
                                dropdownValueOfLimit:
                                    TapDetailsWidgetBody.dropdownValue);
                      },
                      onTapAdd: () {
                        setState(() {
                          TapDetailsWidgetBody.numberPage++;
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
                            showColumnSetting: widget.tap.showColumnSetting,
                            showRefersh: widget.tap.showRefersh,
                            canSort: widget.tap.canSort,
                            showPaging: widget.tap.showPaging,
                            showGroup: widget.tap.showGroup,
                            dataSourceApi: widget.tap.dataSourceApi,
                            limit: TapDetailsWidgetBody.dropdownValue,
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
                            offset: (TapDetailsWidgetBody.numberPage *
                                    TapDetailsWidgetBody.dropdownValue) -
                                TapDetailsWidgetBody.dropdownValue,
                            statment: TapDetailsWidgetBody.isSearch == true
                                ? BuildAlertSearchDetails.statement
                                : "and ${widget.tap.foreignKey}  =  ${widget.id} ",
                          ),
                          numberOfPage: TapDetailsWidgetBody.numberPage,
                          dropdownValueOfLimit:
                              TapDetailsWidgetBody.dropdownValue,
                        );
                      },
                    ),
                    onTapRow: (rowData) {
                      TapDetailsWidgetBody.rowData = rowData;
                    },
                  ),
                ),
              ],
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
    );
  }
}

/*showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text(
                                        S.of(context).btn_edit,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blueLight),
                                      ),
                                    ),
                                    content: BuildAlertEditDetails(
                                      columnList: listColumn,
                                      pageData: widget.pageData,
                                      tap: widget.tap,
                                      mainId: widget.id,
                                      onTapEdit: (newRowData) {
                                        BlocProvider.of<AddEditCubit>(context)
                                            .edit(
                                                controllerName:
                                                    widget.tap.controllerName,
                                                body: newRowData)
                                            .then((value) => BlocProvider.of<
                                                        GetPageDetailsTableCubit>(
                                                    context)
                                                .getPageDetailsTable(
                                                    tapData: ListTaps(
                                                      pageID: widget.tap.pageID,
                                                      pageDisplay: widget
                                                          .tap.pageDisplay,
                                                      masterName:
                                                          widget.tap.masterName,
                                                      modulName:
                                                          widget.tap.modulName,
                                                      masterID:
                                                          widget.tap.masterID,
                                                      modulID:
                                                          widget.tap.modulID,
                                                      detailId:
                                                          widget.tap.detailId,
                                                      listName:
                                                          widget.tap.listName,
                                                      tableName:
                                                          widget.tap.tableName,
                                                      primary:
                                                          widget.tap.primary,
                                                      controllerName: widget
                                                          .tap.controllerName,
                                                      tableSrc:
                                                          widget.tap.tableSrc,
                                                      editSrc:
                                                          widget.tap.editSrc,
                                                      isCompany:
                                                          widget.tap.isCompany,
                                                      companyName: widget
                                                          .tap.companyName,
                                                      showPrint:
                                                          widget.tap.showPrint,
                                                      showExport:
                                                          widget.tap.showExport,
                                                      showSearch:
                                                          widget.tap.showSearch,
                                                      showEdit:
                                                          widget.tap.showEdit,
                                                      showDelete:
                                                          widget.tap.showDelete,
                                                      showRowPrint: widget
                                                          .tap.showRowPrint,
                                                      showNew:
                                                          widget.tap.showNew,
                                                      searchFirst: widget
                                                          .tap.searchFirst,
                                                      showSetting: widget
                                                          .tap.showSetting,
                                                      showMasterButton: widget
                                                          .tap.showMasterButton,
                                                      canDrag:
                                                          widget.tap.canDrag,
                                                      canGroup:
                                                          widget.tap.canGroup,
                                                      showSum:
                                                          widget.tap.showSum,
                                                      showColumnSetting: widget
                                                          .tap
                                                          .showColumnSetting,
                                                      showRefersh: widget
                                                          .tap.showRefersh,
                                                      canSort:
                                                          widget.tap.canSort,
                                                      showPaging:
                                                          widget.tap.showPaging,
                                                      showGroup:
                                                          widget.tap.showGroup,
                                                      dataSourceApi: widget
                                                          .tap.dataSourceApi,
                                                      limit: 10,
                                                      orderBy:
                                                          widget.tap.orderBy,
                                                      tailCondition: widget
                                                          .tap.tailCondition,
                                                      master: widget.tap.master,
                                                      foreignKey:
                                                          widget.tap.foreignKey,
                                                      foreignKeyValue: widget
                                                          .tap.foreignKeyValue,
                                                      groupLayout: widget
                                                          .tap.groupLayout,
                                                      groupColumn: widget
                                                          .tap.groupColumn,
                                                      outSiderGroupColumn: widget
                                                          .tap
                                                          .outSiderGroupColumn,
                                                      editOnly:
                                                          widget.tap.editOnly,
                                                      listMaster:
                                                          widget.tap.listMaster,
                                                      excel: widget.tap.excel,
                                                      excelNew:
                                                          widget.tap.excelNew,
                                                      showInPopUp: widget
                                                          .tap.showInPopUp,
                                                      pageAttributeId: widget
                                                          .tap.pageAttributeId,
                                                      displayArabic: widget
                                                          .tap.displayArabic,
                                                      displayEnglish: widget
                                                          .tap.displayEnglish,
                                                      displayChinese: widget
                                                          .tap.displayChinese,
                                                      columnColor: widget
                                                          .tap.columnColor,
                                                      enName: widget.tap.enName,
                                                      isDesc: widget.tap.isDesc,
                                                      unaryColumn: widget
                                                          .tap.unaryColumn,
                                                      numberOfEmptyRow: widget
                                                          .tap.numberOfEmptyRow,
                                                      offset: 0,
                                                      statment:
                                                          "and ${widget.tap.foreignKey}  =  ${widget.id} ",
                                                    ),
                                                    numberOfPage: 1,
                                                    dropdownValueOfLimit: 10));
                                      },
                                    ),
                                  );
                                },
                              ).then(
                                (value) {
                                  BlocProvider.of<GetPageDetailsTableCubit>(
                                          context)
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
                                            controllerName:
                                                widget.tap.controllerName,
                                            tableSrc: widget.tap.tableSrc,
                                            editSrc: widget.tap.editSrc,
                                            isCompany: widget.tap.isCompany,
                                            companyName: widget.tap.companyName,
                                            showPrint: widget.tap.showPrint,
                                            showExport: widget.tap.showExport,
                                            showSearch: widget.tap.showSearch,
                                            showEdit: widget.tap.showEdit,
                                            showDelete: widget.tap.showDelete,
                                            showRowPrint:
                                                widget.tap.showRowPrint,
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
                                            dataSourceApi:
                                                widget.tap.dataSourceApi,
                                            limit: 10,
                                            orderBy: widget.tap.orderBy,
                                            tailCondition:
                                                widget.tap.tailCondition,
                                            master: widget.tap.master,
                                            foreignKey: widget.tap.foreignKey,
                                            foreignKeyValue:
                                                widget.tap.foreignKeyValue,
                                            groupLayout: widget.tap.groupLayout,
                                            groupColumn: widget.tap.groupColumn,
                                            outSiderGroupColumn:
                                                widget.tap.outSiderGroupColumn,
                                            editOnly: widget.tap.editOnly,
                                            listMaster: widget.tap.listMaster,
                                            excel: widget.tap.excel,
                                            excelNew: widget.tap.excelNew,
                                            showInPopUp: widget.tap.showInPopUp,
                                            pageAttributeId:
                                                widget.tap.pageAttributeId,
                                            displayArabic:
                                                widget.tap.displayArabic,
                                            displayEnglish:
                                                widget.tap.displayEnglish,
                                            displayChinese:
                                                widget.tap.displayChinese,
                                            columnColor: widget.tap.columnColor,
                                            enName: widget.tap.enName,
                                            isDesc: widget.tap.isDesc,
                                            unaryColumn: widget.tap.unaryColumn,
                                            numberOfEmptyRow:
                                                widget.tap.numberOfEmptyRow,
                                            offset: 0,
                                            statment:
                                                "and ${widget.tap.foreignKey}  =  ${widget.id} ",
                                          ),
                                          numberOfPage: 1,
                                          dropdownValueOfLimit: 10);
                                },
                              );*/
