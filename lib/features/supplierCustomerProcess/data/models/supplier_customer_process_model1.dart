class SupplierCustomerProcessModel1 {
  List<DynamicList>? dynamicList;
  num? numberofrecords;

  SupplierCustomerProcessModel1({this.dynamicList, this.numberofrecords});

  SupplierCustomerProcessModel1.fromJson(Map<String, dynamic> json) {
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
  num? eDMXID;
  num? systemID;
  String? insuranceEndDate;
  String? insuranceStartDate;
  num? discountDetailValue;
  String? transportionPriceOutInsuranse;
  String? transportionPriceInsuranse;
  String? visitPriceOutInsurance;
  num? costItemId;
  String? visitPriceInInsurance;
  String? nonActiveSystem;
  num? typeAutoNumber;
  String? insuranceStatus;
  String? hasInstallationVisit;
  String? endVisitsDate;
  String? isGenerated;
  String? usedFromInsurance;
  String? serialNumber;
  String? deliveryDate;
  String? insuranceLimitStart;
  String? insuranceLimit;
  String? proName;
  num? productID;
  num? unitePrice;
  num? proID;
  String? expr1;
  double? proPrice;
  double? proCost;
  String? proParent;
  String? description;
  String? prolevel;
  num? modality;
  bool? iSCall;
  double? size;
  num? contractID;
  String? contractDate;
  double? contractAmountwTax;
  String? contractNote;
  double? contractAmountWoTax;
  bool? isService;
  num? contractType;
  num? customerID;
  String? contractEnddate;
  bool? istender;
  String? note2;
  String? note7;
  String? setupDate;
  String? setupNote;
  String? typeName;
  bool? iSCancel;
  bool? isInstall;
  double? supplierMony;
  String? modifyAt;
  num? createBy;
  String? createAt;
  String? modifyBy;
  num? storeID;
  num? autoNumber;
  num? discount;
  num? currancyID;
  double? currancyEX;
  num? ordernumber;
  num? pOPaid;
  num? totalOrder;
  num? totalCurrancy;
  double? discountCurrancy;
  String? pOPaidCurrancy;
  num? totalafterdetaildiscount;
  num? totalafterdetailTax;
  num? supplierID;
  num? comID;
  double? cost;
  num? qty;
  num? unitID;
  String? uName;
  num? priceCurrancy;
  num? salesMan;
  num? subCost;
  double? secQuntity;
  String? secUnit;
  String? employeeNameA;
  String? customerAccountName;
  String? customerAccountMobile1;
  num? categoryID;
  String? customerAccountAddress;
  String? gov;
  String? cName;
  num? tax;
  num? taxCurrancy;
  num? addTax;
  double? addTaxCurrancy;
  num? salesTupeID;
  double? totalOrderBefor;
  double? totalBeforCurrancy;
  bool? isResale;
  num? colorID;
  num? dimantionID;
  num? groupID;
  String? lastCommission;
  num? sizeID;
  String? expirdate;
  num? systemStore;
  String? receiptAdress;
  String? receiptFooter;
  String? receiptName;
  num? matrialID;
  String? receiptPhone;
  String? logo;
  String? colorName;
  String? sizeName;
  String? mName;
  String? companyName;
  String? modalityName;
  String? categoryName;
  String? productCategory;
  bool? isSystemResale;
  String? empPerm;
  String? customersalesMan;
  double? hPerm;
  num? customerSalesManID;
  num? costCenterID;
  num? supplyOrderMasterID;
  double? totalCost;
  num? total;
  double? profit;
  String? currentQTY;
  num? totalSubCost;
  num? subProfit;

  DynamicList(
      {this.eDMXID,
      this.systemID,
      this.insuranceEndDate,
      this.insuranceStartDate,
      this.discountDetailValue,
      this.transportionPriceOutInsuranse,
      this.transportionPriceInsuranse,
      this.visitPriceOutInsurance,
      this.costItemId,
      this.visitPriceInInsurance,
      this.nonActiveSystem,
      this.typeAutoNumber,
      this.insuranceStatus,
      this.hasInstallationVisit,
      this.endVisitsDate,
      this.isGenerated,
      this.usedFromInsurance,
      this.serialNumber,
      this.deliveryDate,
      this.insuranceLimitStart,
      this.insuranceLimit,
      this.proName,
      this.productID,
      this.unitePrice,
      this.proID,
      this.expr1,
      this.proPrice,
      this.proCost,
      this.proParent,
      this.description,
      this.prolevel,
      this.modality,
      this.iSCall,
      this.size,
      this.contractID,
      this.contractDate,
      this.contractAmountwTax,
      this.contractNote,
      this.contractAmountWoTax,
      this.isService,
      this.contractType,
      this.customerID,
      this.contractEnddate,
      this.istender,
      this.note2,
      this.note7,
      this.setupDate,
      this.setupNote,
      this.typeName,
      this.iSCancel,
      this.isInstall,
      this.supplierMony,
      this.modifyAt,
      this.createBy,
      this.createAt,
      this.modifyBy,
      this.storeID,
      this.autoNumber,
      this.discount,
      this.currancyID,
      this.currancyEX,
      this.ordernumber,
      this.pOPaid,
      this.totalOrder,
      this.totalCurrancy,
      this.discountCurrancy,
      this.pOPaidCurrancy,
      this.totalafterdetaildiscount,
      this.totalafterdetailTax,
      this.supplierID,
      this.comID,
      this.cost,
      this.qty,
      this.unitID,
      this.uName,
      this.priceCurrancy,
      this.salesMan,
      this.subCost,
      this.secQuntity,
      this.secUnit,
      this.employeeNameA,
      this.customerAccountName,
      this.customerAccountMobile1,
      this.categoryID,
      this.customerAccountAddress,
      this.gov,
      this.cName,
      this.tax,
      this.taxCurrancy,
      this.addTax,
      this.addTaxCurrancy,
      this.salesTupeID,
      this.totalOrderBefor,
      this.totalBeforCurrancy,
      this.isResale,
      this.colorID,
      this.dimantionID,
      this.groupID,
      this.lastCommission,
      this.sizeID,
      this.expirdate,
      this.systemStore,
      this.receiptAdress,
      this.receiptFooter,
      this.receiptName,
      this.matrialID,
      this.receiptPhone,
      this.logo,
      this.colorName,
      this.sizeName,
      this.mName,
      this.companyName,
      this.modalityName,
      this.categoryName,
      this.productCategory,
      this.isSystemResale,
      this.empPerm,
      this.customersalesMan,
      this.hPerm,
      this.customerSalesManID,
      this.costCenterID,
      this.supplyOrderMasterID,
      this.totalCost,
      this.total,
      this.profit,
      this.currentQTY,
      this.totalSubCost,
      this.subProfit});

  DynamicList.fromJson(Map<String, dynamic> json) {
    eDMXID = json['EDMXID'];
    systemID = json['SystemID'];
    insuranceEndDate = json['InsuranceEndDate'];
    insuranceStartDate = json['InsuranceStartDate'];
    discountDetailValue = json['DiscountDetailValue'];
    transportionPriceOutInsuranse = json['TransportionPriceOutInsuranse'];
    transportionPriceInsuranse = json['TransportionPriceInsuranse'];
    visitPriceOutInsurance = json['VisitPriceOutInsurance'];
    costItemId = json['CostItemId'];
    visitPriceInInsurance = json['VisitPriceInInsurance'];
    nonActiveSystem = json['NonActiveSystem'];
    typeAutoNumber = json['TypeAutoNumber'];
    insuranceStatus = json['InsuranceStatus'];
    hasInstallationVisit = json['HasInstallationVisit'];
    endVisitsDate = json['EndVisitsDate'];
    isGenerated = json['IsGenerated'];
    usedFromInsurance = json['UsedFromInsurance'];
    serialNumber = json['SerialNumber'];
    deliveryDate = json['DeliveryDate'];
    insuranceLimitStart = json['InsuranceLimitStart'];
    insuranceLimit = json['InsuranceLimit'];
    proName = json['ProName'];
    productID = json['ProductID'];
    unitePrice = json['UnitePrice'];
    proID = json['ProID'];
    expr1 = json['Expr1'];
    proPrice = json['ProPrice'];
    proCost = json['ProCost'];
    proParent = json['ProParent'];
    description = json['Description'];
    prolevel = json['Prolevel'];
    modality = json['Modality'];
    iSCall = json['ISCall'];
    size = json['Size'];
    contractID = json['ContractID'];
    contractDate = json['ContractDate'];
    contractAmountwTax = json['ContractAmountwTax'];
    contractNote = json['ContractNote'];
    contractAmountWoTax = json['ContractAmountWoTax'];
    isService = json['IsService'];
    contractType = json['ContractType'];
    customerID = json['CustomerID'];
    contractEnddate = json['ContractEnddate'];
    istender = json['Istender'];
    note2 = json['Note2'];
    note7 = json['Note7'];
    setupDate = json['SetupDate'];
    setupNote = json['SetupNote'];
    typeName = json['TypeName'];
    iSCancel = json['ISCancel'];
    isInstall = json['IsInstall'];
    supplierMony = json['SupplierMony'];
    modifyAt = json['ModifyAt'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    modifyBy = json['ModifyBy'];
    storeID = json['StoreID'];
    autoNumber = json['AutoNumber'];
    discount = json['Discount'];
    currancyID = json['CurrancyID'];
    currancyEX = json['CurrancyEX'];
    ordernumber = json['Ordernumber'];
    pOPaid = json['POPaid'];
    totalOrder = json['TotalOrder'];
    totalCurrancy = json['TotalCurrancy'];
    discountCurrancy = json['DiscountCurrancy'];
    pOPaidCurrancy = json['POPaidCurrancy'];
    totalafterdetaildiscount = json['Totalafterdetaildiscount'];
    totalafterdetailTax = json['TotalafterdetailTax'];
    supplierID = json['SupplierID'];
    comID = json['ComID'];
    cost = json['Cost'];
    qty = json['Qty'];
    unitID = json['UnitID'];
    uName = json['UName'];
    priceCurrancy = json['PriceCurrancy'];
    salesMan = json['SalesMan'];
    subCost = json['SubCost'];
    secQuntity = json['SecQuntity'];
    secUnit = json['SecUnit'];
    employeeNameA = json['EmployeeNameA'];
    customerAccountName = json['CustomerAccountName'];
    customerAccountMobile1 = json['CustomerAccountMobile1'];
    categoryID = json['CategoryID'];
    customerAccountAddress = json['CustomerAccountAddress'];
    gov = json['Gov'];
    cName = json['CName'];
    tax = json['Tax'];
    taxCurrancy = json['TaxCurrancy'];
    addTax = json['AddTax'];
    addTaxCurrancy = json['AddTaxCurrancy'];
    salesTupeID = json['SalesTupeID'];
    totalOrderBefor = json['TotalOrderBefor'];
    totalBeforCurrancy = json['TotalBeforCurrancy'];
    isResale = json['IsResale'];
    colorID = json['ColorID'];
    dimantionID = json['DimantionID'];
    groupID = json['GroupID'];
    lastCommission = json['LastCommission'];
    sizeID = json['SizeID'];
    expirdate = json['Expirdate'];
    systemStore = json['SystemStore'];
    receiptAdress = json['ReceiptAdress'];
    receiptFooter = json['ReceiptFooter'];
    receiptName = json['ReceiptName'];
    matrialID = json['MatrialID'];
    receiptPhone = json['ReceiptPhone'];
    logo = json['Logo'];
    colorName = json['ColorName'];
    sizeName = json['SizeName'];
    mName = json['MName'];
    companyName = json['CompanyName'];
    modalityName = json['ModalityName'];
    categoryName = json['CategoryName'];
    productCategory = json['ProductCategory'];
    isSystemResale = json['IsSystemResale'];
    empPerm = json['empPerm'];
    customersalesMan = json['CustomersalesMan'];
    hPerm = json['HPerm'];
    customerSalesManID = json['CustomerSalesManID'];
    costCenterID = json['CostCenterID'];
    supplyOrderMasterID = json['SupplyOrderMasterID'];
    totalCost = json['TotalCost'];
    total = json['Total'];
    profit = json['Profit'];
    currentQTY = json['CurrentQTY'];
    totalSubCost = json['TotalSubCost'];
    subProfit = json['SubProfit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EDMXID'] = eDMXID;
    data['SystemID'] = systemID;
    data['InsuranceEndDate'] = insuranceEndDate;
    data['InsuranceStartDate'] = insuranceStartDate;
    data['DiscountDetailValue'] = discountDetailValue;
    data['TransportionPriceOutInsuranse'] = transportionPriceOutInsuranse;
    data['TransportionPriceInsuranse'] = transportionPriceInsuranse;
    data['VisitPriceOutInsurance'] = visitPriceOutInsurance;
    data['CostItemId'] = costItemId;
    data['VisitPriceInInsurance'] = visitPriceInInsurance;
    data['NonActiveSystem'] = nonActiveSystem;
    data['TypeAutoNumber'] = typeAutoNumber;
    data['InsuranceStatus'] = insuranceStatus;
    data['HasInstallationVisit'] = hasInstallationVisit;
    data['EndVisitsDate'] = endVisitsDate;
    data['IsGenerated'] = isGenerated;
    data['UsedFromInsurance'] = usedFromInsurance;
    data['SerialNumber'] = serialNumber;
    data['DeliveryDate'] = deliveryDate;
    data['InsuranceLimitStart'] = insuranceLimitStart;
    data['InsuranceLimit'] = insuranceLimit;
    data['ProName'] = proName;
    data['ProductID'] = productID;
    data['UnitePrice'] = unitePrice;
    data['ProID'] = proID;
    data['Expr1'] = expr1;
    data['ProPrice'] = proPrice;
    data['ProCost'] = proCost;
    data['ProParent'] = proParent;
    data['Description'] = description;
    data['Prolevel'] = prolevel;
    data['Modality'] = modality;
    data['ISCall'] = iSCall;
    data['Size'] = size;
    data['ContractID'] = contractID;
    data['ContractDate'] = contractDate;
    data['ContractAmountwTax'] = contractAmountwTax;
    data['ContractNote'] = contractNote;
    data['ContractAmountWoTax'] = contractAmountWoTax;
    data['IsService'] = isService;
    data['ContractType'] = contractType;
    data['CustomerID'] = customerID;
    data['ContractEnddate'] = contractEnddate;
    data['Istender'] = istender;
    data['Note2'] = note2;
    data['Note7'] = note7;
    data['SetupDate'] = setupDate;
    data['SetupNote'] = setupNote;
    data['TypeName'] = typeName;
    data['ISCancel'] = iSCancel;
    data['IsInstall'] = isInstall;
    data['SupplierMony'] = supplierMony;
    data['ModifyAt'] = modifyAt;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['ModifyBy'] = modifyBy;
    data['StoreID'] = storeID;
    data['AutoNumber'] = autoNumber;
    data['Discount'] = discount;
    data['CurrancyID'] = currancyID;
    data['CurrancyEX'] = currancyEX;
    data['Ordernumber'] = ordernumber;
    data['POPaid'] = pOPaid;
    data['TotalOrder'] = totalOrder;
    data['TotalCurrancy'] = totalCurrancy;
    data['DiscountCurrancy'] = discountCurrancy;
    data['POPaidCurrancy'] = pOPaidCurrancy;
    data['Totalafterdetaildiscount'] = totalafterdetaildiscount;
    data['TotalafterdetailTax'] = totalafterdetailTax;
    data['SupplierID'] = supplierID;
    data['ComID'] = comID;
    data['Cost'] = cost;
    data['Qty'] = qty;
    data['UnitID'] = unitID;
    data['UName'] = uName;
    data['PriceCurrancy'] = priceCurrancy;
    data['SalesMan'] = salesMan;
    data['SubCost'] = subCost;
    data['SecQuntity'] = secQuntity;
    data['SecUnit'] = secUnit;
    data['EmployeeNameA'] = employeeNameA;
    data['CustomerAccountName'] = customerAccountName;
    data['CustomerAccountMobile1'] = customerAccountMobile1;
    data['CategoryID'] = categoryID;
    data['CustomerAccountAddress'] = customerAccountAddress;
    data['Gov'] = gov;
    data['CName'] = cName;
    data['Tax'] = tax;
    data['TaxCurrancy'] = taxCurrancy;
    data['AddTax'] = addTax;
    data['AddTaxCurrancy'] = addTaxCurrancy;
    data['SalesTupeID'] = salesTupeID;
    data['TotalOrderBefor'] = totalOrderBefor;
    data['TotalBeforCurrancy'] = totalBeforCurrancy;
    data['IsResale'] = isResale;
    data['ColorID'] = colorID;
    data['DimantionID'] = dimantionID;
    data['GroupID'] = groupID;
    data['LastCommission'] = lastCommission;
    data['SizeID'] = sizeID;
    data['Expirdate'] = expirdate;
    data['SystemStore'] = systemStore;
    data['ReceiptAdress'] = receiptAdress;
    data['ReceiptFooter'] = receiptFooter;
    data['ReceiptName'] = receiptName;
    data['MatrialID'] = matrialID;
    data['ReceiptPhone'] = receiptPhone;
    data['Logo'] = logo;
    data['ColorName'] = colorName;
    data['SizeName'] = sizeName;
    data['MName'] = mName;
    data['CompanyName'] = companyName;
    data['ModalityName'] = modalityName;
    data['CategoryName'] = categoryName;
    data['ProductCategory'] = productCategory;
    data['IsSystemResale'] = isSystemResale;
    data['empPerm'] = empPerm;
    data['CustomersalesMan'] = customersalesMan;
    data['HPerm'] = hPerm;
    data['CustomerSalesManID'] = customerSalesManID;
    data['CostCenterID'] = costCenterID;
    data['SupplyOrderMasterID'] = supplyOrderMasterID;
    data['TotalCost'] = totalCost;
    data['Total'] = total;
    data['Profit'] = profit;
    data['CurrentQTY'] = currentQTY;
    data['TotalSubCost'] = totalSubCost;
    data['SubProfit'] = subProfit;
    return data;
  }
}
