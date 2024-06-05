class TapModel {
  TapModel({
    required this.list,
  });
  late final List<ListTaps> list;

  TapModel.fromJson(Map<String, dynamic> json) {
    list = List.from(json['list']).map((e) => ListTaps.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list'] = list.map((e) => e.toJson()).toList();
    return data;
  }
}

class ListTaps {
  ListTaps({
    required this.pageID,
    required this.pageDisplay,
    required this.masterName,
    required this.modulName,
    required this.masterID,
    required this.modulID,
    required this.detailId,
    required this.listName,
    required this.tableName,
    required this.primary,
    required this.controllerName,
    required this.tableSrc,
    required this.editSrc,
    required this.isCompany,
    required this.companyName,
    required this.showPrint,
    required this.showExport,
    required this.showSearch,
    required this.showEdit,
    required this.showDelete,
    required this.showRowPrint,
    required this.showNew,
    required this.searchFirst,
    required this.showSetting,
    required this.showMasterButton,
    required this.canDrag,
    required this.canGroup,
    required this.showSum,
    required this.showColumnSetting,
    required this.showRefersh,
    required this.canSort,
    required this.showPaging,
    required this.showGroup,
    required this.dataSourceApi,
    required this.limit,
    required this.orderBy,
    required this.tailCondition,
    required this.master,
    required this.foreignKey,
    required this.foreignKeyValue,
    required this.groupLayout,
    required this.groupColumn,
    required this.outSiderGroupColumn,
    required this.editOnly,
    required this.listMaster,
    required this.excel,
    required this.excelNew,
    required this.showInPopUp,
    required this.pageAttributeId,
    required this.displayArabic,
    required this.displayEnglish,
    required this.displayChinese,
    required this.columnColor,
    required this.enName,
    required this.isDesc,
    required this.unaryColumn,
    required this.numberOfEmptyRow,
  });
  late final int pageID;
  late final String pageDisplay;
  late final String masterName;
  late final String modulName;
  late final int? masterID;
  late final int? modulID;
  late final int detailId;
  late final String listName;
  late final String tableName;
  late final String primary;
  late final String controllerName;
  late final String tableSrc;
  late final String editSrc;
  late final bool? isCompany;
  late final String companyName;
  late final bool? showPrint;
  late final bool? showExport;
  late final bool? showSearch;
  late final bool? showEdit;
  late final bool? showDelete;
  late final bool? showRowPrint;
  late final bool? showNew;
  late final bool? searchFirst;
  late final bool? showSetting;
  late final bool? showMasterButton;
  late final bool? canDrag;
  late final bool? canGroup;
  late final bool? showSum;
  late final bool? showColumnSetting;
  late final bool? showRefersh;
  late final bool? canSort;
  late final bool? showPaging;
  late final bool? showGroup;
  late final String dataSourceApi;
  late final int? limit;
  late final String orderBy;
  late final String tailCondition;
  late final bool? master;
  late final String foreignKey;
  late final String foreignKeyValue;
  late final bool? groupLayout;
  late final String groupColumn;
  late final String outSiderGroupColumn;
  late final bool? editOnly;
  late final bool? listMaster;
  late final bool? excel;
  late final bool? excelNew;
  late final bool? showInPopUp;
  late final int? pageAttributeId;
  late final String displayArabic;
  late final String displayEnglish;
  late final String displayChinese;
  late final String columnColor;
  late final String enName;
  late final bool? isDesc;
  late final String unaryColumn;
  late final int? numberOfEmptyRow;

  ListTaps.fromJson(Map<String, dynamic> json) {
    pageID = json['PageID'];
    pageDisplay = json['PageDisplay'] ?? "";
    masterName = json['MasterName'] ?? "";
    modulName = json['ModulName'] ?? "";
    masterID = json['MasterID'];
    modulID = json['ModulID'];
    detailId = json['DetailId'];
    listName = json['ListName'] ?? "";
    tableName = json['TableName'] ?? "";
    primary = json['Primary'] ?? "";
    controllerName = json['ControllerName'] ?? "";
    tableSrc = json['TableSrc'] ?? "";
    editSrc = json['EditSrc'] ?? "";
    isCompany = json['IsCompany'];
    companyName = json['CompanyName'] ?? "";
    showPrint = json['ShowPrint'];
    showExport = json['ShowExport'];
    showSearch = json['ShowSearch'];
    showEdit = json['ShowEdit'];
    showDelete = json['ShowDelete'];
    showRowPrint = json['ShowRowPrint'];
    showNew = json['ShowNew'];
    searchFirst = json['SearchFirst'];
    showSetting = json['ShowSetting'];
    showMasterButton = json['ShowMasterButton'];
    canDrag = json['CanDrag '];
    canGroup = json['CanGroup '];
    showSum = json['ShowSum'];
    showColumnSetting = json['ShowColumnSetting'];
    showRefersh = json['ShowRefersh'];
    canSort = json['CanSort'];
    showPaging = json['ShowPaging'];
    showGroup = json['ShowGroup'];
    dataSourceApi = json['DataSourceApi'] ?? "";
    limit = json['Limit'];
    orderBy = json['OrderBy'] ?? "";
    tailCondition = json['TailCondition'] ?? "";
    master = json['Master'];
    foreignKey = json['ForeignKey'] ?? "";
    foreignKeyValue = json['ForeignKeyValue'] ?? "";
    groupLayout = json['GroupLayout'];
    groupColumn = json['GroupColumn'] ?? "";
    outSiderGroupColumn = json['OutSiderGroupColumn'] ?? "";
    editOnly = json['EditOnly'];
    listMaster = json['ListMaster'];
    excel = json['Excel'];
    excelNew = json['ExcelNew'];
    showInPopUp = json['ShowInPopUp'];
    pageAttributeId = json['PageAttributeId'];
    displayArabic = json['DisplayArabic'] ?? "";
    displayEnglish = json['DisplayEnglish'] ?? "";
    displayChinese = json['DisplayChinese'] ?? "";
    columnColor = json['ColumnColor'] ?? "";
    enName = json['EnName'] ?? "";
    isDesc = json['IsDesc'];
    unaryColumn = json['unaryColumn'] ?? "";
    numberOfEmptyRow = json['NumberOfEmptyRow'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['PageID'] = pageID;
    data['PageDisplay'] = pageDisplay;
    data['MasterName'] = masterName;
    data['ModulName'] = modulName;
    data['MasterID'] = masterID;
    data['ModulID'] = modulID;
    data['DetailId'] = detailId;
    data['ListName'] = listName;
    data['TableName'] = tableName;
    data['Primary'] = primary;
    data['ControllerName'] = controllerName;
    data['TableSrc'] = tableSrc;
    data['EditSrc'] = editSrc;
    data['IsCompany'] = isCompany;
    data['CompanyName'] = companyName;
    data['ShowPrint'] = showPrint;
    data['ShowExport'] = showExport;
    data['ShowSearch'] = showSearch;
    data['ShowEdit'] = showEdit;
    data['ShowDelete'] = showDelete;
    data['ShowRowPrint'] = showRowPrint;
    data['ShowNew'] = showNew;
    data['SearchFirst'] = searchFirst;
    data['ShowSetting'] = showSetting;
    data['ShowMasterButton'] = showMasterButton;
    data['CanDrag'] = canDrag;
    data['CanGroup'] = canGroup;
    data['ShowSum'] = showSum;
    data['ShowColumnSetting'] = showColumnSetting;
    data['ShowRefersh'] = showRefersh;
    data['CanSort'] = canSort;
    data['ShowPaging'] = showPaging;
    data['ShowGroup'] = showGroup;
    data['DataSourceApi'] = dataSourceApi;
    data['Limit'] = limit;
    data['OrderBy'] = orderBy;
    data['TailCondition'] = tailCondition;
    data['Master'] = master;
    data['ForeignKey'] = foreignKey;
    data['ForeignKeyValue'] = foreignKeyValue;
    data['GroupLayout'] = groupLayout;
    data['GroupColumn'] = groupColumn;
    data['OutSiderGroupColumn'] = outSiderGroupColumn;
    data['EditOnly'] = editOnly;
    data['ListMaster'] = listMaster;
    data['Excel'] = excel;
    data['ExcelNew'] = excelNew;
    data['ShowInPopUp'] = showInPopUp;
    data['PageAttributeId'] = pageAttributeId;
    data['DisplayArabic'] = displayArabic;
    data['DisplayEnglish'] = displayEnglish;
    data['DisplayChinese'] = displayChinese;
    data['ColumnColor'] = columnColor;
    data['EnName'] = enName;
    data['IsDesc'] = isDesc;
    data['unaryColumn'] = unaryColumn;
    data['NumberOfEmptyRow'] = numberOfEmptyRow;
    return data;
  }
}
