class TableModel {
  List<Map<String, dynamic>>? dynamicList;
  int? numberofrecords;
  List<Listes>? listes;
  Data? data;
  Atrribut? atrribut;

  TableModel(
      {this.dynamicList,
      this.numberofrecords,
      this.listes,
      this.data,
      this.atrribut});

  TableModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <Map<String, dynamic>>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(v);
      });
    }
    numberofrecords = json['numberofrecords'];
    if (json['listes'] != null) {
      listes = <Listes>[];
      json['listes'].forEach((v) {
        listes!.add(Listes.fromJson(v));
      });
    }
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    atrribut =
        json['atrribut'] != null ? Atrribut.fromJson(json['atrribut']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dynamicList != null) {
      data['dynamicList'] = dynamicList!.map((v) => v).toList();
    }
    data['numberofrecords'] = numberofrecords;
    if (listes != null) {
      data['listes'] = listes!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (atrribut != null) {
      data['atrribut'] = atrribut!.toJson();
    }
    return data;
  }
}

class Listes {
  int? id;
  String? listName;
  String? columnName;
  String? enColumnLabel;
  String? arColumnLabel;
  bool? insertVisable;
  String? insertType;
  int? userID;
  int? listID;
  int? sort;
  bool? visible;
  bool? cvisable;
  String? validation;
  bool? isKey;
  bool? isRquired;
  String? searchName;
  bool? isTotal;
  bool? insertDefult;
  bool? visableDefult;
  int? width;
  String? categoryTitle;
  int? categorySort;
  int? categoryID;
  bool? isExcel;
  bool? mobileVisable;
  int? comID;
  bool? masterInsertVisible;

  Listes(
      {this.id,
      this.listName,
      this.columnName,
      this.enColumnLabel,
      this.arColumnLabel,
      this.insertVisable,
      this.insertType,
      this.userID,
      this.listID,
      this.sort,
      this.visible,
      this.cvisable,
      this.validation,
      this.isKey,
      this.isRquired,
      this.searchName,
      this.isTotal,
      this.insertDefult,
      this.visableDefult,
      this.width,
      this.categoryTitle,
      this.categorySort,
      this.categoryID,
      this.isExcel,
      this.mobileVisable,
      this.comID,
      this.masterInsertVisible});

  Listes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listName = json['ListName'];
    columnName = json['ColumnName'];
    enColumnLabel = json['enColumnLabel'];
    arColumnLabel = json['arColumnLabel'];
    insertVisable = json['InsertVisable'];
    insertType = json['InsertType'];
    userID = json['userID'];
    listID = json['ListID'];
    sort = json['sort'];
    visible = json['visible'];
    cvisable = json['Cvisable'];
    validation = json['validation'];
    isKey = json['isKey'];
    isRquired = json['IsRquired'];
    searchName = json['SearchName'];
    isTotal = json['IsTotal'];
    insertDefult = json['InsertDefult'];
    visableDefult = json['VisableDefult'];
    width = json['Width'];
    categoryTitle = json['CategoryTitle'];
    categorySort = json['CategorySort'];
    categoryID = json['CategoryID'];
    isExcel = json['IsExcel'];
    mobileVisable = json['MobileVisable'];
    comID = json['ComID'];
    masterInsertVisible = json['MasterInsertVisible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ListName'] = listName;
    data['ColumnName'] = columnName;
    data['enColumnLabel'] = enColumnLabel;
    data['arColumnLabel'] = arColumnLabel;
    data['InsertVisable'] = insertVisable;
    data['InsertType'] = insertType;
    data['userID'] = userID;
    data['ListID'] = listID;
    data['sort'] = sort;
    data['visible'] = visible;
    data['Cvisable'] = cvisable;
    data['validation'] = validation;
    data['isKey'] = isKey;
    data['IsRquired'] = isRquired;
    data['SearchName'] = searchName;
    data['IsTotal'] = isTotal;
    data['InsertDefult'] = insertDefult;
    data['VisableDefult'] = visableDefult;
    data['Width'] = width;
    data['CategoryTitle'] = categoryTitle;
    data['CategorySort'] = categorySort;
    data['CategoryID'] = categoryID;
    data['IsExcel'] = isExcel;
    data['MobileVisable'] = mobileVisable;
    data['ComID'] = comID;
    data['MasterInsertVisible'] = masterInsertVisible;
    return data;
  }
}

class Data {
  int? id;
  String? pivotRepeat;
  String? pivotValue;
  int? pageAttributeId;
  String? reportName;
  String? tailCondition;
  String? listes;
  bool? showVSum;
  bool? sowHSum;
  String? aggrigate;
  List<Map<String, dynamic>>? pivotAuth;
  List<PivotListesItem>? pivotListes;

