/*class TableModel {
  List? dynamicList;
  int? numberofrecords;
  List<Listes>? listes;
  Data? data;
  Atrribut? atrribut;

  TableModel({
    this.dynamicList,
    this.numberofrecords,
    this.listes,
    this.data,
    this.atrribut,
  });

  TableModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = [];
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
    atrribut = json['atrribut'] != null ? Atrribut.fromJson(json['atrribut']) : null;
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
}*/
class TableModel {
  TableModel({
    required this.dynamicList,
    required this.numberofrecords,
    required this.listes,
    required this.data,
    required this.atrribut,
    required this.typesAggrigates,
    required this.repeatelists,
    required this.arabicLableAggrigate,
  });

  final List<dynamic> dynamicList;
  final int? numberofrecords;
  final List<Liste> listes;
  final Data? data;
  final Atrribut? atrribut;
  final List<String> typesAggrigates;
  final List<Liste> repeatelists;
  final List<ArabicLableAggrigate> arabicLableAggrigate;

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      dynamicList: json["dynamicList"] == null
          ? []
          : List<dynamic>.from(json["dynamicList"]!.map((x) => x)),
      numberofrecords: json["numberofrecords"],
      listes: json["listes"] == null
          ? []
          : List<Liste>.from(json["listes"]!.map((x) => Liste.fromJson(x))),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      atrribut: json["atrribut"] == null ? null : Atrribut.fromJson(json["atrribut"]),
      typesAggrigates: json["TypesAggrigates"] == null
          ? []
          : List<String>.from(json["TypesAggrigates"]!.map((x) => x)),
      repeatelists: json["repeatelists"] == null
          ? []
          : List<Liste>.from(json["repeatelists"]!.map((x) => Liste.fromJson(x))),
      arabicLableAggrigate: json["ArabicLableAggrigate"] == null
          ? []
          : List<ArabicLableAggrigate>.from(
              json["ArabicLableAggrigate"]!.map((x) => ArabicLableAggrigate.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "dynamicList": dynamicList.map((x) => x).toList(),
        "numberofrecords": numberofrecords,
        "listes": listes.map((x) => x.toJson()).toList(),
        "data": data?.toJson(),
        "atrribut": atrribut?.toJson(),
        "TypesAggrigates": typesAggrigates.map((x) => x).toList(),
        "repeatelists": repeatelists.map((x) => x.toJson()).toList(),
        "ArabicLableAggrigate": arabicLableAggrigate.map((x) => x.toJson()).toList(),
      };
}

class ArabicLableAggrigate {
  ArabicLableAggrigate({
    required this.id,
    required this.listName,
    required this.searchName,
    required this.columnName,
    required this.insertType,
    required this.arColumnLabel,
    required this.isTotal,
    required this.visible,
    required this.insertVisable,
    required this.isRquired,
    required this.enColumnLabel,
    required this.sort,
    required this.width,
    required this.validation,
    required this.isKey,
    required this.visableDefult,
    required this.insertDefult,
    required this.linkTarget,
    required this.targetPrimayColumn,
    required this.categoryId,
    required this.mobileVisable,
    required this.userVisible,
    required this.linkPrimary,
  });

  final int? id;
  final String? listName;
  final String? searchName;
  final String? columnName;
  final String? insertType;
  final String? arColumnLabel;
  final bool? isTotal;
  final bool? visible;
  final bool? insertVisable;
  final bool? isRquired;
  final String? enColumnLabel;
  final int? sort;
  final int? width;
  final String? validation;
  final bool? isKey;
  final bool? visableDefult;
  final bool? insertDefult;
  final String? linkTarget;
  final String? targetPrimayColumn;
  final int? categoryId;
  final bool? mobileVisable;
  final bool? userVisible;
  final String? linkPrimary;

