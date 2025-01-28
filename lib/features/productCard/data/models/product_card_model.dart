class ProductCardModel {
  List<ProductCardItem>? dynamicList;
  int? numberofrecords;

  ProductCardModel({this.dynamicList, this.numberofrecords});

  ProductCardModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <ProductCardItem>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(ProductCardItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dynamicList != null) {
      data['dynamicList'] = dynamicList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class ProductCardItem {
  double? input;
  double? output;
  String? proName;
  int? productID;
  String? eDate;
  String? eDescription;
  int? storeID;
  String? storeAcName;
  String? sName;
  double? total;
  int? pIndex;
  double? pCost;
  double? balance;
  String? pRTName;
  int? code;
  String? customerAccountName;
  int? autoNumber;
  String? orderNote;
  double? proPrice;
  String? colorName;
  String? sizeName;
  int? supplierID;
  String? supName;
  int? pONumber;
  double? purchTotal;
  int? unitID;
  String? uName;

  ProductCardItem(
      {this.input,
      this.output,
      this.proName,
      this.productID,
      this.eDate,
      this.eDescription,
      this.storeID,
      this.storeAcName,
      this.sName,
      this.total,
      this.pIndex,
      this.pCost,
      this.balance,
      this.pRTName,
      this.code,
      this.customerAccountName,
      this.autoNumber,
      this.orderNote,
      this.proPrice,
      this.colorName,
      this.sizeName,
      this.supplierID,
      this.supName,
      this.pONumber,
      this.purchTotal,
      this.unitID,
      this.uName});

  ProductCardItem.fromJson(Map<String, dynamic> json) {
    input = json['Input'];
    output = json['output'];
    proName = json['ProName'];
    productID = json['ProductID'];
    eDate = json['EDate'];
    eDescription = json['EDescription'];
    storeID = json['StoreID'];
    storeAcName = json['StoreAcName'];
    sName = json['SName'];
    total = json['total'];
    pIndex = json['PIndex'];
    pCost = json['PCost'];
    balance = json['Balance'];
    pRTName = json['PRTName'];
    code = json['code'];
    customerAccountName = json['CustomerAccountName'];
    autoNumber = json['AutoNumber'];
    orderNote = json['OrderNote'];
    proPrice = json['ProPrice'];
    colorName = json['ColorName'];
    sizeName = json['SizeName'];
    supplierID = json['SupplierID'];
    supName = json['SupName'];
    pONumber = json['PONumber'];
    purchTotal = json['PurchTotal'];
    unitID = json['UnitID'];
    uName = json['UName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Input'] = input;
    data['output'] = output;
    data['ProName'] = proName;
    data['ProductID'] = productID;
    data['EDate'] = eDate;
    data['EDescription'] = eDescription;
    data['StoreID'] = storeID;
    data['StoreAcName'] = storeAcName;
    data['SName'] = sName;
    data['total'] = total;
    data['PIndex'] = pIndex;
    data['PCost'] = pCost;
    data['Balance'] = balance;
    data['PRTName'] = pRTName;
    data['code'] = code;
    data['CustomerAccountName'] = customerAccountName;
    data['AutoNumber'] = autoNumber;
    data['OrderNote'] = orderNote;
    data['ProPrice'] = proPrice;
    data['ColorName'] = colorName;
    data['SizeName'] = sizeName;
    data['SupplierID'] = supplierID;
    data['SupName'] = supName;
    data['PONumber'] = pONumber;
    data['PurchTotal'] = purchTotal;
    data['UnitID'] = unitID;
    data['UName'] = uName;
    return data;
  }
}
