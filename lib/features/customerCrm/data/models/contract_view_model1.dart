class ContractViewModel1 {
  List<ContractItem>? dynamicList;
  int? numberofrecords;

  ContractViewModel1({this.dynamicList, this.numberofrecords});

  ContractViewModel1.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <ContractItem>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(ContractItem.fromJson(v));
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

class ContractItem {
  int? eInvoiceSubmissionId;
  int? eInvoiceUuid;
  String? eInvoiceLongId;
  String? cardID;
  int? contractID;
  String? contractDate;
  bool? unRelaied;
  String? contractAmountwTax;
  String? contractNote;
  String? contractAmountWoTax;
  int? contractType;
  int? customerID;
  String? contractEnddate;
  bool? istender;
  String? note2;
  String? setupDate;
  String? setupNote;
  String? customerAccountName;
  String? gov;
  String? customerAccountAddress;
  String? customerAccountCity;
  int? categoryID;
  String? customerAccountMobile1;
  String? religion;
  String? phone2;
  String? phone3;
  String? phone4;
  String? customerAccountTelephone2;
  String? customerAccountEmail;
  String? isContracted;
  int? candidateID;
  int? codeiD;
  String? govName;
  String? areaName;
  String? typeName;
  int? customerAccount;
  int? monyAccount;
  String? productAccount;
  int? salesAccount;
  String? department;
  String? isInstall;
  String? iSCancel;
  int? printID;
  String? supplierMony;
  String? modifyAt;
  String? createAt;
  String? modifyBy;
  String? createBy;
  int? storeID;
  int? autoNumber;
  double? discount;
  int? currancyID;
  String? currancyEX;
  String? ordernumber;
  double? pOPaid;
  double? totalOrder;
  double? totalCurrancy;
  double? discountCurrancy;
  String? pOPaidCurrancy;
  int? salesMan;
  String? salesManName;
  int? comID;
  double? tax;
  double? taxCurrancy;
  double? addTaxCurrancy;
  double? addTax;
  String? totalOrderBefor;
  String? totalBeforCurrancy;
  String? conName;
  String? isResale;
  String? isRecived;
  String? salesTupeID;
  double? shippingPrice;
  double? contractQuantity;
  int? empPointOfSaleID;
  String? voucher;
  String? fullDesciption;
  String? fullDesciption2;
  String? isVisitCall;
  double? finaltotal;
  String? isPaid;
  String? supplyOrderMasterID;
  int? typeAutoNumber;
  String? note1;
  String? safeAccount;
  String? isService;
  String? paymentMethod;
  int? costItemId;
  String? note3;
  String? note4;
  String? note5;
  String? note6;
  String? note7;
  String? note8;
  String? note9;
  String? note10;
  int? code;
  String? salerImage;
  String? rout;
  int? departmentId;
  String? sTName;
  String? sName;
  double? remind;
  String? customerSalsMan;
  String? sOMName;
  double? totalAfterDiscount;
  String? suppPOPaid;
  String? note13;
  String? isCanceled;
  String? note14;
  double? taxDetailTotal;
  double? discountDetailTotal;
  String? unElectronicInvoice;
  String? note11;
  String? note12;
  String? note15;
  String? note16;
  String? note17;
  String? note18;
  String? note19;
  String? note20;
  double? finalValue;
  String? empIndexString;
  String? customerSalesManID;
  String? isEInvoiceCanceled;
  String? eInvoiceCanceledDate;
  String? decimalOrderNumber;
  int? contractProjectID;

  ContractItem(
      {this.eInvoiceSubmissionId,
      this.eInvoiceUuid,
      this.eInvoiceLongId,
      this.cardID,
      this.contractID,
      this.contractDate,
      this.unRelaied,
      this.contractAmountwTax,
      this.contractNote,
      this.contractAmountWoTax,
      this.contractType,
      this.customerID,
      this.contractEnddate,
      this.istender,
      this.note2,
      this.setupDate,
      this.setupNote,
      this.customerAccountName,
      this.gov,
      this.customerAccountAddress,
      this.customerAccountCity,
      this.categoryID,
      this.customerAccountMobile1,
      this.religion,
      this.phone2,
      this.phone3,
      this.phone4,
      this.customerAccountTelephone2,
      this.customerAccountEmail,
      this.isContracted,
      this.candidateID,
      this.codeiD,
      this.govName,
      this.areaName,
      this.typeName,
      this.customerAccount,
      this.monyAccount,
      this.productAccount,
      this.salesAccount,
      this.department,
      this.isInstall,
      this.iSCancel,
      this.printID,
      this.supplierMony,
      this.modifyAt,
      this.createAt,
      this.modifyBy,
      this.createBy,
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
      this.salesMan,
      this.salesManName,
      this.comID,
      this.tax,
      this.taxCurrancy,
      this.addTaxCurrancy,
      this.addTax,
      this.totalOrderBefor,
      this.totalBeforCurrancy,
      this.conName,
      this.isResale,
      this.isRecived,
      this.salesTupeID,
      this.shippingPrice,
      this.contractQuantity,
      this.empPointOfSaleID,
      this.voucher,
      this.fullDesciption,
      this.fullDesciption2,
      this.isVisitCall,
      this.finaltotal,
      this.isPaid,
      this.supplyOrderMasterID,
      this.typeAutoNumber,
      this.note1,
      this.safeAccount,
      this.isService,
      this.paymentMethod,
      this.costItemId,
      this.note3,
      this.note4,
      this.note5,
      this.note6,
      this.note7,
      this.note8,
      this.note9,
      this.note10,
      this.code,
      this.salerImage,
      this.rout,
      this.departmentId,
      this.sTName,
      this.sName,
      this.remind,
      this.customerSalsMan,
      this.sOMName,
      this.totalAfterDiscount,
      this.suppPOPaid,
      this.note13,
      this.isCanceled,
      this.note14,
      this.taxDetailTotal,
      this.discountDetailTotal,
      this.unElectronicInvoice,
      this.note11,
      this.note12,
      this.note15,
      this.note16,
      this.note17,
      this.note18,
      this.note19,
      this.note20,
      this.finalValue,
      this.empIndexString,
      this.customerSalesManID,
      this.isEInvoiceCanceled,
      this.eInvoiceCanceledDate,
      this.decimalOrderNumber,
      this.contractProjectID});

  ContractItem.fromJson(Map<String, dynamic> json) {
    eInvoiceSubmissionId = json['EInvoiceSubmissionId'];
    eInvoiceUuid = json['EInvoiceUuid'];
    eInvoiceLongId = json['EInvoiceLongId'];
    cardID = json['CardID'];
    contractID = json['ContractID'];
    contractDate = json['ContractDate'];
    unRelaied = json['UnRelaied'];
    contractAmountwTax = json['ContractAmountwTax'];
    contractNote = json['ContractNote'];
    contractAmountWoTax = json['ContractAmountWoTax'];
    contractType = json['ContractType'];
    customerID = json['CustomerID'];
    contractEnddate = json['ContractEnddate'];
    istender = json['Istender'];
    note2 = json['Note2'];
    setupDate = json['SetupDate'];
    setupNote = json['SetupNote'];
    customerAccountName = json['CustomerAccountName'];
    gov = json['Gov'];
    customerAccountAddress = json['CustomerAccountAddress'];
    customerAccountCity = json['CustomerAccountCity'];
    categoryID = json['CategoryID'];
    customerAccountMobile1 = json['CustomerAccountMobile1'];
    religion = json['religion'];
    phone2 = json['Phone2'];
    phone3 = json['Phone3'];
    phone4 = json['Phone4'];
    customerAccountTelephone2 = json['CustomerAccountTelephone2'];
    customerAccountEmail = json['CustomerAccountEmail'];
    isContracted = json['isContracted'];
    candidateID = json['CandidateID'];
    codeiD = json['CodeiD'];
    govName = json['GovName'];
    areaName = json['AreaName'];
    typeName = json['TypeName'];
    customerAccount = json['CustomerAccount'];
    monyAccount = json['MonyAccount'];
    productAccount = json['ProductAccount'];
    salesAccount = json['SalesAccount'];
    department = json['Department'];
    isInstall = json['IsInstall'];
    iSCancel = json['ISCancel'];
    printID = json['PrintID'];
    supplierMony = json['SupplierMony'];
    modifyAt = json['ModifyAt'];
    createAt = json['CreateAt'];
    modifyBy = json['ModifyBy'];
    createBy = json['CreateBy'];
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
    salesMan = json['SalesMan'];
    salesManName = json['SalesManName'];
    comID = json['ComID'];
    tax = json['Tax'];
    taxCurrancy = json['TaxCurrancy'];
    addTaxCurrancy = json['AddTaxCurrancy'];
    addTax = json['AddTax'];
    totalOrderBefor = json['TotalOrderBefor'];
    totalBeforCurrancy = json['TotalBeforCurrancy'];
    conName = json['ConName'];
    isResale = json['IsResale'];
    isRecived = json['IsRecived'];
    salesTupeID = json['SalesTupeID'];
    shippingPrice = json['shippingPrice'];
    contractQuantity = json['ContractQuantity'];
    empPointOfSaleID = json['EmpPointOfSaleID'];
    voucher = json['Voucher'];
    fullDesciption = json['FullDesciption'];
    fullDesciption2 = json['FullDesciption2'];
    isVisitCall = json['IsVisitCall'];
    finaltotal = json['finaltotal'];
    isPaid = json['IsPaid'];
    supplyOrderMasterID = json['SupplyOrderMasterID'];
    typeAutoNumber = json['TypeAutoNumber'];
    note1 = json['Note1'];
    safeAccount = json['SafeAccount'];
    isService = json['IsService'];
    paymentMethod = json['PaymentMethod'];
    costItemId = json['CostItemId'];
    note3 = json['Note3'];
    note4 = json['Note4'];
    note5 = json['Note5'];
    note6 = json['Note6'];
    note7 = json['Note7'];
    note8 = json['Note8'];
    note9 = json['Note9'];
    note10 = json['Note10'];
    code = json['Code'];
    salerImage = json['SalerImage'];
    rout = json['Rout'];
    departmentId = json['DepartmentId'];
    sTName = json['STName'];
    sName = json['SName'];
    remind = json['remind'];
    customerSalsMan = json['CustomerSalsMan'];
    sOMName = json['SOMName'];
    totalAfterDiscount = json['TotalAfterDiscount'];
    suppPOPaid = json['SuppPOPaid'];
    note13 = json['Note13'];
    isCanceled = json['IsCanceled'];
    note14 = json['Note14'];
    taxDetailTotal = json['TaxDetailTotal'];
    discountDetailTotal = json['DiscountDetailTotal'];
    unElectronicInvoice = json['UnElectronicInvoice'];
    note11 = json['Note11'];
    note12 = json['Note12'];
    note15 = json['Note15'];
    note16 = json['Note16'];
    note17 = json['Note17'];
    note18 = json['Note18'];
    note19 = json['Note19'];
    note20 = json['Note20'];
    finalValue = json['finalValue'];
    empIndexString = json['EmpIndexString'];
    customerSalesManID = json['CustomerSalesManID'];
    isEInvoiceCanceled = json['IsEInvoiceCanceled'];
    eInvoiceCanceledDate = json['EInvoiceCanceledDate'];
    decimalOrderNumber = json['decimalOrderNumber'];
    contractProjectID = json['ContractProjectID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EInvoiceSubmissionId'] = eInvoiceSubmissionId;
    data['EInvoiceUuid'] = eInvoiceUuid;
    data['EInvoiceLongId'] = eInvoiceLongId;
    data['CardID'] = cardID;
    data['ContractID'] = contractID;
    data['ContractDate'] = contractDate;
    data['UnRelaied'] = unRelaied;
    data['ContractAmountwTax'] = contractAmountwTax;
    data['ContractNote'] = contractNote;
    data['ContractAmountWoTax'] = contractAmountWoTax;
    data['ContractType'] = contractType;
    data['CustomerID'] = customerID;
    data['ContractEnddate'] = contractEnddate;
    data['Istender'] = istender;
    data['Note2'] = note2;
    data['SetupDate'] = setupDate;
    data['SetupNote'] = setupNote;
    data['CustomerAccountName'] = customerAccountName;
    data['Gov'] = gov;
    data['CustomerAccountAddress'] = customerAccountAddress;
    data['CustomerAccountCity'] = customerAccountCity;
    data['CategoryID'] = categoryID;
    data['CustomerAccountMobile1'] = customerAccountMobile1;
    data['religion'] = religion;
    data['Phone2'] = phone2;
    data['Phone3'] = phone3;
    data['Phone4'] = phone4;
    data['CustomerAccountTelephone2'] = customerAccountTelephone2;
    data['CustomerAccountEmail'] = customerAccountEmail;
    data['isContracted'] = isContracted;
    data['CandidateID'] = candidateID;
    data['CodeiD'] = codeiD;
    data['GovName'] = govName;
    data['AreaName'] = areaName;
    data['TypeName'] = typeName;
    data['CustomerAccount'] = customerAccount;
    data['MonyAccount'] = monyAccount;
    data['ProductAccount'] = productAccount;
    data['SalesAccount'] = salesAccount;
    data['Department'] = department;
    data['IsInstall'] = isInstall;
    data['ISCancel'] = iSCancel;
    data['PrintID'] = printID;
    data['SupplierMony'] = supplierMony;
    data['ModifyAt'] = modifyAt;
    data['CreateAt'] = createAt;
    data['ModifyBy'] = modifyBy;
    data['CreateBy'] = createBy;
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
    data['SalesMan'] = salesMan;
    data['SalesManName'] = salesManName;
    data['ComID'] = comID;
    data['Tax'] = tax;
    data['TaxCurrancy'] = taxCurrancy;
    data['AddTaxCurrancy'] = addTaxCurrancy;
    data['AddTax'] = addTax;
    data['TotalOrderBefor'] = totalOrderBefor;
    data['TotalBeforCurrancy'] = totalBeforCurrancy;
    data['ConName'] = conName;
    data['IsResale'] = isResale;
    data['IsRecived'] = isRecived;
    data['SalesTupeID'] = salesTupeID;
    data['shippingPrice'] = shippingPrice;
    data['ContractQuantity'] = contractQuantity;
    data['EmpPointOfSaleID'] = empPointOfSaleID;
    data['Voucher'] = voucher;
    data['FullDesciption'] = fullDesciption;
    data['FullDesciption2'] = fullDesciption2;
    data['IsVisitCall'] = isVisitCall;
    data['finaltotal'] = finaltotal;
    data['IsPaid'] = isPaid;
    data['SupplyOrderMasterID'] = supplyOrderMasterID;
    data['TypeAutoNumber'] = typeAutoNumber;
    data['Note1'] = note1;
    data['SafeAccount'] = safeAccount;
    data['IsService'] = isService;
    data['PaymentMethod'] = paymentMethod;
    data['CostItemId'] = costItemId;
    data['Note3'] = note3;
    data['Note4'] = note4;
    data['Note5'] = note5;
    data['Note6'] = note6;
    data['Note7'] = note7;
    data['Note8'] = note8;
    data['Note9'] = note9;
    data['Note10'] = note10;
    data['Code'] = code;
    data['SalerImage'] = salerImage;
    data['Rout'] = rout;
    data['DepartmentId'] = departmentId;
    data['STName'] = sTName;
    data['SName'] = sName;
    data['remind'] = remind;
    data['CustomerSalsMan'] = customerSalsMan;
    data['SOMName'] = sOMName;
    data['TotalAfterDiscount'] = totalAfterDiscount;
    data['SuppPOPaid'] = suppPOPaid;
    data['Note13'] = note13;
    data['IsCanceled'] = isCanceled;
    data['Note14'] = note14;
    data['TaxDetailTotal'] = taxDetailTotal;
    data['DiscountDetailTotal'] = discountDetailTotal;
    data['UnElectronicInvoice'] = unElectronicInvoice;
    data['Note11'] = note11;
    data['Note12'] = note12;
    data['Note15'] = note15;
    data['Note16'] = note16;
    data['Note17'] = note17;
    data['Note18'] = note18;
    data['Note19'] = note19;
    data['Note20'] = note20;
    data['finalValue'] = finalValue;
    data['EmpIndexString'] = empIndexString;
    data['CustomerSalesManID'] = customerSalesManID;
    data['IsEInvoiceCanceled'] = isEInvoiceCanceled;
    data['EInvoiceCanceledDate'] = eInvoiceCanceledDate;
    data['decimalOrderNumber'] = decimalOrderNumber;
    data['ContractProjectID'] = contractProjectID;
    return data;
  }
}
