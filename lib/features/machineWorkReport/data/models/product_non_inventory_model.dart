class ProductNonInventoryModel {
  List<ProductNonInventoryItem>? productNonInventoryItemList;
  int? numberofrecords;

  ProductNonInventoryModel({this.productNonInventoryItemList, this.numberofrecords});

  ProductNonInventoryModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      productNonInventoryItemList = <ProductNonInventoryItem>[];
      json['dynamicList'].forEach((v) {
        productNonInventoryItemList!.add(ProductNonInventoryItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productNonInventoryItemList != null) {
      data['dynamicList'] = productNonInventoryItemList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class ProductNonInventoryItem {
  int? proID;
  String? proName;

  ProductNonInventoryItem({
    this.proID,
    this.proName,
  });

  ProductNonInventoryItem.fromJson(Map<String, dynamic> json) {
    proID = json['ProID'];
    proName = json['ProName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProID'] = proID;
    data['ProName'] = proName;
    return data;
  }

  @override
  String toString() {
    return "$proName";
  }
}
