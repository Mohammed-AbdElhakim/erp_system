class CustomerAccountModel1and2 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  CustomerAccountModel1and2({this.dynamicList, this.numberofrecords});

  CustomerAccountModel1and2.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <DynamicList>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(DynamicList.fromJson(v));
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

class DynamicList {
  int? eDMXID;
  bool? isSales;
  int? systemID;
  String? proName;
  int? productID;
  double? unitePrice;
  int? proID;
  String? expr1;
  double? proCost;
  int? modality;
  int? contractID;
  String? contractDate;
  int? contractType;
  int? customerID;
  bool? istender;
  String? typeName;
  int? createBy;
  String? createAt;
  int? storeID;
  int? autoNumber;
  double? discount;
  double? pOPaid;
  bool? unRelaied;
  double? totalOrder;
  double? totalCurrancy;
  double? discountCurrancy;
  int? comID;
  double? cost;
  double? qty;
  double? priceCurrancy;
  int? salesMan;
  String? employeeNameA;
  String? customerAccountName;
  String? customerAccountMobile1;
  double? tax;
  double? taxCurrancy;
  double? addTax;
  double? addTaxCurrancy;
  double? finalTotal;
  double? shippingPrice;
  int? departmentId;
  String? systemDescription;
  double? systemCost;
  int? systemStore;
  int? typeAutoNumber;
  String? pPIName;
  int? pPIID;
  int? code;
  bool? willFactor;
  double? totalCost;
  double? total;
  double? totalafterdetaildiscount;
  double? totalafterdetailTax;
  double? profit;
  String? currentQTY;
  double? guideWeight;
  double? guidePrice;
  double? difQty;
  String? storeName;
  String? modalityName;
  int? companyID;
  String? companyName;
  int? customerCode;
  String? sName;
  int? iSMonth;
  double? taxDetailPercent;
  double? taxDetailValue;
  double? discountDetailPercent;
  double? discountDetailValue;
  double? itemDiscount;
  int? codeiD;
  double? unitPriceAfterTax;
  int? unitID;
  String? uName;
  int? costCenterID;
  String? contractNote;
  String? note3;
  int? costItemId;
  bool? isShipable;
  int? contractProjectID;
  int? detailProjectID;

  DynamicList(
      {this.eDMXID,
      this.isSales,
      this.systemID,
      this.proName,
      this.productID,
      this.unitePrice,
      this.proID,
      this.expr1,
      this.proCost,
      this.modality,
      this.contractID,
      this.contractDate,
      this.contractType,
      this.customerID,
      this.istender,
      this.typeName,
      this.createBy,
      this.createAt,
      this.storeID,
      this.autoNumber,
      this.discount,
      this.pOPaid,
      this.unRelaied,
      this.totalOrder,
      this.totalCurrancy,
      this.discountCurrancy,
      this.comID,
      this.cost,
      this.qty,
      this.priceCurrancy,
      this.salesMan,
      this.employeeNameA,
      this.customerAccountName,
      this.customerAccountMobile1,
      this.tax,
      this.taxCurrancy,
      this.addTax,
      this.addTaxCurrancy,
      this.finalTotal,
      this.shippingPrice,
      this.departmentId,
      this.systemDescription,
      this.systemCost,
      this.systemStore,
      this.typeAutoNumber,
      this.pPIName,
      this.pPIID,
      this.code,
      this.willFactor,
      this.totalCost,
      this.total,
      this.totalafterdetaildiscount,
      this.totalafterdetailTax,
      this.profit,
      this.currentQTY,
      this.guideWeight,
      this.guidePrice,
      this.difQty,
      this.storeName,
      this.modalityName,
      this.companyID,
      this.companyName,
      this.customerCode,
      this.sName,
      this.iSMonth,
      this.taxDetailPercent,
      this.taxDetailValue,
      this.discountDetailPercent,
      this.discountDetailValue,
      this.itemDiscount,
      this.codeiD,
      this.unitPriceAfterTax,
      this.unitID,
      this.uName,
      this.costCenterID,
      this.contractNote,
      this.note3,
      this.costItemId,
      this.isShipable,
      this.contractProjectID,
      this.detailProjectID});

