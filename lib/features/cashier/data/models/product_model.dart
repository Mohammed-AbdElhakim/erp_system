class ProductModel {
  List<ProductItem>? productList;
  int? numberofrecords;

  ProductModel({this.productList, this.numberofrecords});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      productList = <ProductItem>[];
      json['dynamicList'].forEach((v) {
        productList!.add(ProductItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productList != null) {
      data['dynamicList'] = productList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class ProductItem {
  int? proID;
  String? proName;
  double? proPrice;
  double? proCost;
  String? description;
  int? modality;
  int? pIndex;
  int? unitID;
  int? secoundUnit;
  bool? isSize;
  bool? isDimantion;
  double? glassSecoretPrice;
  double? glassRawPrice;
  double? glassRentPrice;
  double? secPrice;
  double? unitsInMasterUnit;
  bool? isColor;
  String? barCode;
  int? proParent;
  String? note;
  int? supplierID;
  String? purchCode;
  int? colorID;
  int? sizeID;
  double? uQuntity;
  String? delvarydate;
  String? startDate;
  double? profitMargin;

  ProductItem(
      {this.proID,
      this.proName,
      this.proPrice,
      this.proCost,
      this.description,
      this.modality,
      this.pIndex,
      this.unitID,
      this.secoundUnit,
      this.isSize,
      this.isDimantion,
      this.glassSecoretPrice,
      this.glassRawPrice,
      this.glassRentPrice,
      this.secPrice,
      this.unitsInMasterUnit,
      this.isColor,
      this.barCode,
      this.proParent,
      this.note,
      this.supplierID,
      this.purchCode,
      this.colorID,
      this.sizeID,
      this.uQuntity,
      this.delvarydate,
      this.startDate,
      this.profitMargin});

  ProductItem.fromJson(Map<String, dynamic> json) {
    proID = json['ProID'];
    proName = json['ProName'];
    proPrice = json['ProPrice'];
    proCost = json['ProCost'];
    description = json['Description'];
    modality = json['Modality'];
    pIndex = json['PIndex'];
    unitID = json['UnitID'];
    secoundUnit = json['SecoundUnit'];
    isSize = json['IsSize'];
    isDimantion = json['IsDimantion'];
    glassSecoretPrice = json['GlassSecoretPrice'];
    glassRawPrice = json['GlassRawPrice'];
    glassRentPrice = json['GlassRentPrice'];
    secPrice = json['SecPrice'];
    unitsInMasterUnit = json['UnitsInMasterUnit'];
    isColor = json['IsColor'];
    barCode = json['BarCode'];
    proParent = json['ProParent'];
    note = json['Note'];
    supplierID = json['SupplierID'];
    purchCode = json['PurchCode'];
    colorID = json['ColorID'];
    sizeID = json['SizeID'];
    uQuntity = json['UQuntity'];
    delvarydate = json['Delvarydate'];
    startDate = json['StartDate'];
    profitMargin = json['ProfitMargin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProID'] = proID;
    data['ProName'] = proName;
    data['ProPrice'] = proPrice;
    data['ProCost'] = proCost;
    data['Description'] = description;
    data['Modality'] = modality;
    data['PIndex'] = pIndex;
    data['UnitID'] = unitID;
    data['SecoundUnit'] = secoundUnit;
    data['IsSize'] = isSize;
    data['IsDimantion'] = isDimantion;
    data['GlassSecoretPrice'] = glassSecoretPrice;
    data['GlassRawPrice'] = glassRawPrice;
    data['GlassRentPrice'] = glassRentPrice;
    data['SecPrice'] = secPrice;
    data['UnitsInMasterUnit'] = unitsInMasterUnit;
    data['IsColor'] = isColor;
    data['BarCode'] = barCode;
    data['ProParent'] = proParent;
    data['Note'] = note;
    data['SupplierID'] = supplierID;
    data['PurchCode'] = purchCode;
    data['ColorID'] = colorID;
    data['SizeID'] = sizeID;
    data['UQuntity'] = uQuntity;
    data['Delvarydate'] = delvarydate;
    data['StartDate'] = startDate;
    data['ProfitMargin'] = profitMargin;
    return data;
  }
}