  Data(
      {this.id,
      this.pivotRepeat,
      this.pivotValue,
      this.pageAttributeId,
      this.reportName,
      this.tailCondition,
      this.listes,
      this.showVSum,
      this.sowHSum,
      this.aggrigate,
      this.pivotAuth,
      this.pivotListes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    pivotRepeat = json['PivotRepeat'];
    pivotValue = json['PivotValue'];
    pageAttributeId = json['PageAttributeId'];
    reportName = json['ReportName'];
    tailCondition = json['TailCondition'];
    listes = json['listes'];
    showVSum = json['ShowVSum'];
    sowHSum = json['SowHSum'];
    aggrigate = json['Aggrigate'];

    if (json['PivotAuth'] != null) {
      pivotAuth = <Map<String, dynamic>>[];
      json['PivotAuth'].forEach((v) {
        pivotAuth!.add(v);
      });
    }
    if (json['PivotListes'] != null) {
      pivotListes = <PivotListesItem>[];
      json['PivotListes'].forEach((v) {
        pivotListes!.add(PivotListesItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['PivotRepeat'] = pivotRepeat;
    data['PivotValue'] = pivotValue;
    data['PageAttributeId'] = pageAttributeId;
    data['ReportName'] = reportName;
    data['TailCondition'] = tailCondition;
    data['listes'] = listes;
    data['ShowVSum'] = showVSum;
    data['SowHSum'] = sowHSum;
    data['Aggrigate'] = aggrigate;

    if (pivotAuth != null) {
      data['PivotAuth'] = pivotAuth!.map((v) => v).toList();
    }
    if (pivotListes != null) {
      data['PivotListes'] = pivotListes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PivotListesItem {
  int? id;
  int? pivotId;
  int? listId;

  PivotListesItem({this.id, this.pivotId, this.listId});

  PivotListesItem.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    pivotId = json['PivotId'];
    listId = json['ListId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['PivotId'] = pivotId;
    data['ListId'] = listId;
    return data;
  }
}

class Atrribut {
  int? attributeId;
  int? pageId;
  String? listName;
  String? tableName;
  String? primary;
  String? controllerName;
  String? tableSrc;
  String? editSrc;
  bool? showEdit;
  bool? showDelete;
  bool? showRowPrint;
  bool? showNew;
  bool? searchFirst;
  bool? showSum;
  String? dataSourceApi;
  bool? master;
  bool? showInPopUp;
  bool? isAlarm;
  List<Map<String, dynamic>>? pageDetail;
  List<Map<String, dynamic>>? pivotReport;

  Atrribut(
      {this.attributeId,
      this.pageId,
      this.listName,
      this.tableName,
      this.primary,
      this.controllerName,
      this.tableSrc,
      this.editSrc,
      this.showEdit,
      this.showDelete,
      this.showRowPrint,
      this.showNew,
      this.searchFirst,
      this.showSum,
      this.dataSourceApi,
      this.master,
      this.showInPopUp,
      this.isAlarm,
      this.pageDetail,
      this.pivotReport});

  Atrribut.fromJson(Map<String, dynamic> json) {
    attributeId = json['AttributeId'];
    pageId = json['PageId'];
    listName = json['ListName'];
    tableName = json['TableName'];
    primary = json['Primary'];
    controllerName = json['ControllerName'];
    tableSrc = json['TableSrc'];
    editSrc = json['EditSrc'];
    showEdit = json['ShowEdit'];
    showDelete = json['ShowDelete'];
    showRowPrint = json['ShowRowPrint'];
    showNew = json['ShowNew'];
    searchFirst = json['SearchFirst'];
    showSum = json['ShowSum'];
    dataSourceApi = json['DataSourceApi'];
    master = json['Master'];
    showInPopUp = json['ShowInPopUp'];
    isAlarm = json['IsAlarm'];

    if (json['PageDetail'] != null) {
      pageDetail = <Map<String, dynamic>>[];
      json['PageDetail'].forEach((v) {
        pageDetail!.add(v);
      });
    }

    if (json['PivotReport'] != null) {
      pivotReport = <Map<String, dynamic>>[];
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
    data['ControllerName'] = controllerName;
    data['TableSrc'] = tableSrc;
    data['EditSrc'] = editSrc;
    data['ShowEdit'] = showEdit;
    data['ShowDelete'] = showDelete;
    data['ShowRowPrint'] = showRowPrint;
    data['ShowNew'] = showNew;
    data['SearchFirst'] = searchFirst;
    data['ShowSum'] = showSum;
    data['DataSourceApi'] = dataSourceApi;
    data['Master'] = master;
    data['ShowInPopUp'] = showInPopUp;
    data['IsAlarm'] = isAlarm;

    if (pageDetail != null) {
      data['PageDetail'] = pageDetail!.map((v) => v).toList();
    }

    if (pivotReport != null) {
      data['PivotReport'] = pivotReport!.map((v) => v).toList();
    }

    return data;
  }
}
