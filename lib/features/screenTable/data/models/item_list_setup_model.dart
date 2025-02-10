class ItemListSetupModel {
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
  String? droModel;
  String? droValue;
  String? droText;
  bool? cvisable;
  String? validation;
  bool? isKey;
  bool? isRquired;
  String? searchName;
  bool? insertDefult;
  bool? visableDefult;
  int? width;
  bool? isGeneral;
  String? categoryTitle;
  int? categorySort;
  int? categoryID;
  bool? isExcel;
  int? pageId;
  String? orderby;
  String? targetPrimayColumn;
  int? comID;
  bool? masterInsertVisible;
  bool? isTotal;

  ItemListSetupModel(
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
      this.droModel,
      this.droValue,
      this.droText,
      this.cvisable,
      this.validation,
      this.isKey,
      this.isRquired,
      this.searchName,
      this.insertDefult,
      this.visableDefult,
      this.width,
      this.isGeneral,
      this.categoryTitle,
      this.categorySort,
      this.categoryID,
      this.isExcel,
      this.pageId,
      this.orderby,
      this.targetPrimayColumn,
      this.comID,
      this.masterInsertVisible,
      this.isTotal});

  ItemListSetupModel.fromJson(Map<String, dynamic> json) {
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
    droModel = json['DroModel'];
    droValue = json['DroValue'];
    droText = json['DroText'];
    cvisable = json['Cvisable'];
    validation = json['validation'];
    isKey = json['isKey'];
    isRquired = json['IsRquired'];
    searchName = json['SearchName'];
    insertDefult = json['InsertDefult'];
    visableDefult = json['VisableDefult'];
    width = json['Width'];
    isGeneral = json['IsGeneral'];
    categoryTitle = json['CategoryTitle'];
    categorySort = json['CategorySort'];
    categoryID = json['CategoryID'];
    isExcel = json['IsExcel'];
    pageId = json['PageId'];
    orderby = json['orderby'];
    targetPrimayColumn = json['TargetPrimayColumn'];
    comID = json['ComID'];
    masterInsertVisible = json['MasterInsertVisible'];
    isTotal = json['IsTotal'];
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
    data['DroModel'] = droModel;
    data['DroValue'] = droValue;
    data['DroText'] = droText;
    data['Cvisable'] = cvisable;
    data['validation'] = validation;
    data['isKey'] = isKey;
    data['IsRquired'] = isRquired;
    data['SearchName'] = searchName;
    data['InsertDefult'] = insertDefult;
    data['VisableDefult'] = visableDefult;
    data['Width'] = width;
    data['IsGeneral'] = isGeneral;
    data['CategoryTitle'] = categoryTitle;
    data['CategorySort'] = categorySort;
    data['CategoryID'] = categoryID;
    data['IsExcel'] = isExcel;
    data['PageId'] = pageId;
    data['orderby'] = orderby;
    data['TargetPrimayColumn'] = targetPrimayColumn;
    data['ComID'] = comID;
    data['MasterInsertVisible'] = masterInsertVisible;
    data['IsTotal'] = isTotal;
    return data;
  }
}
