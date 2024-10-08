class SupplierProcessModel1 {
  List<SupplierProcessItem1>? dynamicList;
  int? numberofrecords;

  SupplierProcessModel1({this.dynamicList, this.numberofrecords});

  SupplierProcessModel1.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <SupplierProcessItem1>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(new SupplierProcessItem1.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dynamicList != null) {
      data['dynamicList'] = this.dynamicList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = this.numberofrecords;
    return data;
  }
}

class SupplierProcessItem1 {
  int? pDID;
  int? purchaseOrderID;
  int? productID;
  double? cost;
  double? quntity;
  String? proName;
  int? modality;
  double? total;
  int? pOID;
  int? pONumber;
  String? pODate;
  int? supplierID;
  double? pOPaid;
  int? pOSetting;
  int? currancyID;
  double? purchtotal;
  double? totalOrder;
  double? totalCurrancy;
  double? discount;
  double? discountCurrancy;
  double? pOPaidCurrancy;
  double? currancyEX;
  double? remind;
  double? remindCurrancy;
  double? costCurrancy;
  int? storeID;
  String? uName;
  String? cName;
  String? sName;
  String? pSName;
  int? comID;
  double? guideWeight;
  double? guidePrice;
  double? difQty;
  double? difSupplierQty;
  double? difSupplierQtyPrice;
  int? employeeId;
  double? tax;
  double? addTax;
  double? finalTotal;
  double? totalCostExp;
  double? totalCostWithExp;
  String? pODescription;
  double? secQuntity;
  int? costItemId;
  double? taxCurrancy;

  SupplierProcessItem1(
      {this.pDID,
      this.purchaseOrderID,
      this.productID,
      this.cost,
      this.quntity,
      this.proName,
      this.modality,
      this.total,
      this.pOID,
      this.pONumber,
      this.pODate,
      this.supplierID,
      this.pOPaid,
      this.pOSetting,
      this.currancyID,
      this.purchtotal,
      this.totalOrder,
      this.totalCurrancy,
      this.discount,
      this.discountCurrancy,
      this.pOPaidCurrancy,
      this.currancyEX,
      this.remind,
      this.remindCurrancy,
      this.costCurrancy,
      this.storeID,
      this.uName,
      this.cName,
      this.sName,
      this.pSName,
      this.comID,
      this.guideWeight,
      this.guidePrice,
      this.difQty,
      this.difSupplierQty,
      this.difSupplierQtyPrice,
      this.employeeId,
      this.tax,
      this.addTax,
      this.finalTotal,
      this.totalCostExp,
      this.totalCostWithExp,
      this.pODescription,
      this.secQuntity,
      this.costItemId,
      this.taxCurrancy});

  SupplierProcessItem1.fromJson(Map<String, dynamic> json) {
    pDID = json['PDID'];
    purchaseOrderID = json['PurchaseOrderID'];
    productID = json['ProductID'];
    cost = json['Cost'];
    quntity = json['Quntity'];
    proName = json['ProName'];
    modality = json['Modality'];
    total = json['Total'];
    pOID = json['POID'];
    pONumber = json['PONumber'];
    pODate = json['PODate'];
    supplierID = json['SupplierID'];
    pOPaid = json['POPaid'];
    pOSetting = json['POSetting'];
    currancyID = json['CurrancyID'];
    purchtotal = json['purchtotal'];
    totalOrder = json['TotalOrder'];
    totalCurrancy = json['TotalCurrancy'];
    discount = json['Discount'];
    discountCurrancy = json['DiscountCurrancy'];
    pOPaidCurrancy = json['POPaidCurrancy'];
    currancyEX = json['CurrancyEX'];
    remind = json['remind'];
    remindCurrancy = json['remindCurrancy'];
    costCurrancy = json['CostCurrancy'];
    storeID = json['StoreID'];
    uName = json['UName'];
    cName = json['CName'];
    sName = json['SName'];
    pSName = json['PSName'];
    comID = json['ComID'];
    guideWeight = json['GuideWeight'];
    guidePrice = json['GuidePrice'];
    difQty = json['DifQty'];
    difSupplierQty = json['DifSupplierQty'];
    difSupplierQtyPrice = json['DifSupplierQtyPrice'];
    employeeId = json['EmployeeId'];
    tax = json['Tax'];
    addTax = json['AddTax'];
    finalTotal = json['finalTotal'];
    totalCostExp = json['TotalCostExp'];
    totalCostWithExp = json['TotalCostWithExp'];
    pODescription = json['PODescription'];
    secQuntity = json['SecQuntity'];
    costItemId = json['CostItemId'];
    taxCurrancy = json['TaxCurrancy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PDID'] = this.pDID;
    data['PurchaseOrderID'] = this.purchaseOrderID;
    data['ProductID'] = this.productID;
    data['Cost'] = this.cost;
    data['Quntity'] = this.quntity;
    data['ProName'] = this.proName;
    data['Modality'] = this.modality;
    data['Total'] = this.total;
    data['POID'] = this.pOID;
    data['PONumber'] = this.pONumber;
    data['PODate'] = this.pODate;
    data['SupplierID'] = this.supplierID;
    data['POPaid'] = this.pOPaid;
    data['POSetting'] = this.pOSetting;
    data['CurrancyID'] = this.currancyID;
    data['purchtotal'] = this.purchtotal;
    data['TotalOrder'] = this.totalOrder;
    data['TotalCurrancy'] = this.totalCurrancy;
    data['Discount'] = this.discount;
    data['DiscountCurrancy'] = this.discountCurrancy;
    data['POPaidCurrancy'] = this.pOPaidCurrancy;
    data['CurrancyEX'] = this.currancyEX;
    data['remind'] = this.remind;
    data['remindCurrancy'] = this.remindCurrancy;
    data['CostCurrancy'] = this.costCurrancy;
    data['StoreID'] = this.storeID;
    data['UName'] = this.uName;
    data['CName'] = this.cName;
    data['SName'] = this.sName;
    data['PSName'] = this.pSName;
    data['ComID'] = this.comID;
    data['GuideWeight'] = this.guideWeight;
    data['GuidePrice'] = this.guidePrice;
    data['DifQty'] = this.difQty;
    data['DifSupplierQty'] = this.difSupplierQty;
    data['DifSupplierQtyPrice'] = this.difSupplierQtyPrice;
    data['EmployeeId'] = this.employeeId;
    data['Tax'] = this.tax;
    data['AddTax'] = this.addTax;
    data['finalTotal'] = this.finalTotal;
    data['TotalCostExp'] = this.totalCostExp;
    data['TotalCostWithExp'] = this.totalCostWithExp;
    data['PODescription'] = this.pODescription;
    data['SecQuntity'] = this.secQuntity;
    data['CostItemId'] = this.costItemId;
    data['TaxCurrancy'] = this.taxCurrancy;
    return data;
  }
}
