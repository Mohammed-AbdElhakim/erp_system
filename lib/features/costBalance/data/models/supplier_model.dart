class SupplierModel {
  List<SupplierItem>? supplierItemList;
  int? numberofrecords;

  SupplierModel({this.supplierItemList, this.numberofrecords});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      supplierItemList = <SupplierItem>[];
      json['dynamicList'].forEach((v) {
        supplierItemList!.add(SupplierItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (supplierItemList != null) {
      data['dynamicList'] = supplierItemList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class SupplierItem {
  int? sID;
  String? sName;

  SupplierItem({
    this.sID,
    this.sName,
  });

  SupplierItem.fromJson(Map<String, dynamic> json) {
    sID = json['SID'];
    sName = json['SName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SID'] = sID;
    data['SName'] = sName;
    return data;
  }

  @override
  String toString() {
    return "$sName";
  }
}
