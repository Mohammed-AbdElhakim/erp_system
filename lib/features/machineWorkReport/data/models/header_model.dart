class HeaderModel {
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
  String? droCompany;
  bool? cvisable;
  String? validation;
  bool? isKey;
  bool? isRquired;
  String? searchName;
  bool? insertDefult;
  bool? visableDefult;
  int? width;
  String? categoryTitle;
  int? categorySort;
  int? categoryID;
  bool? isExcel;
  bool? mobileVisable;
  bool? isDepartment;
  String? departmentCoulmn;
  int? pageId;
  int? comID;
  bool? masterInsertVisible;
  String? categoryName;
  bool? userVisible;

  HeaderModel(
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
      this.droCompany,
      this.cvisable,
      this.validation,
      this.isKey,
      this.isRquired,
      this.searchName,
      this.insertDefult,
      this.visableDefult,
      this.width,
      this.categoryTitle,
      this.categorySort,
      this.categoryID,
      this.isExcel,
      this.mobileVisable,
      this.isDepartment,
      this.departmentCoulmn,
      this.pageId,
      this.comID,
      this.masterInsertVisible,
      this.categoryName,
      this.userVisible});

  HeaderModel.fromJson(Map<String, dynamic> json) {
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
    droCompany = json['DroCompany'];
    cvisable = json['Cvisable'];
    validation = json['validation'];
    isKey = json['isKey'];
    isRquired = json['IsRquired'];
    searchName = json['SearchName'];
    insertDefult = json['InsertDefult'];
    visableDefult = json['VisableDefult'];
    width = json['Width'];
    categoryTitle = json['CategoryTitle'];
    categorySort = json['CategorySort'];
    categoryID = json['CategoryID'];
    isExcel = json['IsExcel'];
    mobileVisable = json['MobileVisable'];
    isDepartment = json['IsDepartment'];
    departmentCoulmn = json['DepartmentCoulmn'];
    pageId = json['PageId'];
    comID = json['ComID'];
    masterInsertVisible = json['MasterInsertVisible'];
    categoryName = json['CategoryName'];
    userVisible = json['UserVisible'];
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
    data['DroCompany'] = droCompany;
    data['Cvisable'] = cvisable;
    data['validation'] = validation;
    data['isKey'] = isKey;
    data['IsRquired'] = isRquired;
    data['SearchName'] = searchName;
    data['InsertDefult'] = insertDefult;
    data['VisableDefult'] = visableDefult;
    data['Width'] = width;
    data['CategoryTitle'] = categoryTitle;
    data['CategorySort'] = categorySort;
    data['CategoryID'] = categoryID;
    data['IsExcel'] = isExcel;
    data['MobileVisable'] = mobileVisable;
    data['IsDepartment'] = isDepartment;
    data['DepartmentCoulmn'] = departmentCoulmn;
    data['PageId'] = pageId;
    data['ComID'] = comID;
    data['MasterInsertVisible'] = masterInsertVisible;
    data['CategoryName'] = categoryName;
    data['UserVisible'] = userVisible;
    return data;
  }
}