  factory ArabicLableAggrigate.fromJson(Map<String, dynamic> json) {
    return ArabicLableAggrigate(
      id: json["id"],
      listName: json["ListName"],
      searchName: json["SearchName"],
      columnName: json["ColumnName"],
      insertType: json["InsertType"],
      arColumnLabel: json["arColumnLabel"],
      isTotal: json["IsTotal"],
      visible: json["visible"],
      insertVisable: json["InsertVisable"],
      isRquired: json["IsRquired"],
      enColumnLabel: json["enColumnLabel"],
      sort: json["sort"],
      width: json["Width"],
      validation: json["validation"],
      isKey: json["isKey"],
      visableDefult: json["VisableDefult"],
      insertDefult: json["InsertDefult"],
      linkTarget: json["LinkTarget"],
      targetPrimayColumn: json["TargetPrimayColumn"],
      categoryId: json["CategoryID"],
      mobileVisable: json["MobileVisable"],
      userVisible: json["UserVisible"],
      linkPrimary: json["LinkPrimary"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "ListName": listName,
        "SearchName": searchName,
        "ColumnName": columnName,
        "InsertType": insertType,
        "arColumnLabel": arColumnLabel,
        "IsTotal": isTotal,
        "visible": visible,
        "InsertVisable": insertVisable,
        "IsRquired": isRquired,
        "enColumnLabel": enColumnLabel,
        "sort": sort,
        "Width": width,
        "validation": validation,
        "isKey": isKey,
        "VisableDefult": visableDefult,
        "InsertDefult": insertDefult,
        "LinkTarget": linkTarget,
        "TargetPrimayColumn": targetPrimayColumn,
        "CategoryID": categoryId,
        "MobileVisable": mobileVisable,
        "UserVisible": userVisible,
        "LinkPrimary": linkPrimary,
      };
}

class Atrribut {
  Atrribut({
    required this.attributeId,
    required this.pageId,
    required this.listName,
    required this.tableName,
    required this.primary,
    required this.controllerName,
    required this.tableSrc,
    required this.editSrc,
    required this.showEdit,
    required this.showDelete,
    required this.showRowPrint,
    required this.showNew,
    required this.searchFirst,
    required this.showSum,
    required this.dataSourceApi,
    required this.master,
    required this.showInPopUp,
    required this.isAlarm,
    required this.isDepartment,
    required this.departmentCoulmn,
    required this.pageDetail,
    required this.pivotReport,
  });

  final int? attributeId;
  final int? pageId;
  final String? listName;
  final String? tableName;
  final String? primary;
  final String? controllerName;
  final String? tableSrc;
  final String? editSrc;
  final bool? showEdit;
  final bool? showDelete;
  final bool? showRowPrint;
  final bool? showNew;
  final bool? searchFirst;
  final bool? showSum;
  final String? dataSourceApi;
  final bool? master;
  final bool? showInPopUp;
  final bool? isAlarm;
  final bool? isDepartment;
  final String? departmentCoulmn;
  final List<dynamic> pageDetail;
  final List<dynamic> pivotReport;

  factory Atrribut.fromJson(Map<String, dynamic> json) {
    return Atrribut(
      attributeId: json["AttributeId"],
      pageId: json["PageId"],
      listName: json["ListName"],
      tableName: json["TableName"],
      primary: json["Primary"],
      controllerName: json["ControllerName"],
      tableSrc: json["TableSrc"],
      editSrc: json["EditSrc"],
      showEdit: json["ShowEdit"],
      showDelete: json["ShowDelete"],
      showRowPrint: json["ShowRowPrint"],
      showNew: json["ShowNew"],
      searchFirst: json["SearchFirst"],
      showSum: json["ShowSum"],
      dataSourceApi: json["DataSourceApi"],
      master: json["Master"],
      showInPopUp: json["ShowInPopUp"],
      isAlarm: json["IsAlarm"],
      isDepartment: json["IsDepartment"],
      departmentCoulmn: json["DepartmentCoulmn"],
      pageDetail: json["PageDetail"] == null
          ? []
          : List<dynamic>.from(json["PageDetail"]!.map((x) => x)),
      pivotReport: json["PivotReport"] == null
          ? []
          : List<dynamic>.from(json["PivotReport"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "AttributeId": attributeId,
        "PageId": pageId,
        "ListName": listName,
        "TableName": tableName,
        "Primary": primary,
        "ControllerName": controllerName,
        "TableSrc": tableSrc,
        "EditSrc": editSrc,
        "ShowEdit": showEdit,
        "ShowDelete": showDelete,
        "ShowRowPrint": showRowPrint,
        "ShowNew": showNew,
        "SearchFirst": searchFirst,
        "ShowSum": showSum,
        "DataSourceApi": dataSourceApi,
        "Master": master,
        "ShowInPopUp": showInPopUp,
        "IsAlarm": isAlarm,
        "IsDepartment": isDepartment,
        "DepartmentCoulmn": departmentCoulmn,
        "PageDetail": pageDetail.map((x) => x).toList(),
        "PivotReport": pivotReport.map((x) => x).toList(),
      };
}

class Data {
  Data({
    required this.id,
    required this.pivotRepeat,
    required this.pivotValue,
    required this.pageAttributeId,
    required this.reportName,
    required this.tailCondition,
    required this.listes,
    required this.showVSum,
    required this.sowHSum,
    required this.aggrigate,
    required this.pivotAggriagteTypes,
    required this.pivotAuth,
    required this.pivotListes,
  });

  final int? id;
  final String? pivotRepeat;
  final String? pivotValue;
  final int? pageAttributeId;
  final String? reportName;
  final String? tailCondition;
  final String? listes;
  final bool? showVSum;
  final bool? sowHSum;
  final String? aggrigate;
  final List<PivotAggriagteType> pivotAggriagteTypes;
  final List<dynamic> pivotAuth;
  final List<PivotListe> pivotListes;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["Id"],
      pivotRepeat: json["PivotRepeat"],
      pivotValue: json["PivotValue"],
      pageAttributeId: json["PageAttributeId"],
      reportName: json["ReportName"],
      tailCondition: json["TailCondition"],
      listes: json["listes"],
      showVSum: json["ShowVSum"],
      sowHSum: json["SowHSum"],
      aggrigate: json["Aggrigate"],
      pivotAggriagteTypes: json["PivotAggriagteTypes"] == null
          ? []
          : List<PivotAggriagteType>.from(
              json["PivotAggriagteTypes"]!.map((x) => PivotAggriagteType.fromJson(x))),
      pivotAuth: json["PivotAuth"] == null
          ? []
          : List<dynamic>.from(json["PivotAuth"]!.map((x) => x)),
      pivotListes: json["PivotListes"] == null
          ? []
          : List<PivotListe>.from(
              json["PivotListes"]!.map((x) => PivotListe.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "Id": id,
        "PivotRepeat": pivotRepeat,
        "PivotValue": pivotValue,
        "PageAttributeId": pageAttributeId,
        "ReportName": reportName,
        "TailCondition": tailCondition,
        "listes": listes,
        "ShowVSum": showVSum,
        "SowHSum": sowHSum,
        "Aggrigate": aggrigate,
        "PivotAggriagteTypes": pivotAggriagteTypes.map((x) => x.toJson()).toList(),
        "PivotAuth": pivotAuth.map((x) => x).toList(),
        "PivotListes": pivotListes.map((x) => x.toJson()).toList(),
      };
}

class PivotAggriagteType {
  PivotAggriagteType({
    required this.id,
    required this.pivotId,
    required this.columnName,
    required this.typeAggriagte,
  });

  final int? id;
  final int? pivotId;
  final String? columnName;
  final String? typeAggriagte;

  factory PivotAggriagteType.fromJson(Map<String, dynamic> json) {
    return PivotAggriagteType(
      id: json["ID"],
      pivotId: json["PivotId"],
      columnName: json["ColumnName"],
      typeAggriagte: json["TypeAggriagte"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ID": id,
        "PivotId": pivotId,
        "ColumnName": columnName,
        "TypeAggriagte": typeAggriagte,
      };
}

class PivotListe {
  PivotListe({
    required this.id,
    required this.pivotId,
    required this.listId,
  });

  final int? id;
  final int? pivotId;
  final int? listId;

  factory PivotListe.fromJson(Map<String, dynamic> json) {
    return PivotListe(
      id: json["Id"],
      pivotId: json["PivotId"],
      listId: json["ListId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Id": id,
        "PivotId": pivotId,
        "ListId": listId,
      };
}

class Liste {
  Liste({
    required this.id,
    required this.listName,
    required this.columnName,
    required this.enColumnLabel,
    required this.arColumnLabel,
    required this.insertVisable,
    required this.insertType,
    required this.userId,
    required this.listId,
    required this.sort,
    required this.visible,
    required this.droModel,
    required this.droValue,
    required this.droText,
    required this.droCompany,
    required this.cvisable,
    required this.validation,
    required this.isKey,
    required this.isRquired,
    required this.searchName,
    required this.insertDefult,
    required this.visableDefult,
    required this.width,
    required this.linkTarget,
    required this.targetPrimayColumn,
    required this.categoryTitle,
    required this.categorySort,
    required this.categoryId,
    required this.isExcel,
    required this.mobileVisable,
    required this.isDepartment,
    required this.departmentCoulmn,
    required this.pageId,
    required this.comId,
    required this.masterInsertVisible,
    required this.linkPrimary,
    required this.insertIntoColumnName,
  });

  final int? id;
  final String? listName;
  final String? columnName;
  final String? enColumnLabel;
  final String? arColumnLabel;
  final bool? insertVisable;
  final String? insertType;
  final int? userId;
  final int? listId;
  final int? sort;
  final bool? visible;
  final String? droModel;
  final String? droValue;
  final String? droText;
  final String? droCompany;
  final bool? cvisable;
  final String? validation;
  final bool? isKey;
  final bool? isRquired;
  final String? searchName;
  final bool? insertDefult;
  final bool? visableDefult;
  final int? width;
  final String? linkTarget;
  final String? targetPrimayColumn;
  final String? categoryTitle;
  final int? categorySort;
  final int? categoryId;
  final bool? isExcel;
  final bool? mobileVisable;
  final bool? isDepartment;
  final String? departmentCoulmn;
  final int? pageId;
  final int? comId;
  final bool? masterInsertVisible;
  final String? linkPrimary;
  final String? insertIntoColumnName;

  factory Liste.fromJson(Map<String, dynamic> json) {
    return Liste(
      id: json["id"],
      listName: json["ListName"],
      columnName: json["ColumnName"],
      enColumnLabel: json["enColumnLabel"],
      arColumnLabel: json["arColumnLabel"],
      insertVisable: json["InsertVisable"],
      insertType: json["InsertType"],
      userId: json["userID"],
      listId: json["ListID"],
      sort: json["sort"],
      visible: json["visible"],
      droModel: json["DroModel"],
      droValue: json["DroValue"],
      droText: json["DroText"],
      droCompany: json["DroCompany"],
      cvisable: json["Cvisable"],
      validation: json["validation"],
      isKey: json["isKey"],
      isRquired: json["IsRquired"],
      searchName: json["SearchName"],
      insertDefult: json["InsertDefult"],
      visableDefult: json["VisableDefult"],
      width: json["Width"],
      linkTarget: json["LinkTarget"],
      targetPrimayColumn: json["TargetPrimayColumn"],
      categoryTitle: json["CategoryTitle"],
      categorySort: json["CategorySort"],
      categoryId: json["CategoryID"],
      isExcel: json["IsExcel"],
      mobileVisable: json["MobileVisable"],
      isDepartment: json["IsDepartment"],
      departmentCoulmn: json["DepartmentCoulmn"],
      pageId: json["PageId"],
      comId: json["ComID"],
      masterInsertVisible: json["MasterInsertVisible"],
      linkPrimary: json["LinkPrimary"],
      insertIntoColumnName: json["InsertIntoColumnName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "ListName": listName,
        "ColumnName": columnName,
        "enColumnLabel": enColumnLabel,
        "arColumnLabel": arColumnLabel,
        "InsertVisable": insertVisable,
        "InsertType": insertType,
        "userID": userId,
        "ListID": listId,
        "sort": sort,
        "visible": visible,
        "DroModel": droModel,
        "DroValue": droValue,
        "DroText": droText,
        "DroCompany": droCompany,
        "Cvisable": cvisable,
        "validation": validation,
        "isKey": isKey,
        "IsRquired": isRquired,
        "SearchName": searchName,
        "InsertDefult": insertDefult,
        "VisableDefult": visableDefult,
        "Width": width,
        "LinkTarget": linkTarget,
        "TargetPrimayColumn": targetPrimayColumn,
        "CategoryTitle": categoryTitle,
        "CategorySort": categorySort,
        "CategoryID": categoryId,
        "IsExcel": isExcel,
        "MobileVisable": mobileVisable,
        "IsDepartment": isDepartment,
        "DepartmentCoulmn": departmentCoulmn,
        "PageId": pageId,
        "ComID": comId,
        "MasterInsertVisible": masterInsertVisible,
        "LinkPrimary": linkPrimary,
        "InsertIntoColumnName": insertIntoColumnName,
      };
}

/*
{
	"dynamicList": [
		[
			{
				"CustomerAccountName": "i engineering KSA ",
				"Type": "Qty",
				"منتج مبيعات ": 2
			},
			{
				"CustomerAccountName": "i engineering KSA ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "i engineering KSA ",
				"Type": "Total",
				"منتج مبيعات ": 19920
			},
			{
				"CustomerAccountName": "mm",
				"Type": "Qty",
				"بوستر 2 مضخة 1 ع 1.5 ح 220 ف 1 ف": 1
			},
			{
				"CustomerAccountName": "mm",
				"Type": "Qty",
				"بوستر 2 مضخة 1 ع 1.5 ح 220 ف 1 ف": 1
			},
			{
				"CustomerAccountName": "mm",
				"Type": "Total",
				"بوستر 2 مضخة 1 ع 1.5 ح 220 ف 1 ف": 100
			},
			{
				"CustomerAccountName": "الشئون الصحية بوزارة الحرس الوطني ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "الشئون الصحية بوزارة الحرس الوطني ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "الشئون الصحية بوزارة الحرس الوطني ",
				"Type": "Total",
				"منتج مبيعات ": 46120
			},
			{
				"CustomerAccountName": "الشركة السعودية للتحكم التقني والأمني الشامل المحدودة",
				"Type": "Qty",
				"سيخ مسنن حديد 10 م": 3,
				"منتج مبيعات ": 18
			},
			{
				"CustomerAccountName": "الشركة السعودية للتحكم التقني والأمني الشامل المحدودة",
				"Type": "Qty",
				"سيخ مسنن حديد 10 م": 3,
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "الشركة السعودية للتحكم التقني والأمني الشامل المحدودة",
				"Type": "Total",
				"سيخ مسنن حديد 10 م": 9,
				"منتج مبيعات ": 1270146.45
			},
			{
				"CustomerAccountName": "الشركة السعوديه للخطوط الحديدية ",
				"Type": "Qty",
				"منتج مبيعات ": 8
			},
			{
				"CustomerAccountName": "الشركة السعوديه للخطوط الحديدية ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "الشركة السعوديه للخطوط الحديدية ",
				"Type": "Total",
				"منتج مبيعات ": 2696283.4
			},
			{
				"CustomerAccountName": "الهيئة الملكية بالجبيل وينبع  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "الهيئة الملكية بالجبيل وينبع  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "الهيئة الملكية بالجبيل وينبع  ",
				"Type": "Total",
				"منتج مبيعات ": 283345.62
			},
			{
				"CustomerAccountName": "تجمع الشرقية الصحي ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "تجمع الشرقية الصحي ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "تجمع الشرقية الصحي ",
				"Type": "Total",
				"منتج مبيعات ": 61972
			},
			{
				"CustomerAccountName": "خياط رهف محمد بن شديد الخالدي للخياطة الرجالية  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "خياط رهف محمد بن شديد الخالدي للخياطة الرجالية  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "خياط رهف محمد بن شديد الخالدي للخياطة الرجالية  ",
				"Type": "Total",
				"منتج مبيعات ": 13914
			},
			{
				"CustomerAccountName": "شركة اتحاد اتصالات موبايلي",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة اتحاد اتصالات موبايلي",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة اتحاد اتصالات موبايلي",
				"Type": "Total",
				"منتج مبيعات ": 51577.68
			},
			{
				"CustomerAccountName": "شركة اكليل طويق العقارية",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة اكليل طويق العقارية",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة اكليل طويق العقارية",
				"Type": "Total",
				"منتج مبيعات ": 865287.76
			},
			{
				"CustomerAccountName": "شركة الاتصالات المتكاملة  ",
				"Type": "Qty",
				"منتج مبيعات ": 2
			},
			{
				"CustomerAccountName": "شركة الاتصالات المتكاملة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الاتصالات المتكاملة  ",
				"Type": "Total",
				"منتج مبيعات ": 1410480.26
			},
			{
				"CustomerAccountName": "شركة الاكليل العقارية  ",
				"Type": "Qty",
				"منتج مبيعات ": 3
			},
			{
				"CustomerAccountName": "شركة الاكليل العقارية  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الاكليل العقارية  ",
				"Type": "Total",
				"منتج مبيعات ": 774372.81
			},
			{
				"CustomerAccountName": "شركة الثمانين العقارية ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الثمانين العقارية ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الثمانين العقارية ",
				"Type": "Total",
				"منتج مبيعات ": 588923.36
			},
			{
				"CustomerAccountName": "شركة الجيل الحديث العربية لنظم العمليات المحدودة  ",
				"Type": "Qty",
				"منتج مبيعات ": 2
			},
			{
				"CustomerAccountName": "شركة الجيل الحديث العربية لنظم العمليات المحدودة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الجيل الحديث العربية لنظم العمليات المحدودة  ",
				"Type": "Total",
				"منتج مبيعات ": 39850
			},
			{
				"CustomerAccountName": "شركة الخريجي للتجارة والالكترونيات ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الخريجي للتجارة والالكترونيات ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الخريجي للتجارة والالكترونيات ",
				"Type": "Total",
				"منتج مبيعات ": 19036
			},
			{
				"CustomerAccountName": "شركة الراجحي للتنمية المحدودة",
				"Type": "Qty",
				"جلبة اصلاح 16 م": 3,
				"كوع زاوية": 3,
				"منتج مبيعات ": 11
			},
			{
				"CustomerAccountName": "شركة الراجحي للتنمية المحدودة",
				"Type": "Qty",
				"جلبة اصلاح 16 م": 3,
				"كوع زاوية": 3,
				"منتج مبيعات ": 2.75
			},
			{
				"CustomerAccountName": "شركة الراجحي للتنمية المحدودة",
				"Type": "Total",
				"جلبة اصلاح 16 م": 6,
				"كوع زاوية": 6,
				"منتج مبيعات ": 31
			},
			{
				"CustomerAccountName": "شركة الكوثر للمقاولات شركة شخص واحد",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الكوثر للمقاولات شركة شخص واحد",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الكوثر للمقاولات شركة شخص واحد",
				"Type": "Total",
				"منتج مبيعات ": 4347.83
			},
			{
				"CustomerAccountName": "شركة الكيان الفنية العربية للمقاولات ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الكيان الفنية العربية للمقاولات ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الكيان الفنية العربية للمقاولات ",
				"Type": "Total",
				"منتج مبيعات ": 32900
			},
			{
				"CustomerAccountName": "شركة المثلث المتحد للمقاولات  ",
				"Type": "Qty",
				"منتج مبيعات ": 2
			},
			{
				"CustomerAccountName": "شركة المثلث المتحد للمقاولات  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة المثلث المتحد للمقاولات  ",
				"Type": "Total",
				"منتج مبيعات ": 17000
			},
			{
				"CustomerAccountName": "شركة المسار الحديث المحدودة ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة المسار الحديث المحدودة ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة المسار الحديث المحدودة ",
				"Type": "Total",
				"منتج مبيعات ": 60779.07
			},
			{
				"CustomerAccountName": "شركة الملاذ العربية المحدودة   ",
				"Type": "Qty",
				"منتج مبيعات ": 10
			},
			{
				"CustomerAccountName": "شركة الملاذ العربية المحدودة   ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة الملاذ العربية المحدودة   ",
				"Type": "Total",
				"منتج مبيعات ": 370228.22
			},
			{
				"CustomerAccountName": "شركة انماط التقنية للتجارة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة انماط التقنية للتجارة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة انماط التقنية للتجارة  ",
				"Type": "Total",
				"منتج مبيعات ": 15000
			},
			{
				"CustomerAccountName": "شركة اي جي اند جي الشرق الاوسط ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة اي جي اند جي الشرق الاوسط ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة اي جي اند جي الشرق الاوسط ",
				"Type": "Total",
				"منتج مبيعات ": 118270.56
			},
			{
				"CustomerAccountName": "شركة تحكم العالميه للطاقه ",
				"Type": "Qty",
				"منتج مبيعات ": 2
			},
			{
				"CustomerAccountName": "شركة تحكم العالميه للطاقه ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة تحكم العالميه للطاقه ",
				"Type": "Total",
				"منتج مبيعات ": 123792.68
			},
			{
				"CustomerAccountName": "شركة خلود التجارية للمقاولات ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة خلود التجارية للمقاولات ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة خلود التجارية للمقاولات ",
				"Type": "Total",
				"منتج مبيعات ": 156965.51
			},
			{
				"CustomerAccountName": "شركة دار الهندسة للتصميم والإستشارات الفنية (شاعر ومشاركوه) ",
				"Type": "Qty",
				"منتج مبيعات ": 3
			},
			{
				"CustomerAccountName": "شركة دار الهندسة للتصميم والإستشارات الفنية (شاعر ومشاركوه) ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة دار الهندسة للتصميم والإستشارات الفنية (شاعر ومشاركوه) ",
				"Type": "Total",
				"منتج مبيعات ": 417472.93
			},
			{
				"CustomerAccountName": "شركة دور الانشاءات للمقاولات",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة دور الانشاءات للمقاولات",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة دور الانشاءات للمقاولات",
				"Type": "Total",
				"منتج مبيعات ": 195870.43
			},
			{
				"CustomerAccountName": "شركة شبكة البديل للمقاولات  ",
				"Type": "Qty",
				"منتج مبيعات ": 3
			},
			{
				"CustomerAccountName": "شركة شبكة البديل للمقاولات  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة شبكة البديل للمقاولات  ",
				"Type": "Total",
				"منتج مبيعات ": 119200
			},
			{
				"CustomerAccountName": "شركة طارق الجعفري للمقاولات  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة طارق الجعفري للمقاولات  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة طارق الجعفري للمقاولات  ",
				"Type": "Total",
				"منتج مبيعات ": 1254500.01
			},
			{
				"CustomerAccountName": "شركة طويق للصيانة والتشغيل المحدودة ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة طويق للصيانة والتشغيل المحدودة ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة طويق للصيانة والتشغيل المحدودة ",
				"Type": "Total",
				"منتج مبيعات ": 191400
			},
			{
				"CustomerAccountName": "شركة ليجراند العربية السعودية",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة ليجراند العربية السعودية",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة ليجراند العربية السعودية",
				"Type": "Total",
				"منتج مبيعات ": 10000
			},
			{
				"CustomerAccountName": "شركة مجموعة الزامل القابضة ــ مساهمة مقفلة ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة مجموعة الزامل القابضة ــ مساهمة مقفلة ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة مجموعة الزامل القابضة ــ مساهمة مقفلة ",
				"Type": "Total",
				"منتج مبيعات ": 30600
			},
			{
				"CustomerAccountName": "شركة محور الاقتصاد ",
				"Type": "Qty",
				"منتج مبيعات ": 3
			},
			{
				"CustomerAccountName": "شركة محور الاقتصاد ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة محور الاقتصاد ",
				"Type": "Total",
				"منتج مبيعات ": 168513.15
			},
			{
				"CustomerAccountName": "شركة نبراس حبوة للاستشارات المهنية  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة نبراس حبوة للاستشارات المهنية  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة نبراس حبوة للاستشارات المهنية  ",
				"Type": "Total",
				"منتج مبيعات ": 7608.7
			},
			{
				"CustomerAccountName": "شركة نوكيا سوليوشنز اند نتويركس السعودية المحدودة ",
				"Type": "Qty",
				"منتج مبيعات ": 2
			},
			{
				"CustomerAccountName": "شركة نوكيا سوليوشنز اند نتويركس السعودية المحدودة ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة نوكيا سوليوشنز اند نتويركس السعودية المحدودة ",
				"Type": "Total",
				"منتج مبيعات ": 10000
			},
			{
				"CustomerAccountName": "شركة نيوم",
				"Type": "Qty",
				"منتج مبيعات ": 3
			},
			{
				"CustomerAccountName": "شركة نيوم",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة نيوم",
				"Type": "Total",
				"منتج مبيعات ": 9190107.09
			},
			{
				"CustomerAccountName": "شركة هدير الآلات للمقاولات",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة هدير الآلات للمقاولات",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "شركة هدير الآلات للمقاولات",
				"Type": "Total",
				"منتج مبيعات ": 146954.83
			},
			{
				"CustomerAccountName": "مؤسسة إجراءات الغد للتجارة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة إجراءات الغد للتجارة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة إجراءات الغد للتجارة  ",
				"Type": "Total",
				"منتج مبيعات ": 8695.65
			},
			{
				"CustomerAccountName": "مؤسسة ابراج راحة للمقاولات العامة",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة ابراج راحة للمقاولات العامة",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة ابراج راحة للمقاولات العامة",
				"Type": "Total",
				"منتج مبيعات ": 8500
			},
			{
				"CustomerAccountName": "مؤسسة الابحار الخامس للفحص والمعاينة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة الابحار الخامس للفحص والمعاينة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة الابحار الخامس للفحص والمعاينة  ",
				"Type": "Total",
				"منتج مبيعات ": 5500
			},
			{
				"CustomerAccountName": "مؤسسة الانظمة التكامليه للتجاره ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة الانظمة التكامليه للتجاره ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة الانظمة التكامليه للتجاره ",
				"Type": "Total",
				"منتج مبيعات ": 36650
			},
			{
				"CustomerAccountName": "مؤسسة بداية قصة التجارية  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة بداية قصة التجارية  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة بداية قصة التجارية  ",
				"Type": "Total",
				"منتج مبيعات ": 6956.52
			},
			{
				"CustomerAccountName": "مؤسسة حصن المعالي للمقاولات العامة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة حصن المعالي للمقاولات العامة  ",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة حصن المعالي للمقاولات العامة  ",
				"Type": "Total",
				"منتج مبيعات ": 4968.05
			},
			{
				"CustomerAccountName": "مؤسسة محمد سليمان محمد فقيهي التجارية",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة محمد سليمان محمد فقيهي التجارية",
				"Type": "Qty",
				"منتج مبيعات ": 1
			},
			{
				"CustomerAccountName": "مؤسسة محمد سليمان محمد فقيهي التجارية",
				"Type": "Total",
				"منتج مبيعات ": 6956.52
			}
		],
		[
			{
				"Coulumn": "بوستر 2 مضخة 1 ع 1.5 ح 220 ف 1 ف"
			},
			{
				"Coulumn": "جلبة اصلاح 16 م"
			},
			{
				"Coulumn": "سيخ مسنن حديد 10 م"
			},
			{
				"Coulumn": "كوع زاوية"
			},
			{
				"Coulumn": "منتج مبيعات "
			}
		]
	],
	"numberofrecords": 132,
	"listes": [
		{
			"id": 127698,
			"ListName": "SalesDetailReport",
			"ColumnName": "CustomerAccountName",
			"enColumnLabel": "Customer name",
			"arColumnLabel": "اسم العميل",
			"InsertVisable": false,
			"InsertType": "dropdown",
			"userID": 4121,
			"ListID": 8620,
			"sort": 4,
			"visible": true,
			"DroModel": "CustomerAccountView",
			"DroValue": "CustomerAccountID",
			"DroText": "CustomerAccountName",
			"DroCompany": "ComID",
			"Cvisable": true,
			"validation": "required",
			"isKey": false,
			"IsRquired": false,
			"SearchName": "CustomerID",
			"InsertDefult": true,
			"VisableDefult": true,
			"Width": 140,
			"LinkTarget": "234",
			"TargetPrimayColumn": "CustomerID",
			"CategoryTitle": "بيانات اساسية",
			"CategorySort": 1,
			"CategoryID": 10,
			"IsExcel": false,
			"MobileVisable": true,
			"IsDepartment": true,
			"DepartmentCoulmn": "DepartmentId",
			"PageId": 6600,
			"ComID": 1,
			"MasterInsertVisible": false,
			"LinkPrimary": "CustomerAccountID",
			"InsertIntoColumnName": "CustomerID"
		}
	],
	"data": {
		"Id": 5130,
		"PivotRepeat": "ProName",
		"PivotValue": "Total",
		"PageAttributeId": 5205,
		"ReportName": "مبيعات منتج لكل عميل شهري",
		"TailCondition": "1=1",
		"listes": "CustomerAccountName",
		"ShowVSum": true,
		"SowHSum": true,
		"Aggrigate": "SUM",
		"PivotAggriagteTypes": [
			{
				"ID": 1,
				"PivotId": 5130,
				"ColumnName": "Qty",
				"TypeAggriagte": "SUM"
			},
			{
				"ID": 2,
				"PivotId": 5130,
				"ColumnName": "Qty",
				"TypeAggriagte": "AVG"
			}
		],
		"PivotAuth": [],
		"PivotListes": [
			{
				"Id": 5148,
				"PivotId": 5130,
				"ListId": 8620
			}
		]
	},
	"atrribut": {
		"AttributeId": 5205,
		"PageId": 6550,
		"ListName": "SalesDetailReport",
		"TableName": "salessystemcontract",
		"Primary": "ContractID",
		"ControllerName": "PivotStructure",
		"TableSrc": "PivotTable",
		"EditSrc": "addOrEditExcel",
		"ShowEdit": true,
		"ShowDelete": true,
		"ShowRowPrint": false,
		"ShowNew": true,
		"SearchFirst": false,
		"ShowSum": false,
		"DataSourceApi": "PivotStructure",
		"Master": false,
		"ShowInPopUp": false,
		"IsAlarm": false,
		"IsDepartment": true,
		"DepartmentCoulmn": "DepartmentId",
		"PageDetail": [],
		"PivotReport": []
	},
	"TypesAggrigates": [
		"Total",
		"Qty",
		"Qty"
	],
	"repeatelists": [
		{
			"id": 8623,
			"ListName": "SalesDetailReport",
			"SearchName": "ProductID",
			"ColumnName": "ProName",
			"InsertType": "dropdown",
			"DroModel": "ProductView",
			"DroValue": "ProID",
			"DroText": "ProName",
			"DroCompany": "ComID",
			"arColumnLabel": "اسم المنتج",
			"visible": true,
			"InsertVisable": true,
			"IsRquired": false,
			"enColumnLabel": "Product name",
			"sort": 0,
			"Width": 180,
			"validation": "required",
			"isKey": false,
			"VisableDefult": true,
			"InsertDefult": true,
			"LinkTarget": "295",
			"TargetPrimayColumn": "ProductID",
			"CategoryID": 10,
			"MobileVisable": true,
			"IsDepartment": true,
			"DepartmentCoulmn": "DepartementID",
			"PageId": 295,
			"LinkPrimary": "ProID"
		}
	],
	"ArabicLableAggrigate": [
		{
			"id": 8625,
			"ListName": "SalesDetailReport",
			"SearchName": "Qty",
			"ColumnName": "Qty",
			"InsertType": "number",
			"arColumnLabel": "الكمية",
			"IsTotal": true,
			"visible": true,
			"InsertVisable": true,
			"IsRquired": false,
			"enColumnLabel": "Quantity ",
			"sort": 0,
			"Width": 140,
			"validation": "required",
			"isKey": false,
			"VisableDefult": true,
			"InsertDefult": true,
			"LinkTarget": "294",
			"TargetPrimayColumn": "ProductID",
			"CategoryID": 10,
			"MobileVisable": true,
			"UserVisible": true,
			"LinkPrimary": "ProID"
		},
		{
			"id": 8626,
			"ListName": "SalesDetailReport",
			"SearchName": "Total",
			"ColumnName": "Total",
			"InsertType": "number",
			"arColumnLabel": "اجمالي السعر",
			"IsTotal": true,
			"visible": true,
			"InsertVisable": false,
			"IsRquired": false,
			"enColumnLabel": "Total Price",
			"sort": 0,
			"Width": 140,
			"validation": "required",
			"isKey": false,
			"VisableDefult": true,
			"InsertDefult": true,
			"LinkTarget": "339",
			"TargetPrimayColumn": "CustomerID",
			"CategoryID": 10,
			"MobileVisable": true,
			"UserVisible": false,
			"LinkPrimary": "CustomerAccountID"
		}
	]
}*/