  DynamicList.fromJson(Map<String, dynamic> json) {
    eDMXID = json['EDMXID'];
    isSales = json['IsSales'];
    systemID = json['SystemID'];
    proName = json['ProName'];
    productID = json['ProductID'];
    unitePrice = json['UnitePrice'];
    proID = json['ProID'];
    expr1 = json['Expr1'];
    proCost = json['ProCost'];
    modality = json['Modality'];
    contractID = json['ContractID'];
    contractDate = json['ContractDate'];
    contractType = json['ContractType'];
    customerID = json['CustomerID'];
    istender = json['Istender'];
    typeName = json['TypeName'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    storeID = json['StoreID'];
    autoNumber = json['AutoNumber'];
    discount = json['Discount'];
    pOPaid = json['POPaid'];
    unRelaied = json['UnRelaied'];
    totalOrder = json['TotalOrder'];
    totalCurrancy = json['TotalCurrancy'];
    discountCurrancy = json['DiscountCurrancy'];
    comID = json['ComID'];
    cost = json['Cost'];
    qty = json['Qty'];
    priceCurrancy = json['PriceCurrancy'];
    salesMan = json['SalesMan'];
    employeeNameA = json['EmployeeNameA'];
    customerAccountName = json['CustomerAccountName'];
    customerAccountMobile1 = json['CustomerAccountMobile1'];
    tax = json['Tax'];
    taxCurrancy = json['TaxCurrancy'];
    addTax = json['AddTax'];
    addTaxCurrancy = json['AddTaxCurrancy'];
    finalTotal = json['finalTotal'];
    shippingPrice = json['shippingPrice'];
    departmentId = json['DepartmentId'];
    systemDescription = json['systemDescription'];
    systemCost = json['systemCost'];
    systemStore = json['SystemStore'];
    typeAutoNumber = json['TypeAutoNumber'];
    pPIName = json['PPIName'];
    pPIID = json['PPIID'];
    code = json['Code'];
    willFactor = json['WillFactor'];
    totalCost = json['TotalCost'];
    total = json['Total'];
    totalafterdetaildiscount = json['Totalafterdetaildiscount'];
    totalafterdetailTax = json['TotalafterdetailTax'];
    profit = json['Profit'];
    currentQTY = json['CurrentQTY'];
    guideWeight = json['GuideWeight'];
    guidePrice = json['GuidePrice'];
    difQty = json['DifQty'];
    storeName = json['StoreName'];
    modalityName = json['ModalityName'];
    companyID = json['CompanyID'];
    companyName = json['CompanyName'];
    customerCode = json['CustomerCode'];
    sName = json['SName'];
    iSMonth = json['ISMonth'];
    taxDetailPercent = json['TaxDetailPercent'];
    taxDetailValue = json['TaxDetailValue'];
    discountDetailPercent = json['DiscountDetailPercent'];
    discountDetailValue = json['DiscountDetailValue'];
    itemDiscount = json['ItemDiscount'];
    codeiD = json['CodeiD'];
    unitPriceAfterTax = json['UnitPriceAfterTax'];
    unitID = json['UnitID'];
    uName = json['UName'];
    costCenterID = json['CostCenterID'];
    contractNote = json['ContractNote'];
    note3 = json['Note3'];
    costItemId = json['CostItemId'];
    isShipable = json['IsShipable'];
    contractProjectID = json['ContractProjectID'];
    detailProjectID = json['DetailProjectID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EDMXID'] = eDMXID;
    data['IsSales'] = isSales;
    data['SystemID'] = systemID;
    data['ProName'] = proName;
    data['ProductID'] = productID;
    data['UnitePrice'] = unitePrice;
    data['ProID'] = proID;
    data['Expr1'] = expr1;
    data['ProCost'] = proCost;
    data['Modality'] = modality;
    data['ContractID'] = contractID;
    data['ContractDate'] = contractDate;
    data['ContractType'] = contractType;
    data['CustomerID'] = customerID;
    data['Istender'] = istender;
    data['TypeName'] = typeName;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['StoreID'] = storeID;
    data['AutoNumber'] = autoNumber;
    data['Discount'] = discount;
    data['POPaid'] = pOPaid;
    data['UnRelaied'] = unRelaied;
    data['TotalOrder'] = totalOrder;
    data['TotalCurrancy'] = totalCurrancy;
    data['DiscountCurrancy'] = discountCurrancy;
    data['ComID'] = comID;
    data['Cost'] = cost;
    data['Qty'] = qty;
    data['PriceCurrancy'] = priceCurrancy;
    data['SalesMan'] = salesMan;
    data['EmployeeNameA'] = employeeNameA;
    data['CustomerAccountName'] = customerAccountName;
    data['CustomerAccountMobile1'] = customerAccountMobile1;
    data['Tax'] = tax;
    data['TaxCurrancy'] = taxCurrancy;
    data['AddTax'] = addTax;
    data['AddTaxCurrancy'] = addTaxCurrancy;
    data['finalTotal'] = finalTotal;
    data['shippingPrice'] = shippingPrice;
    data['DepartmentId'] = departmentId;
    data['systemDescription'] = systemDescription;
    data['systemCost'] = systemCost;
    data['SystemStore'] = systemStore;
    data['TypeAutoNumber'] = typeAutoNumber;
    data['PPIName'] = pPIName;
    data['PPIID'] = pPIID;
    data['Code'] = code;
    data['WillFactor'] = willFactor;
    data['TotalCost'] = totalCost;
    data['Total'] = total;
    data['Totalafterdetaildiscount'] = totalafterdetaildiscount;
    data['TotalafterdetailTax'] = totalafterdetailTax;
    data['Profit'] = profit;
    data['CurrentQTY'] = currentQTY;
    data['GuideWeight'] = guideWeight;
    data['GuidePrice'] = guidePrice;
    data['DifQty'] = difQty;
    data['StoreName'] = storeName;
    data['ModalityName'] = modalityName;
    data['CompanyID'] = companyID;
    data['CompanyName'] = companyName;
    data['CustomerCode'] = customerCode;
    data['SName'] = sName;
    data['ISMonth'] = iSMonth;
    data['TaxDetailPercent'] = taxDetailPercent;
    data['TaxDetailValue'] = taxDetailValue;
    data['DiscountDetailPercent'] = discountDetailPercent;
    data['DiscountDetailValue'] = discountDetailValue;
    data['ItemDiscount'] = itemDiscount;
    data['CodeiD'] = codeiD;
    data['UnitPriceAfterTax'] = unitPriceAfterTax;
    data['UnitID'] = unitID;
    data['UName'] = uName;
    data['CostCenterID'] = costCenterID;
    data['ContractNote'] = contractNote;
    data['Note3'] = note3;
    data['CostItemId'] = costItemId;
    data['IsShipable'] = isShipable;
    data['ContractProjectID'] = contractProjectID;
    data['DetailProjectID'] = detailProjectID;
    return data;
  }
}
