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
    return data;
  }
}
