// class PagesForNotificationsModel {
//   int? attributeId;
//   int? pageId;
//   String? listName;
//   String? tableName;
//   String? primary;
//   bool? showEdit;
//   bool? showDelete;
//   bool? showNew;
//   bool? showSum;
//   String? tailCondition;
//   bool? isAlarm;
//   String? viewEmployeeColumn;
//   PageNotificationItem? pageNotification;
//   List<dynamic>? pageDetail;
//   List<dynamic>? pivotReport;
//
//   PagesForNotificationsModel(
//       {this.attributeId,
//       this.pageId,
//       this.listName,
//       this.tableName,
//       this.primary,
//       this.showEdit,
//       this.showDelete,
//       this.showNew,
//       this.showSum,
//       this.tailCondition,
//       this.isAlarm,
//       this.viewEmployeeColumn,
//       this.pageNotification,
//       this.pageDetail,
//       this.pivotReport});
//
//   PagesForNotificationsModel.fromJson(Map<String, dynamic> json) {
//     attributeId = json['AttributeId'];
//     pageId = json['PageId'];
//     listName = json['ListName'];
//     tableName = json['TableName'];
//     primary = json['Primary'];
//     showEdit = json['ShowEdit'];
//     showDelete = json['ShowDelete'];
//     showNew = json['ShowNew'];
//     showSum = json['ShowSum'];
//     tailCondition = json['TailCondition'];
//     isAlarm = json['IsAlarm'];
//     viewEmployeeColumn = json['ViewEmployeeColumn'];
//     pageNotification = json['Page'] != null
//         ? PageNotificationItem.fromJson(json['Page'])
//         : null;
//     if (json['PageDetail'] != null) {
//       pageDetail = <dynamic>[];
//       json['PageDetail'].forEach((v) {
//         pageDetail!.add(v);
//       });
//     }
//     if (json['PivotReport'] != null) {
//       pivotReport = <dynamic>[];
//       json['PivotReport'].forEach((v) {
//         pivotReport!.add(v);
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['AttributeId'] = attributeId;
//     data['PageId'] = pageId;
//     data['ListName'] = listName;
//     data['TableName'] = tableName;
//     data['Primary'] = primary;
//     data['ShowEdit'] = showEdit;
//     data['ShowDelete'] = showDelete;
//     data['ShowNew'] = showNew;
//     data['ShowSum'] = showSum;
//     data['TailCondition'] = tailCondition;
//     data['IsAlarm'] = isAlarm;
//     data['ViewEmployeeColumn'] = viewEmployeeColumn;
//     if (pageNotification != null) {
//       data['Page'] = pageNotification!.toJson();
//     }
//     if (pageDetail != null) {
//       data['PageDetail'] = pageDetail!.map((v) => v.toJson()).toList();
//     }
//     if (pivotReport != null) {
//       data['PivotReport'] = pivotReport!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class PageNotificationItem {
//   int? pageID;
//   String? pageName;
//   String? pageDisplay;
//   String? enName;
//   String? url;
//   String? menuOrder;
//   int? masterID;
//   String? icon;
//   int? modulID;
//   bool? askBeforeOpen;
//   bool? allowMobile;
//   bool? mobileFastScreen;
//   List<dynamic>? alarmAttribute;
//   List<dynamic>? chartPages;
//   List<dynamic>? listSetups;
//   List<dynamic>? notificationSettings;
//   List<dynamic>? pageAuth;
//   List<dynamic>? templateContent;
//   List<dynamic>? templet;
//   List<dynamic>? wordTemplate;
//   List<dynamic>? wordTemplateTables;
//
//   PageNotificationItem(
//       {this.pageID,
//       this.pageName,
//       this.pageDisplay,
//       this.enName,
//       this.url,
//       this.menuOrder,
//       this.masterID,
//       this.icon,
//       this.modulID,
//       this.askBeforeOpen,
//       this.allowMobile,
//       this.mobileFastScreen,
//       this.alarmAttribute,
//       this.chartPages,
//       this.listSetups,
//       this.notificationSettings,
//       this.pageAuth,
//       this.templateContent,
//       this.templet,
//       this.wordTemplate,
//       this.wordTemplateTables});
//
//   PageNotificationItem.fromJson(Map<String, dynamic> json) {
//     pageID = json['PageID'];
//     pageName = json['PageName'];
//     pageDisplay = json['PageDisplay'];
//     enName = json['EnName'];
//     url = json['Url'];
//     menuOrder = json['MenuOrder'];
//     masterID = json['MasterID'];
//     icon = json['Icon'];
//     modulID = json['ModulID'];
//     askBeforeOpen = json['AskBeforeOpen'];
//     allowMobile = json['AllowMobile'];
//     mobileFastScreen = json['MobileFastScreen'];
//     if (json['AlarmAttribute'] != null) {
//       alarmAttribute = <dynamic>[];
//       json['AlarmAttribute'].forEach((v) {
//         alarmAttribute!.add(v);
//       });
//     }
//     if (json['ChartPages'] != null) {
//       chartPages = <dynamic>[];
//       json['ChartPages'].forEach((v) {
//         chartPages!.add(v);
//       });
//     }
//     if (json['ListSetups'] != null) {
//       listSetups = <dynamic>[];
//       json['ListSetups'].forEach((v) {
//         listSetups!.add(v);
//       });
//     }
//     if (json['NotificationSettings'] != null) {
//       notificationSettings = <dynamic>[];
//       json['NotificationSettings'].forEach((v) {
//         notificationSettings!.add(v);
//       });
//     }
//     if (json['PageAuth'] != null) {
//       pageAuth = <dynamic>[];
//       json['PageAuth'].forEach((v) {
//         pageAuth!.add(v);
//       });
//     }
//     if (json['TemplateContent'] != null) {
//       templateContent = <dynamic>[];
//       json['TemplateContent'].forEach((v) {
//         templateContent!.add(v);
//       });
//     }
//     if (json['Templet'] != null) {
//       templet = <dynamic>[];
//       json['Templet'].forEach((v) {
//         templet!.add(v);
//       });
//     }
//     if (json['WordTemplate'] != null) {
//       wordTemplate = <dynamic>[];
//       json['WordTemplate'].forEach((v) {
//         wordTemplate!.add(v);
//       });
//     }
//     if (json['WordTemplateTables'] != null) {
//       wordTemplateTables = <dynamic>[];
//       json['WordTemplateTables'].forEach((v) {
//         wordTemplateTables!.add(v);
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['PageID'] = pageID;
//     data['PageName'] = pageName;
//     data['PageDisplay'] = pageDisplay;
//     data['EnName'] = enName;
//     data['Url'] = url;
//     data['MenuOrder'] = menuOrder;
//     data['MasterID'] = masterID;
//     data['Icon'] = icon;
//     data['ModulID'] = modulID;
//     data['AskBeforeOpen'] = askBeforeOpen;
//     data['AllowMobile'] = allowMobile;
//     data['MobileFastScreen'] = mobileFastScreen;
//     if (alarmAttribute != null) {
//       data['AlarmAttribute'] = alarmAttribute!.map((v) => v.toJson()).toList();
//     }
//     if (chartPages != null) {
//       data['ChartPages'] = chartPages!.map((v) => v.toJson()).toList();
//     }
//     if (listSetups != null) {
//       data['ListSetups'] = listSetups!.map((v) => v.toJson()).toList();
//     }
//     if (notificationSettings != null) {
//       data['NotificationSettings'] =
//           notificationSettings!.map((v) => v.toJson()).toList();
//     }
//     if (pageAuth != null) {
//       data['PageAuth'] = pageAuth!.map((v) => v.toJson()).toList();
//     }
//     if (templateContent != null) {
//       data['TemplateContent'] =
//           templateContent!.map((v) => v.toJson()).toList();
//     }
//     if (templet != null) {
//       data['Templet'] = templet!.map((v) => v.toJson()).toList();
//     }
//     if (wordTemplate != null) {
//       data['WordTemplate'] = wordTemplate!.map((v) => v.toJson()).toList();
//     }
//     if (wordTemplateTables != null) {
//       data['WordTemplateTables'] =
//           wordTemplateTables!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
class PagesForNotificationsModel {
  int? pageID;
  String? pageName;
  String? pageDisplay;
  String? enName;
  String? url;
  String? menuOrder;
  int? masterID;
  int? modulID;
  bool? askBeforeOpen;
  int? attributeId;
  String? listName;
  String? tableName;
  String? primary;
  String? controllerName;
  String? tailCondition;
  bool? master;
  bool? showInPopUp;
  String? viewEmployeeColumn;
  int? authorizationID;
  bool? isAlarm;
  bool? disable;

