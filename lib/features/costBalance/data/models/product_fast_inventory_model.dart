class ProductFastInventoryModel {
  List<ProductFastInventoryItem>? productFastInventoryItemList;
  int? numberofrecords;

  ProductFastInventoryModel({this.productFastInventoryItemList, this.numberofrecords});

  ProductFastInventoryModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      productFastInventoryItemList = <ProductFastInventoryItem>[];
      json['dynamicList'].forEach((v) {
        productFastInventoryItemList!.add(ProductFastInventoryItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productFastInventoryItemList != null) {
      data['dynamicList'] = productFastInventoryItemList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class ProductFastInventoryItem {
  String? proName;
  int? proID;

  ProductFastInventoryItem({
    this.proName,
    this.proID,
  });

  ProductFastInventoryItem.fromJson(Map<String, dynamic> json) {
    proName = json['ProName'];
    proID = json['ProID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProName'] = proName;
    data['ProID'] = proID;
    return data;
  }

  @override
  String toString() {
    return "$proName";
  }
}
