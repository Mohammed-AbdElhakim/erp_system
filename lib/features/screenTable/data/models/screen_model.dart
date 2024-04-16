class ScreenModel {
  List<ColumnList>? columnList;
  List<Map<String, dynamic>>? dataList;
  int? numberOfRecords;

  ScreenModel({this.columnList, this.dataList, this.numberOfRecords});

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

// // ignore_for_file: non_constant_identifier_names
//
// class ScreenModel {
//   ScreenModel({
//     required this.columList,
//     required this.dataList,
//     required this.numberOfRecords,
//   });
//   late final List<ColumListItem> columList;
//   late final List<Map<String, dynamic>> dataList;
//   late final int numberOfRecords;
//
//   ScreenModel.fromJson(Map<String, dynamic> json) {
//     columList = List.from(json['columnList'])
//         .map((e) => ColumListItem.fromJson(e))
//         .toList();
//     dataList = json['dataList'];
//     numberOfRecords = json['numberOfRecords'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['columnList'] = columList.map((e) => e.toJson()).toList();
//     data['dataList'] = dataList;
//     data['numberOfRecords'] = numberOfRecords;
//     return data;
//   }
// }
//
// class ColumListItem {
//   ColumListItem({
//     required this.id,
//     required this.ListName,
//     required this.SearchName,
//     required this.ColumnName,
//     required this.InsertType,
//     required this.arColumnLabel,
//     required this.IsTotal,
//     required this.visible,
//     required this.InsertVisable,
//     required this.IsRquired,
//     required this.enColumnLabel,
//     required this.sort,
//     required this.Width,
//     required this.validation,
//     required this.isKey,
//     required this.VisableDefult,
//     required this.InsertDefult,
//     required this.IsGeneral,
//     required this.CategoryID,
//     required this.MobileVisable,
//     required this.IsMobileHeader,
//     required this.IsDepartment,
//     required this.IsMulti,
//     required this.Disable,
//     required this.UserVisible,
//     required this.IsUnique,
//   });
//   late final int id;
//   late final String ListName;
//   late final String SearchName;
//   late final String ColumnName;
//   late final String InsertType;
//   late final String arColumnLabel;
//   late final bool IsTotal;
//   late final bool visible;
//   late final bool InsertVisable;
//   late final bool IsRquired;
//   late final String enColumnLabel;
//   late final int sort;
//   late final int Width;
//   late final String validation;
//   late final bool isKey;
//   late final bool VisableDefult;
//   late final bool InsertDefult;
//   late final bool IsGeneral;
//   late final int CategoryID;
//   late final bool MobileVisable;
//   late final bool IsMobileHeader;
//   late final bool IsDepartment;
//   late final bool IsMulti;
//   late final bool Disable;
//   late final bool UserVisible;
//   late final bool IsUnique;
//
//   ColumListItem.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     ListName = json['ListName'];
//     SearchName = json['SearchName'];
//     ColumnName = json['ColumnName'];
//     InsertType = json['InsertType'];
//     arColumnLabel = json['arColumnLabel'];
//     IsTotal = json['IsTotal'];
//     visible = json['visible'];
//     InsertVisable = json['InsertVisable'];
//     IsRquired = json['IsRquired'];
//     enColumnLabel = json['enColumnLabel'];
//     sort = json['sort'];
//     Width = json['Width'];
//     validation = json['validation'];
//     isKey = json['isKey'];
//     VisableDefult = json['VisableDefult'];
//     InsertDefult = json['InsertDefult'];
//     IsGeneral = json['IsGeneral'];
//     CategoryID = json['CategoryID'];
//     MobileVisable = json['MobileVisable'];
//     IsMobileHeader = json['IsMobileHeader'];
//     IsDepartment = json['IsDepartment'];
//     IsMulti = json['IsMulti'];
//     Disable = json['Disable'];
//     UserVisible = json['UserVisible'];
//     IsUnique = json['IsUnique'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['ListName'] = ListName;
//     _data['SearchName'] = SearchName;
//     _data['ColumnName'] = ColumnName;
//     _data['InsertType'] = InsertType;
//     _data['arColumnLabel'] = arColumnLabel;
//     _data['IsTotal'] = IsTotal;
//     _data['visible'] = visible;
//     _data['InsertVisable'] = InsertVisable;
//     _data['IsRquired'] = IsRquired;
//     _data['enColumnLabel'] = enColumnLabel;
//     _data['sort'] = sort;
//     _data['Width'] = Width;
//     _data['validation'] = validation;
//     _data['isKey'] = isKey;
//     _data['VisableDefult'] = VisableDefult;
//     _data['InsertDefult'] = InsertDefult;
//     _data['IsGeneral'] = IsGeneral;
//     _data['CategoryID'] = CategoryID;
//     _data['MobileVisable'] = MobileVisable;
//     _data['IsMobileHeader'] = IsMobileHeader;
//     _data['IsDepartment'] = IsDepartment;
//     _data['IsMulti'] = IsMulti;
//     _data['Disable'] = Disable;
//     _data['UserVisible'] = UserVisible;
//     _data['IsUnique'] = IsUnique;
//     return _data;
//   }
// }
//
// // class DataList {
// //   DataList({
// //     required this.dynamicList,
// //   });
// //   late final List<Map<String, dynamic>> dynamicList;
// //
// //   DataList.fromJson(Map<String, dynamic> json) {
// //     dynamicList = json['dynamicList'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final data = <String, dynamic>{};
// //     data['dynamicList'] = dynamicList;
// //     return data;
// //   }
// // }
//
// // class DynamicList {
// //   DynamicList({
// //     required this.Id,
// //     required this.ArName,
// //     required this.EnName,
// //     required this.Color,
// //   });
// //   late final int Id;
// //   late final String ArName;
// //   late final String EnName;
// //   late final String Color;
// //
// //   DynamicList.fromJson(Map<String, dynamic> json) {
// //     Id = json['Id'];
// //     ArName = json['ArName'];
// //     EnName = json['EnName'];
// //     Color = json['Color'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final _data = <String, dynamic>{};
// //     _data['Id'] = Id;
// //     _data['ArName'] = ArName;
// //     _data['EnName'] = EnName;
// //     _data['Color'] = Color;
// //     return _data;
// //   }
// // }
