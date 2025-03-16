class TaxDeclarationModel0 {
  List<DynamicList>? dynamicList;

  TaxDeclarationModel0({this.dynamicList});

  TaxDeclarationModel0.fromJson(Map<String, dynamic> json) {
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
  int? taxCategoryID;
  int? isPurchase;
  int? isSales;
  String? tCName;
  double? total;
  double? totalTax;
  double? finalTotal;
  String? color;

  DynamicList(
      {this.taxCategoryID,
      this.isPurchase,
      this.isSales,
      this.tCName,
      this.total,
      this.totalTax,
      this.finalTotal,
      this.color});

  DynamicList.fromJson(Map<String, dynamic> json) {
    taxCategoryID = json['TaxCategoryID'];
    isPurchase = json['IsPurchase'];
    isSales = json['IsSales'];
    tCName = json['TCName'];
    total = json['Total'];
    totalTax = json['TotalTax'];
    finalTotal = json['FinalTotal'];
    color = json['Color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TaxCategoryID'] = taxCategoryID;
    data['IsPurchase'] = isPurchase;
    data['IsSales'] = isSales;
    data['TCName'] = tCName;
    data['Total'] = total;
    data['TotalTax'] = totalTax;
    data['FinalTotal'] = finalTotal;
    data['Color'] = color;
    return data;
  }
}
