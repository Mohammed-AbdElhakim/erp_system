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
    final _data = <String, dynamic>{};
    _data['columList'] = columList.map((e) => e.toJson()).toList();
    _data['dataList'] = dataList.toJson();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['ListName'] = ListName;
    _data['ColumnName'] = ColumnName;
    _data['enColumnLabel'] = enColumnLabel;
    _data['arColumnLabel'] = arColumnLabel;
    _data['InsertVisable'] = InsertVisable;
    _data['InsertType'] = InsertType;
    _data['userID'] = userID;
    _data['ListID'] = ListID;
    _data['sort'] = sort;
    _data['visible'] = visible;
    _data['Cvisable'] = Cvisable;
    _data['validation'] = validation;
    _data['isKey'] = isKey;
    _data['IsRquired'] = IsRquired;
    _data['SearchName'] = SearchName;
    _data['IsTotal'] = IsTotal;
    _data['InsertDefult'] = InsertDefult;
    _data['VisableDefult'] = VisableDefult;
    _data['Width'] = Width;
    _data['MobileVisable'] = MobileVisable;
    _data['ComID'] = ComID;
    _data['MasterInsertVisible'] = MasterInsertVisible;
    return _data;
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
    final _data = <String, dynamic>{};
    _data['dynamicList'] = dynamicList;
    _data['numberofrecords'] = numberofrecords;
    return _data;
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
