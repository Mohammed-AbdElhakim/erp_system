class ScreenModel {
  List<ColumnList>? columnList;
  List<Map<String, dynamic>>? dataList;
  List<Map<String, dynamic>>? summedColumns;
  int? numberOfRecords;

  ScreenModel(
      {this.columnList,
      this.dataList,
      this.summedColumns,
      this.numberOfRecords});

  ScreenModel.fromJson(Map<String, dynamic> json) {
    if (json['columnList'] != null) {
      columnList = <ColumnList>[];
      json['columnList'].forEach((v) {
        columnList!.add(ColumnList.fromJson(v));
      });
    }
    if (json['dataList'] != null) {
      dataList = <Map<String, dynamic>>[];
      json['dataList'].forEach((v) {
        dataList!.add(v);
      });
    }
    if (json['SummedColumns'] != null) {
      summedColumns = <Map<String, dynamic>>[];
      json['SummedColumns'].forEach((v) {
        summedColumns!.add(v);
      });
    }
    numberOfRecords = json['numberOfRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (columnList != null) {
      data['columnList'] = columnList!.map((v) => v.toJson()).toList();
    }
    if (dataList != null) {
      data['dataList'] = dataList!.map((v) => v).toList();
    }
    if (summedColumns != null) {
      data['SummedColumns'] = summedColumns!.map((v) => v).toList();
    }
    data['numberOfRecords'] = numberOfRecords;
    return data;
  }
}

class ColumnList {
  int? id;
  String? listName;
  String? searchName;
  String? columnName;
  String? insertType;
  String? droModel;
  String? droValue;
  String? droText;
  String? droCompany;
  String? arColumnLabel;
  bool? isTotal;
  bool? visible;
  bool? insertVisable;
  bool? isRquired;
  String? enColumnLabel;
  int? sort;
  int? width;
  String? validation;
  bool? isKey;
  bool? visableDefult;
  bool? insertDefult;
  bool? isGeneral;
  int? categoryID;
  String? categoryName;
  bool? mobileVisable;
  bool? isMobileHeader;
  bool? isDepartment;
  bool? isMulti;
  bool? disable;
  bool? userVisible;
  bool? isUnique;
  int? pageId;
  String? droCondition;

  ColumnList(
      {this.id,
      this.listName,
      this.searchName,
      this.columnName,
      this.insertType,
      this.droModel,
      this.droValue,
      this.droText,
      this.droCompany,
      this.arColumnLabel,
      this.isTotal,
      this.visible,
      this.insertVisable,
      this.isRquired,
      this.enColumnLabel,
      this.sort,
      this.width,
      this.validation,
      this.isKey,
      this.visableDefult,
      this.insertDefult,
      this.isGeneral,
      this.categoryID,
      this.categoryName,
      this.mobileVisable,
      this.isMobileHeader,
      this.isDepartment,
      this.isMulti,
      this.disable,
      this.userVisible,
      this.isUnique,
      this.pageId,
      this.droCondition});

  ColumnList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listName = json['ListName'];
    searchName = json['SearchName'];
    columnName = json['ColumnName'];
    insertType = json['InsertType'];
    droModel = json['DroModel'];
    droValue = json['DroValue'];
    droText = json['DroText'];
    droCompany = json['DroCompany'];
    arColumnLabel = json['arColumnLabel'];
    isTotal = json['IsTotal'];
    visible = json['visible'];
    insertVisable = json['InsertVisable'];
    isRquired = json['IsRquired'];
    enColumnLabel = json['enColumnLabel'];
    sort = json['sort'];
    width = json['Width'];
    validation = json['validation'];
    isKey = json['isKey'];
    visableDefult = json['VisableDefult'];
    insertDefult = json['InsertDefult'];
    isGeneral = json['IsGeneral'];
    categoryID = json['CategoryID'];
    categoryName = json['CategoryName'];
    mobileVisable = json['MobileVisable'];
    isMobileHeader = json['IsMobileHeader'];
    isDepartment = json['IsDepartment'];
    isMulti = json['IsMulti'];
    disable = json['Disable'];
    userVisible = json['UserVisible'];
    isUnique = json['IsUnique'];
    pageId = json['PageId'];
    droCondition = json['DroCondition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ListName'] = listName;
    data['SearchName'] = searchName;
    data['ColumnName'] = columnName;
    data['InsertType'] = insertType;
    data['DroModel'] = droModel;
    data['DroValue'] = droValue;
    data['DroText'] = droText;
    data['DroCompany'] = droCompany;
    data['arColumnLabel'] = arColumnLabel;
    data['IsTotal'] = isTotal;
    data['visible'] = visible;
    data['InsertVisable'] = insertVisable;
    data['IsRquired'] = isRquired;
    data['enColumnLabel'] = enColumnLabel;
    data['sort'] = sort;
    data['Width'] = width;
    data['validation'] = validation;
    data['isKey'] = isKey;
    data['VisableDefult'] = visableDefult;
    data['InsertDefult'] = insertDefult;
    data['IsGeneral'] = isGeneral;
    data['CategoryID'] = categoryID;
    data['CategoryName'] = categoryName;
    data['MobileVisable'] = mobileVisable;
    data['IsMobileHeader'] = isMobileHeader;
    data['IsDepartment'] = isDepartment;
    data['IsMulti'] = isMulti;
    data['Disable'] = disable;
    data['UserVisible'] = userVisible;
    data['IsUnique'] = isUnique;
    data['PageId'] = pageId;
    data['DroCondition'] = droCondition;
    return data;
  }
}
