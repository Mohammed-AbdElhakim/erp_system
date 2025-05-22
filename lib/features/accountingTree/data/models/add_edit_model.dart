import 'account_view_model.dart';

class AddEditModel {
  AccountTreeModel? obj;
  LastObj? lastObj;

  AddEditModel({this.obj, this.lastObj});

  AddEditModel.fromJson(Map<String, dynamic> json) {
    obj = json['obj'] != null ? AccountTreeModel.fromJson(json['obj']) : null;
    lastObj = json['lastObj'] != null ? LastObj.fromJson(json['lastObj']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (obj != null) {
      data['obj'] = obj!.toJson();
    }
    if (lastObj != null) {
      data['lastObj'] = lastObj!.toJson();
    }
    return data;
  }
}

class LastObj {
  int? acID;
  String? acName;
  bool? creditORDepit;
  int? acParent;
  int? comID;
  String? parent;
  String? sheetName;
  int? sheet;
  double? acCode;
  double? acIndex;
  String? indexchar;
  String? fullName;
  int? lastcount;

  LastObj(
      {this.acID,
      this.acName,
      this.creditORDepit,
      this.acParent,
      this.comID,
      this.parent,
      this.sheetName,
      this.sheet,
      this.acCode,
      this.acIndex,
      this.indexchar,
      this.fullName,
      this.lastcount});

  LastObj.fromJson(Map<String, dynamic> json) {
    acID = json['AcID'];
    acName = json['AcName'];
    creditORDepit = json['CreditORDepit'];
    acParent = json['AcParent'];
    comID = json['ComID'];
    parent = json['Parent'];
    sheetName = json['SheetName'];
    sheet = json['Sheet'];
    acCode = json['AcCode'];
    acIndex = json['AcIndex'];
    indexchar = json['indexchar'];
    fullName = json['FullName'];
    lastcount = json['lastcount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcID'] = acID;
    data['AcName'] = acName;
    data['CreditORDepit'] = creditORDepit;
    data['AcParent'] = acParent;
    data['ComID'] = comID;
    data['Parent'] = parent;
    data['SheetName'] = sheetName;
    data['Sheet'] = sheet;
    data['AcCode'] = acCode;
    data['AcIndex'] = acIndex;
    data['indexchar'] = indexchar;
    data['FullName'] = fullName;
    data['lastcount'] = lastcount;
    return data;
  }
}
