class Pages {
  Pages({
    required this.pageId,
    required this.nameAr,
    required this.nameEn,
    required this.navigationKey,
    required this.icon,
    required this.isFastScreen,
    required this.moduleID,
    required this.url,
    required this.tableSrc,
    required this.editSrc,
    required this.controllerName,
    required this.primary,
    required this.isDepartment,
    required this.departmentName,
    required this.authorizationID,
    required this.viewEmployeeColumn,
    required this.orderBy,
    required this.isDesc,
    required this.listName,
    required this.tableName,
    required this.isCompany,
    required this.companyName,
    required this.searchFirst,
    required this.canDrag,
    required this.canGroup,
    required this.canSort,
    required this.dataSourceApi,
    required this.limit,
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
    required this.editOnlyPrimary,
    required this.isAlarm,
    required this.alarmOrder,
    required this.alarmSort,
    required this.alarmSortType,
    required this.columnColor,
    required this.closingDateColumn,
    required this.departmentColumn,
    required this.emailField,
    required this.pivotRepeat,
    required this.pivotValue,
    required this.numberOfEmptyRow,
    required this.isCashed,
    required this.cashedTableName,
    required this.unaryColumn,
  });
  late final int pageId;
  late final String nameAr;
  late final String nameEn;
  late final String navigationKey;
  late final String icon;
  late final bool isFastScreen;
  late final int moduleID;
  late final String url;
  late final String tableSrc;
  late final String editSrc;
  late final String controllerName;
  late final String primary;
  late final bool isDepartment;
  late final String departmentName;
  late final int authorizationID;
  late final String viewEmployeeColumn;
  late final String orderBy;
  late final bool isDesc;

  late final String listName;
  late final String tableName;
  late final bool? isCompany;
  late final String companyName;
  late final bool? searchFirst;
  late final bool? canDrag;
  late final bool? canGroup;
  late final bool? canSort;
  late final String dataSourceApi;
  late final int? limit;
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
  late final int? editOnlyPrimary;
  late final bool? isAlarm;
  late final int? alarmOrder;
  late final String alarmSort;
  late final bool? alarmSortType;
  late final String columnColor;
  late final String closingDateColumn;
  late final String departmentColumn;
  late final String emailField;
  late final String pivotRepeat;
  late final String pivotValue;
  late final int? numberOfEmptyRow;
  late final bool? isCashed;
  late final String cashedTableName;
  late final String unaryColumn;
  Pages.fromJson(Map<String, dynamic> json) {
    pageId = json['PageId'];
    nameAr = json['NameAr'];
    nameEn = json['NameEn'];
    navigationKey = json['NavigationKey'];
    icon = json['Icon'];
    isFastScreen = json['IsFastScreen'];
    moduleID = json['ModuleID'];
    url = json['Url'];
    tableSrc = json['TableSrc'];
    editSrc = json['EditSrc'];
    controllerName = json['ControllerName'];
    primary = json['Primary'];
    isDepartment = json['IsDepartment'];
    departmentName = json['DepartmentName'];
    authorizationID = json['AuthorizationID'];
    viewEmployeeColumn = json['ViewEmployeeColumn'];
    orderBy = json['OrderBy'];
    isDesc = json['IsDesc'];
    listName = json['ListName'] ?? "";
    tableName = json['TableName'] ?? "";
    isCompany = json['IsCompany'];
    companyName = json['CompanyName'] ?? "";
    searchFirst = json['SearchFirst'];
    canDrag = json['CanDrag'];
    canGroup = json['CanGroup'];
    canSort = json['CanSort'];
    dataSourceApi = json['DataSourceApi'] ?? "";
    limit = json['Limit'];
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
    editOnlyPrimary = json['EditOnlyPrimary'];
    isAlarm = json['IsAlarm'];
    alarmOrder = json['AlarmOrder'];
    alarmSort = json['AlarmSort'] ?? "";
    alarmSortType = json['AlarmSortType'];
    columnColor = json['ColumnColor'] ?? "";
    closingDateColumn = json['ClosingDateColumn'] ?? "";
    departmentColumn = json['DepartmentCoulmn'] ?? "";
    emailField = json['EmailField'] ?? "";
    pivotRepeat = json['PivotRepeat'] ?? "";
    pivotValue = json['PivotValue'] ?? "";
    numberOfEmptyRow = json['NumberOfEmptyRow'];
    isCashed = json['IsCashed'];
    cashedTableName = json['CashedTableName'] ?? "";
    unaryColumn = json['UnaryColumn'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['PageId'] = pageId;
    data['NameAr'] = nameAr;
    data['NameEn'] = nameEn;
    data['NavigationKey'] = navigationKey;
    data['Icon'] = icon;
    data['IsFastScreen'] = isFastScreen;
    data['ModuleID'] = moduleID;
    data['Url'] = url;
    data['TableSrc'] = tableSrc;
    data['EditSrc'] = editSrc;
    data['ControllerName'] = controllerName;
    data['Primary'] = primary;
    data['IsDepartment'] = isDepartment;
    data['DepartmentName'] = departmentName;
    data['AuthorizationID'] = authorizationID;
    data['ViewEmployeeColumn'] = viewEmployeeColumn;
    data['OrderBy'] = orderBy;
    data['IsDesc'] = isDesc;
    data['ListName'] = listName;
    data['TableName'] = tableName;
    data['IsCompany'] = isCompany;
    data['CompanyName'] = companyName;
    data['SearchFirst'] = searchFirst;
    data['CanDrag'] = canDrag;
    data['CanGroup'] = canGroup;
    data['CanSort'] = canSort;
    data['DataSourceApi'] = dataSourceApi;
    data['Limit'] = limit;
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
    data['EditOnlyPrimary'] = editOnlyPrimary;
    data['IsAlarm'] = isAlarm;
    data['AlarmOrder'] = alarmOrder;
    data['AlarmSort'] = alarmSort;
    data['AlarmSortType'] = alarmSortType;
    data['ColumnColor'] = columnColor;
    data['ClosingDateColumn'] = closingDateColumn;
    data['DepartmentCoulmn'] = departmentColumn;
    data['EmailField'] = emailField;
    data['PivotRepeat'] = pivotRepeat;
    data['PivotValue'] = pivotValue;
    data['NumberOfEmptyRow'] = numberOfEmptyRow;
    data['IsCashed'] = isCashed;
    data['CashedTableName'] = cashedTableName;
    data['UnaryColumn'] = unaryColumn;
    return data;
  }
}
