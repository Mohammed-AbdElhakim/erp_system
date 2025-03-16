class TaxDeclarationModel3 {
  List<DynamicList>? dynamicList;

  TaxDeclarationModel3({this.dynamicList});

  TaxDeclarationModel3.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <DynamicList>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(DynamicList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dynamicList != null) {
      data['dynamicList'] = dynamicList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DynamicList {
  double? total;
  double? diff;
  String? eDate;

  DynamicList({this.total, this.diff, this.eDate});

  DynamicList.fromJson(Map<String, dynamic> json) {
    total = json['Total'];
    diff = json['Diff'];
    eDate = json['EDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Total'] = total;
    data['Diff'] = diff;
    data['EDate'] = eDate;
    return data;
  }
}
