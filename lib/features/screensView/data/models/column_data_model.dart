// ignore_for_file: non_constant_identifier_names

class ScreenModel {
  ScreenModel({
    required this.columList,
    required this.dataList,
  });
  late final List<ColumList> columList;
  late final DataList dataList;

  ScreenModel.fromJson(Map<String, dynamic> json) {
    columList =
        List.from(json['columList']).map((e) => ColumList.fromJson(e)).toList();
    dataList = DataList.fromJson(json['dataList']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['columList'] = columList.map((e) => e.toJson()).toList();
    data['dataList'] = dataList.toJson();
    return data;
  }
}

class ColumList {
  ColumList({
    required this.id,
    required this.ListName,
    required this.ColumnName,
    required this.enColumnLabel,
    required this.arColumnLabel,
    required this.InsertVisable,
    required this.InsertType,
    required this.userID,
    required this.ListID,
    required this.sort,
    required this.visible,
    required this.Cvisable,
    required this.validation,
    required this.isKey,
    required this.IsRquired,
    required this.SearchName,
    required this.IsTotal,
    required this.InsertDefult,
    required this.VisableDefult,
    required this.Width,
    required this.MobileVisable,
    required this.ComID,
    required this.MasterInsertVisible,
  });
  late final int id;
  late final String ListName;
  late final String ColumnName;
  late final String enColumnLabel;
  late final String arColumnLabel;
  late final bool InsertVisable;
  late final String InsertType;
  late final int userID;
  late final int ListID;
  late final int sort;
  late final bool visible;
  late final bool Cvisable;
  late final String validation;
  late final bool isKey;
  late final bool IsRquired;
  late final String SearchName;
  late final bool IsTotal;
  late final bool InsertDefult;
  late final bool VisableDefult;
  late final int Width;
  late final bool MobileVisable;
  late final int ComID;
  late final bool MasterInsertVisible;

  ColumList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ListName = json['ListName'];
    ColumnName = json['ColumnName'];
    enColumnLabel = json['enColumnLabel'];
    arColumnLabel = json['arColumnLabel'];
    InsertVisable = json['InsertVisable'];
    InsertType = json['InsertType'];
    userID = json['userID'];
    ListID = json['ListID'];
    sort = json['sort'];
    visible = json['visible'];
    Cvisable = json['Cvisable'];
    validation = json['validation'];
    isKey = json['isKey'];
    IsRquired = json['IsRquired'];
    SearchName = json['SearchName'];
    IsTotal = json['IsTotal'];
    InsertDefult = json['InsertDefult'];
    VisableDefult = json['VisableDefult'];
    Width = json['Width'];
    MobileVisable = json['MobileVisable'];
    ComID = json['ComID'];
    MasterInsertVisible = json['MasterInsertVisible'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['ListName'] = ListName;
    data['ColumnName'] = ColumnName;
    data['enColumnLabel'] = enColumnLabel;
    data['arColumnLabel'] = arColumnLabel;
    data['InsertVisable'] = InsertVisable;
    data['InsertType'] = InsertType;
    data['userID'] = userID;
    data['ListID'] = ListID;
    data['sort'] = sort;
    data['visible'] = visible;
    data['Cvisable'] = Cvisable;
    data['validation'] = validation;
    data['isKey'] = isKey;
    data['IsRquired'] = IsRquired;
    data['SearchName'] = SearchName;
    data['IsTotal'] = IsTotal;
    data['InsertDefult'] = InsertDefult;
    data['VisableDefult'] = VisableDefult;
    data['Width'] = Width;
    data['MobileVisable'] = MobileVisable;
    data['ComID'] = ComID;
    data['MasterInsertVisible'] = MasterInsertVisible;
    return data;
  }
}

class DataList {
  DataList({
    required this.dynamicList,
    required this.numberofrecords,
  });
  late final List<Map<String, dynamic>> dynamicList;
  late final int numberofrecords;

  DataList.fromJson(Map<String, dynamic> json) {
    dynamicList = json['dynamicList'];
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['dynamicList'] = dynamicList;
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

// class DynamicList {
//   DynamicList({
//     required this.Id,
//     required this.ArName,
//     required this.EnName,
//     required this.Color,
//   });
//   late final int Id;
//   late final String ArName;
//   late final String EnName;
//   late final String Color;
//
//   DynamicList.fromJson(Map<String, dynamic> json) {
//     Id = json['Id'];
//     ArName = json['ArName'];
//     EnName = json['EnName'];
//     Color = json['Color'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['Id'] = Id;
//     _data['ArName'] = ArName;
//     _data['EnName'] = EnName;
//     _data['Color'] = Color;
//     return _data;
//   }
// }
