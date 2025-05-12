class TabsModel {
  int? attributeId;
  int? pageId;
  String? listName;
  String? tableName;
  String? primary;
  String? tableSrc;
  bool? isCompany;
  bool? showEdit;
  bool? showDelete;
  bool? showNew;
  bool? master;
  bool? editOnly;
  bool? isAlarm;
  List<PageDetail>? pageDetail;
  List<dynamic>? pivotReport;

  TabsModel(
      {this.attributeId,
      this.pageId,
      this.listName,
      this.tableName,
      this.primary,
      this.tableSrc,
      this.isCompany,
      this.showEdit,
      this.showDelete,
      this.showNew,
      this.master,
      this.editOnly,
      this.isAlarm,
      this.pageDetail,
      this.pivotReport});

  TabsModel.fromJson(Map<String, dynamic> json) {
    attributeId = json['AttributeId'];
    pageId = json['PageId'];
    listName = json['ListName'];
    tableName = json['TableName'];
    primary = json['Primary'];
    tableSrc = json['TableSrc'];
    isCompany = json['IsCompany'];
    showEdit = json['ShowEdit'];
    showDelete = json['ShowDelete'];
    showNew = json['ShowNew'];
    master = json['Master'];
    editOnly = json['EditOnly'];
    isAlarm = json['IsAlarm'];
    if (json['PageDetail'] != null) {
      pageDetail = <PageDetail>[];
      json['PageDetail'].forEach((v) {
        pageDetail!.add(PageDetail.fromJson(v));
      });
    }
    if (json['PivotReport'] != null) {
      pivotReport = <dynamic>[];
      json['PivotReport'].forEach((v) {
        pivotReport!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AttributeId'] = attributeId;
    data['PageId'] = pageId;
    data['ListName'] = listName;
    data['TableName'] = tableName;
    data['Primary'] = primary;
    data['TableSrc'] = tableSrc;
    data['IsCompany'] = isCompany;
    data['ShowEdit'] = showEdit;
    data['ShowDelete'] = showDelete;
    data['ShowNew'] = showNew;
    data['Master'] = master;
    data['EditOnly'] = editOnly;
    data['IsAlarm'] = isAlarm;
    if (pageDetail != null) {
      data['PageDetail'] = pageDetail!.map((v) => v.toJson()).toList();
    }
    if (pivotReport != null) {
      data['PivotReport'] = pivotReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageDetail {
  int? detailId;
  String? listName;
  String? tableName;
  String? primary;
  bool? showPrint;
  bool? showExport;
  bool? showEdit;
  bool? showDelete;
  bool? showRowPrint;
  bool? showNew;
  String? foreignKey;
  int? pageAttributeId;
  String? displayArabic;
  String? displayEnglish;
  String? controllerName;

  PageDetail(
      {this.detailId,
      this.listName,
      this.tableName,
      this.primary,
      this.showPrint,
      this.showExport,
      this.showEdit,
      this.showDelete,
      this.showRowPrint,
      this.showNew,
      this.foreignKey,
      this.pageAttributeId,
      this.displayArabic,
      this.displayEnglish,
      this.controllerName});

  PageDetail.fromJson(Map<String, dynamic> json) {
    detailId = json['DetailId'];
    listName = json['ListName'];
    tableName = json['TableName'];
    primary = json['Primary'];
    showPrint = json['ShowPrint'];
    showExport = json['ShowExport'];
    showEdit = json['ShowEdit'];
    showDelete = json['ShowDelete'];
    showRowPrint = json['ShowRowPrint'];
    showNew = json['ShowNew'];
    foreignKey = json['ForeignKey'];
    pageAttributeId = json['PageAttributeId'];
    displayArabic = json['DisplayArabic'];
    displayEnglish = json['DisplayEnglish'];
    controllerName = json['ControllerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DetailId'] = detailId;
    data['ListName'] = listName;
    data['TableName'] = tableName;
    data['Primary'] = primary;
    data['ShowPrint'] = showPrint;
    data['ShowExport'] = showExport;
    data['ShowEdit'] = showEdit;
    data['ShowDelete'] = showDelete;
    data['ShowRowPrint'] = showRowPrint;
    data['ShowNew'] = showNew;
    data['ForeignKey'] = foreignKey;
    data['PageAttributeId'] = pageAttributeId;
    data['DisplayArabic'] = displayArabic;
    data['DisplayEnglish'] = displayEnglish;
    data['ControllerName'] = controllerName;
    return data;
  }
}
