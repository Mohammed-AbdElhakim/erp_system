class CostItemAccountReportModel3 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  CostItemAccountReportModel3({this.dynamicList, this.numberofrecords});

  CostItemAccountReportModel3.fromJson(Map<String, dynamic> json) {
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
  String? isSurgery;
  bool? isSales;
  String? supplierID;
  String? proccessNumber;
  int? systemID;
  int? costCenterID;
  String? proName;
  int? productID;
  double? unitePrice;
  int? proID;
  String? empPerm;
  String? expr1;
  String? proPrice;
  double? proCost;
  String? proParent;
  String? description;
  String? prolevel;
  int? modality;
  String? iSCall;
  String? size;
  int? contractID;
  String? contractDate;
  String? contractAmountwTax;
  String? contractNote;
  String? farmingSupplyMasterId;
  String? contractAmountWoTax;
  int? contractType;
  int? customerID;
  String? contractEnddate;
  bool? istender;
  String? setupDate;
  String? setupNote;
  String? typeName;
  String? iSCancel;
  String? isInstall;
  String? supplierMony;
  String? modifyAt;
  int? createBy;
  String? createAt;
  String? modifyBy;
  int? storeID;
  int? autoNumber;
  double? discount;
  String? currancyID;
  String? currancyEX;
  String? ordernumber;
  double? pOPaid;
  bool? unRelaied;
  double? totalOrder;
  double? totalCurrancy;
  double? discountCurrancy;
  double? pOPaidCurrancy;
  int? comID;
  double? cost;
  double? qty;
  int? unitID;
  String? uName;
  double? priceCurrancy;
  String? batchNumber;
  int? salesMan;
  String? secQuntity;
  String? secUnit;
  String? employeeNameA;
  String? customerAccountName;
  String? customerAccountMobile1;
  String? categoryID;
  String? customerAccountAddress;
  String? gov;
  String? cardName;
  String? cName;
  double? tax;
  double? taxCurrancy;
  double? addTax;
  double? addTaxCurrancy;
  String? salesTupeID;
  double? finalTotal;
  double? shippingPrice;
  double? totalOrderBefor;
  int? departmentId;
  double? totalBeforCurrancy;
  String? isResale;
  String? colorID;
  String? dimantionID;
  String? sizeID;
  String? insuranceLimitStart;
  String? expirdate;
  String? systemDescription;
  double? systemCost;
  String? voucher;
  int? systemStore;
  String? visitPriceInInsurance;
  String? serialNumber;
  String? govName;
  String? areaName;
  String? areaID;
  String? customerAccountTelephone2;
  String? receiptAdress;
  String? receiptFooter;
  String? receiptName;
  String? receiptPhone;
  String? logo;
  String? usedFromInsurance;
  String? insuranceLimit;
  String? hasInstallationVisit;
  String? insuranceEndDate;
  double? proDiscount;
  double? proPriceBeforDeiscount;
  double? proDiscountPercent;
  int? supplyOrderMasterID;
  String? insuranceStartDate;
  String? deliveryDate;
  String? endVisitsDate;
  String? isGenerated;
  String? colorName;
  String? sizeName;
  String? nonActiveSystem;
  int? typeAutoNumber;
  String? pPIName;
  int? pPIID;
  int? code;
  String? safeAccount;
  String? visitPriceOutInsurance;
  String? transportionPriceInsuranse;
  String? transportionPriceOutInsuranse;
  String? note1;
  String? note2;
  String? note3;
  String? note4;
  String? note5;
  String? note6;
  String? note7;
  String? note8;
  String? note9;
  String? note10;
  bool? willFactor;
  String? productProcessItem;
  String? width;
  String? hight;
  String? length;
  String? density;
  int? costItemId;
  String? isPaid;
  double? totalCost;
  String? note11;
  String? note12;
  String? note13;
  String? note14;
  String? note15;
  String? note16;
  String? note17;
  String? note18;
  String? note19;
  String? note20;
  double? total;
  double? totalafterdetaildiscount;
  double? totalafterdetailTax;
  double? profit;
  String? currentQTY;
  String? engWeight;
  double? guideWeight;
  double? guidePrice;
  double? difQty;
  String? storeName;
  String? allowedDayes;
  String? finePrice;
  String? isService;
  String? minimumMounthly;
  String? forEachDays;
  String? isActive;
  String? daysName;
  String? empRecivePaymentId;
  String? modalityName;
  String? categoryName;
  String? productCategory;
  int? companyID;
  String? companyName;
  String? barcode;
  int? customerCode;
  String? sName;
  bool? isShipable;
  String? note;
  bool? isSystemResale;
  String? suplayOrderPoPaid;
  String? customerSalesManId;
  String? customerSalesName;
  String? hPerm;
  String? installSetupId;
  int? iSMonth;
  String? iSStartDate;
  String? iSNumber;
  String? discountPercent;
  String? isCanceled;
  double? taxDetailPercent;
  double? taxDetailValue;
  double? discountDetailPercent;
  double? discountDetailValue;
  String? groupProductKey;
  double? taxDetailTotal;
  double? discountDetailTotal;
  String? lastDate;
  String? lastPrice;
  String? bonus;
  double? itemDiscount;
  double? netItemPrice;
  int? codeiD;
  String? place;
  String? paymentType;
  double? unitPriceAfterTax;
  String? supplierName;
  int? contractBillId;
  bool? isBreakAllowance;
  String? glassType;
  String? purchCode;
  int? supplyerOrderId;
  double? noSalesTax;
  int? contractProjectID;
  int? detailProjectID;
  int? supplyOrderDetailID;

  DynamicList(
      {this.eDMXID,
      this.isSurgery,
      this.isSales,
      this.supplierID,
      this.proccessNumber,
      this.systemID,
      this.costCenterID,
      this.proName,
      this.productID,
      this.unitePrice,
      this.proID,
      this.empPerm,
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
      this.farmingSupplyMasterId,
      this.contractAmountWoTax,
      this.contractType,
      this.customerID,
      this.contractEnddate,
      this.istender,
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
      this.unRelaied,
      this.totalOrder,
      this.totalCurrancy,
      this.discountCurrancy,
      this.pOPaidCurrancy,
      this.comID,
      this.cost,
      this.qty,
      this.unitID,
      this.uName,
      this.priceCurrancy,
      this.batchNumber,
      this.salesMan,
      this.secQuntity,
      this.secUnit,
      this.employeeNameA,
      this.customerAccountName,
      this.customerAccountMobile1,
      this.categoryID,
      this.customerAccountAddress,
      this.gov,
      this.cardName,
      this.cName,
      this.tax,
      this.taxCurrancy,
      this.addTax,
      this.addTaxCurrancy,
      this.salesTupeID,
      this.finalTotal,
      this.shippingPrice,
      this.totalOrderBefor,
      this.departmentId,
      this.totalBeforCurrancy,
      this.isResale,
      this.colorID,
      this.dimantionID,
      this.sizeID,
      this.insuranceLimitStart,
      this.expirdate,
      this.systemDescription,
      this.systemCost,
      this.voucher,
      this.systemStore,
      this.visitPriceInInsurance,
      this.serialNumber,
      this.govName,
      this.areaName,
      this.areaID,
      this.customerAccountTelephone2,
      this.receiptAdress,
      this.receiptFooter,
      this.receiptName,
      this.receiptPhone,
      this.logo,
      this.usedFromInsurance,
      this.insuranceLimit,
      this.hasInstallationVisit,
      this.insuranceEndDate,
      this.proDiscount,
      this.proPriceBeforDeiscount,
      this.proDiscountPercent,
      this.supplyOrderMasterID,
      this.insuranceStartDate,
      this.deliveryDate,
      this.endVisitsDate,
      this.isGenerated,
      this.colorName,
      this.sizeName,
      this.nonActiveSystem,
      this.typeAutoNumber,
      this.pPIName,
      this.pPIID,
      this.code,
      this.safeAccount,
      this.visitPriceOutInsurance,
      this.transportionPriceInsuranse,
      this.transportionPriceOutInsuranse,
      this.note1,
      this.note2,
      this.note3,
      this.note4,
      this.note5,
      this.note6,
      this.note7,
      this.note8,
      this.note9,
      this.note10,
      this.willFactor,
      this.productProcessItem,
      this.width,
      this.hight,
      this.length,
      this.density,
      this.costItemId,
      this.isPaid,
      this.totalCost,
      this.note11,
      this.note12,
      this.note13,
      this.note14,
      this.note15,
      this.note16,
      this.note17,
      this.note18,
      this.note19,
      this.note20,
      this.total,
      this.totalafterdetaildiscount,
      this.totalafterdetailTax,
      this.profit,
      this.currentQTY,
      this.engWeight,
      this.guideWeight,
      this.guidePrice,
      this.difQty,
      this.storeName,
      this.allowedDayes,
      this.finePrice,
      this.isService,
      this.minimumMounthly,
      this.forEachDays,
      this.isActive,
      this.daysName,
      this.empRecivePaymentId,
      this.modalityName,
      this.categoryName,
      this.productCategory,
      this.companyID,
      this.companyName,
      this.barcode,
      this.customerCode,
      this.sName,
      this.isShipable,
      this.note,
      this.isSystemResale,
      this.suplayOrderPoPaid,
      this.customerSalesManId,
      this.customerSalesName,
      this.hPerm,
      this.installSetupId,
      this.iSMonth,
      this.iSStartDate,
      this.iSNumber,
      this.discountPercent,
      this.isCanceled,
      this.taxDetailPercent,
      this.taxDetailValue,
      this.discountDetailPercent,
      this.discountDetailValue,
      this.groupProductKey,
      this.taxDetailTotal,
      this.discountDetailTotal,
      this.lastDate,
      this.lastPrice,
      this.bonus,
      this.itemDiscount,
      this.netItemPrice,
      this.codeiD,
      this.place,
      this.paymentType,
      this.unitPriceAfterTax,
      this.supplierName,
      this.contractBillId,
      this.isBreakAllowance,
      this.glassType,
      this.purchCode,
      this.supplyerOrderId,
      this.noSalesTax,
      this.contractProjectID,
      this.detailProjectID,
      this.supplyOrderDetailID});

  DynamicList.fromJson(Map<String, dynamic> json) {
    eDMXID = json['EDMXID'];
    isSurgery = json['IsSurgery'];
    isSales = json['IsSales'];
    supplierID = json['SupplierID'];
    proccessNumber = json['ProccessNumber'];
    systemID = json['SystemID'];
    costCenterID = json['CostCenterID'];
    proName = json['ProName'];
    productID = json['ProductID'];
    unitePrice = json['UnitePrice'];
    proID = json['ProID'];
    empPerm = json['empPerm'];
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
    farmingSupplyMasterId = json['FarmingSupplyMasterId'];
    contractAmountWoTax = json['ContractAmountWoTax'];
    contractType = json['ContractType'];
    customerID = json['CustomerID'];
    contractEnddate = json['ContractEnddate'];
    istender = json['Istender'];
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
    unRelaied = json['UnRelaied'];
    totalOrder = json['TotalOrder'];
    totalCurrancy = json['TotalCurrancy'];
    discountCurrancy = json['DiscountCurrancy'];
    pOPaidCurrancy = json['POPaidCurrancy'];
    comID = json['ComID'];
    cost = json['Cost'];
    qty = json['Qty'];
    unitID = json['UnitID'];
    uName = json['UName'];
    priceCurrancy = json['PriceCurrancy'];
    batchNumber = json['BatchNumber'];
    salesMan = json['SalesMan'];
    secQuntity = json['SecQuntity'];
    secUnit = json['SecUnit'];
    employeeNameA = json['EmployeeNameA'];
    customerAccountName = json['CustomerAccountName'];
    customerAccountMobile1 = json['CustomerAccountMobile1'];
    categoryID = json['CategoryID'];
    customerAccountAddress = json['CustomerAccountAddress'];
    gov = json['Gov'];
    cardName = json['CardName'];
    cName = json['CName'];
    tax = json['Tax'];
    taxCurrancy = json['TaxCurrancy'];
    addTax = json['AddTax'];
    addTaxCurrancy = json['AddTaxCurrancy'];
    salesTupeID = json['SalesTupeID'];
    finalTotal = json['finalTotal'];
    shippingPrice = json['shippingPrice'];
    totalOrderBefor = json['TotalOrderBefor'];
    departmentId = json['DepartmentId'];
    totalBeforCurrancy = json['TotalBeforCurrancy'];
    isResale = json['IsResale'];
    colorID = json['ColorID'];
    dimantionID = json['DimantionID'];
    sizeID = json['SizeID'];
    insuranceLimitStart = json['InsuranceLimitStart'];
    expirdate = json['Expirdate'];
    systemDescription = json['systemDescription'];
    systemCost = json['systemCost'];
    voucher = json['Voucher'];
    systemStore = json['SystemStore'];
    visitPriceInInsurance = json['VisitPriceInInsurance'];
    serialNumber = json['SerialNumber'];
    govName = json['GovName'];
    areaName = json['AreaName'];
    areaID = json['AreaID'];
    customerAccountTelephone2 = json['CustomerAccountTelephone2'];
    receiptAdress = json['ReceiptAdress'];
    receiptFooter = json['ReceiptFooter'];
    receiptName = json['ReceiptName'];
    receiptPhone = json['ReceiptPhone'];
    logo = json['Logo'];
    usedFromInsurance = json['UsedFromInsurance'];
    insuranceLimit = json['InsuranceLimit'];
    hasInstallationVisit = json['HasInstallationVisit'];
    insuranceEndDate = json['InsuranceEndDate'];
    proDiscount = json['ProDiscount'];
    proPriceBeforDeiscount = json['ProPriceBeforDeiscount'];
    proDiscountPercent = json['ProDiscountPercent'];
    supplyOrderMasterID = json['SupplyOrderMasterID'];
    insuranceStartDate = json['InsuranceStartDate'];
    deliveryDate = json['DeliveryDate'];
    endVisitsDate = json['EndVisitsDate'];
    isGenerated = json['IsGenerated'];
    colorName = json['ColorName'];
    sizeName = json['SizeName'];
    nonActiveSystem = json['NonActiveSystem'];
    typeAutoNumber = json['TypeAutoNumber'];
    pPIName = json['PPIName'];
    pPIID = json['PPIID'];
    code = json['Code'];
    safeAccount = json['SafeAccount'];
    visitPriceOutInsurance = json['VisitPriceOutInsurance'];
    transportionPriceInsuranse = json['TransportionPriceInsuranse'];
    transportionPriceOutInsuranse = json['TransportionPriceOutInsuranse'];
    note1 = json['Note1'];
    note2 = json['Note2'];
    note3 = json['Note3'];
    note4 = json['Note4'];
    note5 = json['Note5'];
    note6 = json['Note6'];
    note7 = json['Note7'];
    note8 = json['Note8'];
    note9 = json['Note9'];
    note10 = json['Note10'];
    willFactor = json['WillFactor'];
    productProcessItem = json['ProductProcessItem'];
    width = json['Width'];
    hight = json['Hight'];
    length = json['length'];
    density = json['Density'];
    costItemId = json['CostItemId'];
    isPaid = json['IsPaid'];
    totalCost = json['TotalCost'];
    note11 = json['Note11'];
    note12 = json['Note12'];
    note13 = json['Note13'];
    note14 = json['Note14'];
    note15 = json['Note15'];
    note16 = json['Note16'];
    note17 = json['Note17'];
    note18 = json['Note18'];
    note19 = json['Note19'];
    note20 = json['Note20'];
    total = json['Total'];
    totalafterdetaildiscount = json['Totalafterdetaildiscount'];
    totalafterdetailTax = json['TotalafterdetailTax'];
    profit = json['Profit'];
    currentQTY = json['CurrentQTY'];
    engWeight = json['EngWeight'];
    guideWeight = json['GuideWeight'];
    guidePrice = json['GuidePrice'];
    difQty = json['DifQty'];
    storeName = json['StoreName'];
    allowedDayes = json['AllowedDayes'];
    finePrice = json['finePrice'];
    isService = json['IsService'];
    minimumMounthly = json['MinimumMounthly'];
    forEachDays = json['ForEachDays'];
    isActive = json['IsActive'];
    daysName = json['DaysName'];
    empRecivePaymentId = json['EmpRecivePaymentId'];
    modalityName = json['ModalityName'];
    categoryName = json['CategoryName'];
    productCategory = json['ProductCategory'];
    companyID = json['CompanyID'];
    companyName = json['CompanyName'];
    barcode = json['Barcode'];
    customerCode = json['CustomerCode'];
    sName = json['SName'];
    isShipable = json['IsShipable'];
    note = json['Note'];
    isSystemResale = json['IsSystemResale'];
    suplayOrderPoPaid = json['SuplayOrderPoPaid'];
    customerSalesManId = json['CustomerSalesManId'];
    customerSalesName = json['CustomerSalesName'];
    hPerm = json['HPerm'];
    installSetupId = json['InstallSetupId'];
    iSMonth = json['ISMonth'];
    iSStartDate = json['ISStartDate'];
    iSNumber = json['ISNumber'];
    discountPercent = json['DiscountPercent'];
    isCanceled = json['IsCanceled'];
    taxDetailPercent = json['TaxDetailPercent'];
    taxDetailValue = json['TaxDetailValue'];
    discountDetailPercent = json['DiscountDetailPercent'];
    discountDetailValue = json['DiscountDetailValue'];
    groupProductKey = json['GroupProductKey'];
    taxDetailTotal = json['TaxDetailTotal'];
    discountDetailTotal = json['DiscountDetailTotal'];
    lastDate = json['lastDate'];
    lastPrice = json['lastPrice'];
    bonus = json['bonus'];
    itemDiscount = json['ItemDiscount'];
    netItemPrice = json['NetItemPrice'];
    codeiD = json['CodeiD'];
    place = json['Place'];
    paymentType = json['PaymentType'];
    unitPriceAfterTax = json['UnitPriceAfterTax'];
    supplierName = json['SupplierName'];
    contractBillId = json['contractBillId'];
    isBreakAllowance = json['IsBreakAllowance'];
    glassType = json['GlassType'];
    purchCode = json['PurchCode'];
    supplyerOrderId = json['supplyerOrderId'];
    noSalesTax = json['NoSalesTax'];
    contractProjectID = json['ContractProjectID'];
    detailProjectID = json['DetailProjectID'];
    supplyOrderDetailID = json['SupplyOrderDetailID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EDMXID'] = eDMXID;
    data['IsSurgery'] = isSurgery;
    data['IsSales'] = isSales;
    data['SupplierID'] = supplierID;
    data['ProccessNumber'] = proccessNumber;
    data['SystemID'] = systemID;
    data['CostCenterID'] = costCenterID;
    data['ProName'] = proName;
    data['ProductID'] = productID;
    data['UnitePrice'] = unitePrice;
    data['ProID'] = proID;
    data['empPerm'] = empPerm;
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
    data['FarmingSupplyMasterId'] = farmingSupplyMasterId;
    data['ContractAmountWoTax'] = contractAmountWoTax;
    data['ContractType'] = contractType;
    data['CustomerID'] = customerID;
    data['ContractEnddate'] = contractEnddate;
    data['Istender'] = istender;
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
    data['UnRelaied'] = unRelaied;
    data['TotalOrder'] = totalOrder;
    data['TotalCurrancy'] = totalCurrancy;
    data['DiscountCurrancy'] = discountCurrancy;
    data['POPaidCurrancy'] = pOPaidCurrancy;
    data['ComID'] = comID;
    data['Cost'] = cost;
    data['Qty'] = qty;
    data['UnitID'] = unitID;
    data['UName'] = uName;
    data['PriceCurrancy'] = priceCurrancy;
    data['BatchNumber'] = batchNumber;
    data['SalesMan'] = salesMan;
    data['SecQuntity'] = secQuntity;
    data['SecUnit'] = secUnit;
    data['EmployeeNameA'] = employeeNameA;
    data['CustomerAccountName'] = customerAccountName;
    data['CustomerAccountMobile1'] = customerAccountMobile1;
    data['CategoryID'] = categoryID;
    data['CustomerAccountAddress'] = customerAccountAddress;
    data['Gov'] = gov;
    data['CardName'] = cardName;
    data['CName'] = cName;
    data['Tax'] = tax;
    data['TaxCurrancy'] = taxCurrancy;
    data['AddTax'] = addTax;
    data['AddTaxCurrancy'] = addTaxCurrancy;
    data['SalesTupeID'] = salesTupeID;
    data['finalTotal'] = finalTotal;
    data['shippingPrice'] = shippingPrice;
    data['TotalOrderBefor'] = totalOrderBefor;
    data['DepartmentId'] = departmentId;
    data['TotalBeforCurrancy'] = totalBeforCurrancy;
    data['IsResale'] = isResale;
    data['ColorID'] = colorID;
    data['DimantionID'] = dimantionID;
    data['SizeID'] = sizeID;
    data['InsuranceLimitStart'] = insuranceLimitStart;
    data['Expirdate'] = expirdate;
    data['systemDescription'] = systemDescription;
    data['systemCost'] = systemCost;
    data['Voucher'] = voucher;
    data['SystemStore'] = systemStore;
    data['VisitPriceInInsurance'] = visitPriceInInsurance;
    data['SerialNumber'] = serialNumber;
    data['GovName'] = govName;
    data['AreaName'] = areaName;
    data['AreaID'] = areaID;
    data['CustomerAccountTelephone2'] = customerAccountTelephone2;
    data['ReceiptAdress'] = receiptAdress;
    data['ReceiptFooter'] = receiptFooter;
    data['ReceiptName'] = receiptName;
    data['ReceiptPhone'] = receiptPhone;
    data['Logo'] = logo;
    data['UsedFromInsurance'] = usedFromInsurance;
    data['InsuranceLimit'] = insuranceLimit;
    data['HasInstallationVisit'] = hasInstallationVisit;
    data['InsuranceEndDate'] = insuranceEndDate;
    data['ProDiscount'] = proDiscount;
    data['ProPriceBeforDeiscount'] = proPriceBeforDeiscount;
    data['ProDiscountPercent'] = proDiscountPercent;
    data['SupplyOrderMasterID'] = supplyOrderMasterID;
    data['InsuranceStartDate'] = insuranceStartDate;
    data['DeliveryDate'] = deliveryDate;
    data['EndVisitsDate'] = endVisitsDate;
    data['IsGenerated'] = isGenerated;
    data['ColorName'] = colorName;
    data['SizeName'] = sizeName;
    data['NonActiveSystem'] = nonActiveSystem;
    data['TypeAutoNumber'] = typeAutoNumber;
    data['PPIName'] = pPIName;
    data['PPIID'] = pPIID;
    data['Code'] = code;
    data['SafeAccount'] = safeAccount;
    data['VisitPriceOutInsurance'] = visitPriceOutInsurance;
    data['TransportionPriceInsuranse'] = transportionPriceInsuranse;
    data['TransportionPriceOutInsuranse'] = transportionPriceOutInsuranse;
    data['Note1'] = note1;
    data['Note2'] = note2;
    data['Note3'] = note3;
    data['Note4'] = note4;
    data['Note5'] = note5;
    data['Note6'] = note6;
    data['Note7'] = note7;
    data['Note8'] = note8;
    data['Note9'] = note9;
    data['Note10'] = note10;
    data['WillFactor'] = willFactor;
    data['ProductProcessItem'] = productProcessItem;
    data['Width'] = width;
    data['Hight'] = hight;
    data['length'] = length;
    data['Density'] = density;
    data['CostItemId'] = costItemId;
    data['IsPaid'] = isPaid;
    data['TotalCost'] = totalCost;
    data['Note11'] = note11;
    data['Note12'] = note12;
    data['Note13'] = note13;
    data['Note14'] = note14;
    data['Note15'] = note15;
    data['Note16'] = note16;
    data['Note17'] = note17;
    data['Note18'] = note18;
    data['Note19'] = note19;
    data['Note20'] = note20;
    data['Total'] = total;
    data['Totalafterdetaildiscount'] = totalafterdetaildiscount;
    data['TotalafterdetailTax'] = totalafterdetailTax;
    data['Profit'] = profit;
    data['CurrentQTY'] = currentQTY;
    data['EngWeight'] = engWeight;
    data['GuideWeight'] = guideWeight;
    data['GuidePrice'] = guidePrice;
    data['DifQty'] = difQty;
    data['StoreName'] = storeName;
    data['AllowedDayes'] = allowedDayes;
    data['finePrice'] = finePrice;
    data['IsService'] = isService;
    data['MinimumMounthly'] = minimumMounthly;
    data['ForEachDays'] = forEachDays;
    data['IsActive'] = isActive;
    data['DaysName'] = daysName;
    data['EmpRecivePaymentId'] = empRecivePaymentId;
    data['ModalityName'] = modalityName;
    data['CategoryName'] = categoryName;
    data['ProductCategory'] = productCategory;
    data['CompanyID'] = companyID;
    data['CompanyName'] = companyName;
    data['Barcode'] = barcode;
    data['CustomerCode'] = customerCode;
    data['SName'] = sName;
    data['IsShipable'] = isShipable;
    data['Note'] = note;
    data['IsSystemResale'] = isSystemResale;
    data['SuplayOrderPoPaid'] = suplayOrderPoPaid;
    data['CustomerSalesManId'] = customerSalesManId;
    data['CustomerSalesName'] = customerSalesName;
    data['HPerm'] = hPerm;
    data['InstallSetupId'] = installSetupId;
    data['ISMonth'] = iSMonth;
    data['ISStartDate'] = iSStartDate;
    data['ISNumber'] = iSNumber;
    data['DiscountPercent'] = discountPercent;
    data['IsCanceled'] = isCanceled;
    data['TaxDetailPercent'] = taxDetailPercent;
    data['TaxDetailValue'] = taxDetailValue;
    data['DiscountDetailPercent'] = discountDetailPercent;
    data['DiscountDetailValue'] = discountDetailValue;
    data['GroupProductKey'] = groupProductKey;
    data['TaxDetailTotal'] = taxDetailTotal;
    data['DiscountDetailTotal'] = discountDetailTotal;
    data['lastDate'] = lastDate;
    data['lastPrice'] = lastPrice;
    data['bonus'] = bonus;
    data['ItemDiscount'] = itemDiscount;
    data['NetItemPrice'] = netItemPrice;
    data['CodeiD'] = codeiD;
    data['Place'] = place;
    data['PaymentType'] = paymentType;
    data['UnitPriceAfterTax'] = unitPriceAfterTax;
    data['SupplierName'] = supplierName;
    data['contractBillId'] = contractBillId;
    data['IsBreakAllowance'] = isBreakAllowance;
    data['GlassType'] = glassType;
    data['PurchCode'] = purchCode;
    data['supplyerOrderId'] = supplyerOrderId;
    data['NoSalesTax'] = noSalesTax;
    data['ContractProjectID'] = contractProjectID;
    data['DetailProjectID'] = detailProjectID;
    data['SupplyOrderDetailID'] = supplyOrderDetailID;
    return data;
  }
}