  PagesForNotificationsModel(
      {this.pageID,
      this.pageName,
      this.pageDisplay,
      this.enName,
      this.url,
      this.menuOrder,
      this.masterID,
      this.modulID,
      this.askBeforeOpen,
      this.attributeId,
      this.listName,
      this.tableName,
      this.primary,
      this.controllerName,
      this.tailCondition,
      this.master,
      this.showInPopUp,
      this.viewEmployeeColumn,
      this.authorizationID,
      this.isAlarm,
      this.disable});

  PagesForNotificationsModel.fromJson(Map<String, dynamic> json) {
    pageID = json['PageID'];
    pageName = json['PageName'];
    pageDisplay = json['PageDisplay'];
    enName = json['EnName'];
    url = json['Url'];
    menuOrder = json['MenuOrder'];
    masterID = json['MasterID'];
    modulID = json['ModulID'];
    askBeforeOpen = json['AskBeforeOpen'];
    attributeId = json['AttributeId'];
    listName = json['ListName'];
    tableName = json['TableName'];
    primary = json['Primary'];
    controllerName = json['ControllerName'];
    tailCondition = json['TailCondition'];
    master = json['Master'];
    showInPopUp = json['ShowInPopUp'];
    viewEmployeeColumn = json['ViewEmployeeColumn'];
    authorizationID = json['AuthorizationID'];
    isAlarm = json['IsAlarm'];
    disable = json['Disable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PageID'] = pageID;
    data['PageName'] = pageName;
    data['PageDisplay'] = pageDisplay;
    data['EnName'] = enName;
    data['Url'] = url;
    data['MenuOrder'] = menuOrder;
    data['MasterID'] = masterID;
    data['ModulID'] = modulID;
    data['AskBeforeOpen'] = askBeforeOpen;
    data['AttributeId'] = attributeId;
    data['ListName'] = listName;
    data['TableName'] = tableName;
    data['Primary'] = primary;
    data['ControllerName'] = controllerName;
    data['TailCondition'] = tailCondition;
    data['Master'] = master;
    data['ShowInPopUp'] = showInPopUp;
    data['ViewEmployeeColumn'] = viewEmployeeColumn;
    data['AuthorizationID'] = authorizationID;
    data['IsAlarm'] = isAlarm;
    data['Disable'] = disable;
    return data;
  }
}
