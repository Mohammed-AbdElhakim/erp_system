/*
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
*/
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
  String? namepro;
  double? proPrice;
  double? proCost;
  String? description;
  int? modality;
  String? modalityName;
  int? comID;
  String? companyName;
  int? pIndex;
  bool? iSQuntity;
  bool? iSInventory;
  bool? iSSales;
  bool? saleMoreOne;
  bool? iSContractSale;
  bool? iSPrimary;
  bool? iSPurchase;
  int? unitID;
  bool? isSize;
  bool? isDimantion;
  int? sizeVector;
  int? secoundUnit;
  double? secPrice;
  String? proName;
  String? dropDownSearch;
  String? proAutoCodeWithModality;
  double? unitsInMasterUnit;
  bool? isColor;
  String? barCode;
  int? proParent;
  String? note;
  int? supplierID;
  String? purchCode;
  int? colorID;
  int? sizeID;
  bool? iSService;

  ProductItem(
      {this.proID,
      this.namepro,
      this.proPrice,
      this.proCost,
      this.description,
      this.modality,
      this.modalityName,
      this.comID,
      this.companyName,
      this.pIndex,
      this.iSQuntity,
      this.iSInventory,
      this.iSSales,
      this.saleMoreOne,
      this.iSContractSale,
      this.iSPrimary,
      this.iSPurchase,
      this.unitID,
      this.isSize,
      this.isDimantion,
      this.sizeVector,
      this.secoundUnit,
      this.secPrice,
      this.proName,
      this.dropDownSearch,
      this.proAutoCodeWithModality,
      this.unitsInMasterUnit,
      this.isColor,
      this.barCode,
      this.proParent,
      this.note,
      this.supplierID,
      this.purchCode,
      this.colorID,
      this.sizeID,
      this.iSService});

  ProductItem.fromJson(Map<String, dynamic> json) {
    proID = json['ProID'];
    namepro = json['namepro'];
    proPrice = json['ProPrice'];
    proCost = json['ProCost'];
    description = json['Description'];
    modality = json['Modality'];
    modalityName = json['ModalityName'];
    comID = json['ComID'];
    companyName = json['CompanyName'];
    pIndex = json['PIndex'];
    iSQuntity = json['ISQuntity'];
    iSInventory = json['ISInventory'];
    iSSales = json['ISSales'];
    saleMoreOne = json['SaleMoreOne'];
    iSContractSale = json['ISContractSale'];
    iSPrimary = json['ISPrimary'];
    iSPurchase = json['ISPurchase'];
    unitID = json['UnitID'];
    isSize = json['IsSize'];
    isDimantion = json['IsDimantion'];
    sizeVector = json['SizeVector'];
    secoundUnit = json['SecoundUnit'];
    secPrice = json['SecPrice'];
    proName = json['ProName'];
    dropDownSearch = json['DropDownSearch'];
    proAutoCodeWithModality = json['ProAutoCodeWithModality'];
    unitsInMasterUnit = json['UnitsInMasterUnit'];
    isColor = json['IsColor'];
    barCode = json['BarCode'];
    proParent = json['ProParent'];
    note = json['Note'];
    supplierID = json['SupplierID'];
    purchCode = json['PurchCode'];
    colorID = json['ColorID'];
    sizeID = json['SizeID'];
    iSService = json['ISService'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProID'] = proID;
    data['namepro'] = namepro;
    data['ProPrice'] = proPrice;
    data['ProCost'] = proCost;
    data['Description'] = description;
    data['Modality'] = modality;
    data['ModalityName'] = modalityName;
    data['ComID'] = comID;
    data['CompanyName'] = companyName;
    data['PIndex'] = pIndex;
    data['ISQuntity'] = iSQuntity;
    data['ISInventory'] = iSInventory;
    data['ISSales'] = iSSales;
    data['SaleMoreOne'] = saleMoreOne;
    data['ISContractSale'] = iSContractSale;
    data['ISPrimary'] = iSPrimary;
    data['ISPurchase'] = iSPurchase;
    data['UnitID'] = unitID;
    data['IsSize'] = isSize;
    data['IsDimantion'] = isDimantion;
    data['SizeVector'] = sizeVector;
    data['SecoundUnit'] = secoundUnit;
    data['SecPrice'] = secPrice;
    data['ProName'] = proName;
    data['DropDownSearch'] = dropDownSearch;
    data['ProAutoCodeWithModality'] = proAutoCodeWithModality;
    data['UnitsInMasterUnit'] = unitsInMasterUnit;
    data['IsColor'] = isColor;
    data['BarCode'] = barCode;
    data['ProParent'] = proParent;
    data['Note'] = note;
    data['SupplierID'] = supplierID;
    data['PurchCode'] = purchCode;
    data['ColorID'] = colorID;
    data['SizeID'] = sizeID;
    data['ISService'] = iSService;
    return data;
  }
}
