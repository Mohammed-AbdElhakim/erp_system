class CostItemsModel {
  List<CostItem>? costItemList;
  int? numberofrecords;

  CostItemsModel({this.costItemList, this.numberofrecords});

  CostItemsModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      costItemList = <CostItem>[];
      json['dynamicList'].forEach((v) {
        costItemList!.add(CostItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (costItemList != null) {
      data['dynamicList'] = costItemList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class CostItem {
  int? cIID;
  String? cIName;

  CostItem({
    this.cIID,
    this.cIName,
  });

  CostItem.fromJson(Map<String, dynamic> json) {
    cIID = json['CIID'];
    cIName = json['CIName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CIID'] = cIID;
    data['CIName'] = cIName;

    return data;
  }

  @override
  String toString() {
    return "$cIName";
  }
}
