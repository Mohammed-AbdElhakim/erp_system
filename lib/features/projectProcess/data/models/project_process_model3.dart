class ProjectProcessModel3 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  ProjectProcessModel3({this.dynamicList, this.numberofrecords});

  ProjectProcessModel3.fromJson(Map<String, dynamic> json) {
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
  int? pRID;
  bool? isDistribQty;
  int? paymentID;
  double? recivemony;
  String? reciveDate;
  String? note;
  String? paymentMethod;
  int? entryDetailID;
  int? checkSetupID;
  String? estPayDate;
  String? masterNote;
  int? checkPartId;
  int? paymentTypeID;
  double? paymentAmount;
  bool? isReceived;
  String? actualPayDate;
  String? paymentNotes;
  int? empID;
  String? recivedMony;
  String? installSetup;
  int? model;
  bool? inOrOut;
  int? expr1;
  int? paperNumber;
  int? paymentAutoNumber;
  int? maintemTreeId;
  int? eDID;
  int? monyAccount;
  double? monyProduct;
  String? monyCostItems;
  double? mony;
  bool? creditORDepit;
  int? eMasterID;
  String? eNote;
  int? customerID;
  int? productID;
  int? expr5;
  String? production;
  int? expr6;
  double? quntity;
  int? itemsTreeId;
  String? storeid;
  double? monyActCurrancy;
  double? currancyEX;
  int? accountID;
  int? contractID;
  String? contractDate;
  String? contractAmountwTax;
  String? contractNote;
  String? contractAmountWoTax;
  String? contractType;
  String? contractEnddate;
  String? istender;
  String? note2;
  String? setupDate;
  String? setupNote;
  String? iSCancel;
  String? isInstall;
  String? printID;
  String? supplierMony;
  int? expr2;
  int? expr3;
  int? expr4;
  int? expr7;
  int? contractTypeID;
  String? typeName;
  String? monthCount;
  String? visitPrice;
  String? firstVisit;
  String? secoundVisit;
  String? theardVisit;
  String? membraneVisit;
  int? comID;
  String? customerAccount;
  int? expr9;
  String? productAccount;
  double? salesAccount;
  String? department;
  String? processExpence;
  int? eMID;
  String? eMDepartment;
  String? eDate;
  int? eCode;
  String? eDescription;
  bool? cosrOrMony;
  int? proccessID;
  String? modifyBy;
  String? modifyAt;
  int? createBy;
  String? createAt;
  int? purchaseID;
  int? productionID;
  bool? unRelaied;
  int? invoiceID;
  int? sourceType;
  int? currancyID;
  double? depit;
  int? costItems;
  double? credit;
  String? paymentAccount;
  String? acName;
  double? recivemonyCurrancy;
  String? cName;
  bool? isDefult;
  String? isDistrib;
  String? sName;
  int? supplierCategoryId1;
  String? customerAccountName;
  int? departmentId;
  int? supplierID;
  String? extractionMasterID;
  String? customerExtractionMasterID;
  String? showPerm;
  String? addPerm;
  String? salesPerm;
  String? outPerm;
  int? employeeAccountID;
  int? paymentTitle;
  String? checkName;
  String? checkNumber;
  String? checkMaturityDate;
  String? checkReciveDate;
  String? checkMainBank;
  String? checkBankLocation;
  int? checkAccountId;
  String? checkExchangeDate;
  String? checkRestPlace;
  bool? isCheckSort;
  bool? isCheck;
  int? chekPaymentId;
  bool? isChechExchanged;
  int? detailContractId;
  int? detailCustomerId;
  int? demandId;
  int? processTypeId;
  String? processNumber;
  int? paymentTargetDetailId;
  int? customerCode;
  double? acIndex;
  String? employeeNameA;
  String? reciveEmp;
  int? shippmentOrderId;
  int? extractionID;
  int? detailPurchaseId;
  String? salesMan;
  String? safeAutoNumber;
  int? acParent;
  double? itemQuantity;
  int? constSupplierMasterId;
  bool? isNoTax;
  int? defultTaxCategoryID;
  int? taxCategoryID;

  DynamicList(
      {this.pRID,
      this.isDistribQty,
      this.paymentID,
      this.recivemony,
      this.reciveDate,
      this.note,
      this.paymentMethod,
      this.entryDetailID,
      this.checkSetupID,
      this.estPayDate,
      this.masterNote,
      this.checkPartId,
      this.paymentTypeID,
      this.paymentAmount,
      this.isReceived,
      this.actualPayDate,
      this.paymentNotes,
      this.empID,
      this.recivedMony,
      this.installSetup,
      this.model,
      this.inOrOut,
      this.expr1,
      this.paperNumber,
      this.paymentAutoNumber,
      this.maintemTreeId,
      this.eDID,
      this.monyAccount,
      this.monyProduct,
      this.monyCostItems,
      this.mony,
      this.creditORDepit,
      this.eMasterID,
      this.eNote,
      this.customerID,
      this.productID,
      this.expr5,
      this.production,
      this.expr6,
      this.quntity,
      this.itemsTreeId,
      this.storeid,
      this.monyActCurrancy,
      this.currancyEX,
      this.accountID,
      this.contractID,
      this.contractDate,
      this.contractAmountwTax,
      this.contractNote,
      this.contractAmountWoTax,
      this.contractType,
      this.contractEnddate,
      this.istender,
      this.note2,
      this.setupDate,
      this.setupNote,
      this.iSCancel,
      this.isInstall,
      this.printID,
      this.supplierMony,
      this.expr2,
      this.expr3,
      this.expr4,
      this.expr7,
      this.contractTypeID,
      this.typeName,
      this.monthCount,
      this.visitPrice,
      this.firstVisit,
      this.secoundVisit,
      this.theardVisit,
      this.membraneVisit,
      this.comID,
      this.customerAccount,
      this.expr9,
      this.productAccount,
      this.salesAccount,
      this.department,
      this.processExpence,
      this.eMID,
      this.eMDepartment,
      this.eDate,
      this.eCode,
      this.eDescription,
      this.cosrOrMony,
      this.proccessID,
      this.modifyBy,
      this.modifyAt,
      this.createBy,
      this.createAt,
      this.purchaseID,
      this.productionID,
      this.unRelaied,
      this.invoiceID,
      this.sourceType,
      this.currancyID,
      this.depit,
      this.costItems,
      this.credit,
      this.paymentAccount,
      this.acName,
      this.recivemonyCurrancy,
      this.cName,
      this.isDefult,
      this.isDistrib,
      this.sName,
      this.supplierCategoryId1,
      this.customerAccountName,
      this.departmentId,
      this.supplierID,
      this.extractionMasterID,
      this.customerExtractionMasterID,
      this.showPerm,
      this.addPerm,
      this.salesPerm,
      this.outPerm,
      this.employeeAccountID,
      this.paymentTitle,
      this.checkName,
      this.checkNumber,
      this.checkMaturityDate,
      this.checkReciveDate,
      this.checkMainBank,
      this.checkBankLocation,
      this.checkAccountId,
      this.checkExchangeDate,
      this.checkRestPlace,
      this.isCheckSort,
      this.isCheck,
      this.chekPaymentId,
      this.isChechExchanged,
      this.detailContractId,
      this.detailCustomerId,
      this.demandId,
      this.processTypeId,
      this.processNumber,
      this.paymentTargetDetailId,
      this.customerCode,
      this.acIndex,
      this.employeeNameA,
      this.reciveEmp,
      this.shippmentOrderId,
      this.extractionID,
      this.detailPurchaseId,
      this.salesMan,
      this.safeAutoNumber,
      this.acParent,
      this.itemQuantity,
      this.constSupplierMasterId,
      this.isNoTax,
      this.defultTaxCategoryID,
      this.taxCategoryID});

  DynamicList.fromJson(Map<String, dynamic> json) {
    pRID = json['PRID'];
    isDistribQty = json['IsDistribQty'];
    paymentID = json['PaymentID'];
    recivemony = json['Recivemony'];
    reciveDate = json['ReciveDate'];
    note = json['Note'];
    paymentMethod = json['PaymentMethod'];
    entryDetailID = json['EntryDetailID'];
    checkSetupID = json['CheckSetupID'];
    estPayDate = json['EstPayDate'];
    masterNote = json['MasterNote'];
    checkPartId = json['CheckPartId'];
    paymentTypeID = json['PaymentTypeID'];
    paymentAmount = json['PaymentAmount'];
    isReceived = json['IsReceived'];
    actualPayDate = json['ActualPayDate'];
    paymentNotes = json['PaymentNotes'];
    empID = json['EmpID'];
    recivedMony = json['RecivedMony'];
    installSetup = json['InstallSetup'];
    model = json['Model'];
    inOrOut = json['InOrOut'];
    expr1 = json['Expr1'];
    paperNumber = json['PaperNumber'];
    paymentAutoNumber = json['PaymentAutoNumber'];
    maintemTreeId = json['MaintemTreeId'];
    eDID = json['EDID'];
    monyAccount = json['MonyAccount'];
    monyProduct = json['MonyProduct'];
    monyCostItems = json['MonyCostItems'];
    mony = json['Mony'];
    creditORDepit = json['CreditORDepit'];
    eMasterID = json['EMasterID'];
    eNote = json['ENote'];
    customerID = json['CustomerID'];
    productID = json['ProductID'];
    expr5 = json['Expr5'];
    production = json['Production'];
    expr6 = json['Expr6'];
    quntity = json['Quntity'];
    itemsTreeId = json['ItemsTreeId'];
    storeid = json['Storeid'];
    monyActCurrancy = json['MonyActCurrancy'];
    currancyEX = json['CurrancyEX'];
    accountID = json['AccountID'];
    contractID = json['ContractID'];
    contractDate = json['ContractDate'];
    contractAmountwTax = json['ContractAmountwTax'];
    contractNote = json['ContractNote'];
    contractAmountWoTax = json['ContractAmountWoTax'];
    contractType = json['ContractType'];
    contractEnddate = json['ContractEnddate'];
    istender = json['Istender'];
    note2 = json['Note2'];
    setupDate = json['SetupDate'];
    setupNote = json['SetupNote'];
    iSCancel = json['ISCancel'];
    isInstall = json['IsInstall'];
    printID = json['PrintID'];
    supplierMony = json['SupplierMony'];
    expr2 = json['Expr2'];
    expr3 = json['Expr3'];
    expr4 = json['Expr4'];
    expr7 = json['Expr7'];
    contractTypeID = json['ContractTypeID'];
    typeName = json['TypeName'];
    monthCount = json['MonthCount'];
    visitPrice = json['VisitPrice'];
    firstVisit = json['firstVisit'];
    secoundVisit = json['SecoundVisit'];
    theardVisit = json['theardVisit'];
    membraneVisit = json['MembraneVisit'];
    comID = json['ComID'];
    customerAccount = json['CustomerAccount'];
    expr9 = json['Expr9'];
    productAccount = json['ProductAccount'];
    salesAccount = json['SalesAccount'];
    department = json['Department'];
    processExpence = json['ProcessExpence'];
    eMID = json['EMID'];
    eMDepartment = json['EMDepartment'];
    eDate = json['EDate'];
    eCode = json['ECode'];
    eDescription = json['EDescription'];
    cosrOrMony = json['CosrOrMony'];
    proccessID = json['ProccessID'];
    modifyBy = json['ModifyBy'];
    modifyAt = json['ModifyAt'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    purchaseID = json['PurchaseID'];
    productionID = json['ProductionID'];
    unRelaied = json['UnRelaied'];
    invoiceID = json['InvoiceID'];
    sourceType = json['SourceType'];
    currancyID = json['CurrancyID'];
    depit = json['Depit'];
    costItems = json['CostItems'];
    credit = json['Credit'];
    paymentAccount = json['PaymentAccount'];
    acName = json['AcName'];
    recivemonyCurrancy = json['RecivemonyCurrancy'];
    cName = json['CName'];
    isDefult = json['IsDefult'];
    isDistrib = json['IsDistrib'];
    sName = json['SName'];
    supplierCategoryId1 = json['SupplierCategoryId1'];
    customerAccountName = json['CustomerAccountName'];
    departmentId = json['DepartmentId'];
    supplierID = json['SupplierID'];
    extractionMasterID = json['ExtractionMasterID'];
    customerExtractionMasterID = json['CustomerExtractionMasterID'];
    showPerm = json['ShowPerm'];
    addPerm = json['AddPerm'];
    salesPerm = json['SalesPerm'];
    outPerm = json['OutPerm'];
    employeeAccountID = json['EmployeeAccountID'];
    paymentTitle = json['PaymentTitle'];
    checkName = json['CheckName'];
    checkNumber = json['CheckNumber'];
    checkMaturityDate = json['CheckMaturityDate'];
    checkReciveDate = json['CheckReciveDate'];
    checkMainBank = json['CheckMainBank'];
    checkBankLocation = json['CheckBankLocation'];
    checkAccountId = json['CheckAccountId'];
    checkExchangeDate = json['CheckExchangeDate'];
    checkRestPlace = json['CheckRestPlace'];
    isCheckSort = json['IsCheckSort'];
    isCheck = json['IsCheck'];
    chekPaymentId = json['ChekPaymentId'];
    isChechExchanged = json['IsChechExchanged'];
    detailContractId = json['DetailContractId'];
    detailCustomerId = json['DetailCustomerId'];
    demandId = json['DemandId'];
    processTypeId = json['ProcessTypeId'];
    processNumber = json['ProcessNumber'];
    paymentTargetDetailId = json['PaymentTargetDetailId'];
    customerCode = json['CustomerCode'];
    acIndex = json['AcIndex'];
    employeeNameA = json['EmployeeNameA'];
    reciveEmp = json['ReciveEmp'];
    shippmentOrderId = json['ShippmentOrderId'];
    extractionID = json['ExtractionID'];
    detailPurchaseId = json['DetailPurchaseId'];
    salesMan = json['SalesMan'];
    safeAutoNumber = json['SafeAutoNumber'];
    acParent = json['AcParent'];
    itemQuantity = json['ItemQuantity'];
    constSupplierMasterId = json['ConstSupplierMasterId'];
    isNoTax = json['IsNoTax'];
    defultTaxCategoryID = json['DefultTaxCategoryID'];
    taxCategoryID = json['TaxCategoryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PRID'] = pRID;
    data['IsDistribQty'] = isDistribQty;
    data['PaymentID'] = paymentID;
    data['Recivemony'] = recivemony;
    data['ReciveDate'] = reciveDate;
    data['Note'] = note;
    data['PaymentMethod'] = paymentMethod;
    data['EntryDetailID'] = entryDetailID;
    data['CheckSetupID'] = checkSetupID;
    data['EstPayDate'] = estPayDate;
    data['MasterNote'] = masterNote;
    data['CheckPartId'] = checkPartId;
    data['PaymentTypeID'] = paymentTypeID;
    data['PaymentAmount'] = paymentAmount;
    data['IsReceived'] = isReceived;
    data['ActualPayDate'] = actualPayDate;
    data['PaymentNotes'] = paymentNotes;
    data['EmpID'] = empID;
    data['RecivedMony'] = recivedMony;
    data['InstallSetup'] = installSetup;
    data['Model'] = model;
    data['InOrOut'] = inOrOut;
    data['Expr1'] = expr1;
    data['PaperNumber'] = paperNumber;
    data['PaymentAutoNumber'] = paymentAutoNumber;
    data['MaintemTreeId'] = maintemTreeId;
    data['EDID'] = eDID;
    data['MonyAccount'] = monyAccount;
    data['MonyProduct'] = monyProduct;
    data['MonyCostItems'] = monyCostItems;
    data['Mony'] = mony;
    data['CreditORDepit'] = creditORDepit;
    data['EMasterID'] = eMasterID;
    data['ENote'] = eNote;
    data['CustomerID'] = customerID;
    data['ProductID'] = productID;
    data['Expr5'] = expr5;
    data['Production'] = production;
    data['Expr6'] = expr6;
    data['Quntity'] = quntity;
    data['ItemsTreeId'] = itemsTreeId;
    data['Storeid'] = storeid;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['CurrancyEX'] = currancyEX;
    data['AccountID'] = accountID;
    data['ContractID'] = contractID;
    data['ContractDate'] = contractDate;
    data['ContractAmountwTax'] = contractAmountwTax;
    data['ContractNote'] = contractNote;
    data['ContractAmountWoTax'] = contractAmountWoTax;
    data['ContractType'] = contractType;
    data['ContractEnddate'] = contractEnddate;
    data['Istender'] = istender;
    data['Note2'] = note2;
    data['SetupDate'] = setupDate;
    data['SetupNote'] = setupNote;
    data['ISCancel'] = iSCancel;
    data['IsInstall'] = isInstall;
    data['PrintID'] = printID;
    data['SupplierMony'] = supplierMony;
    data['Expr2'] = expr2;
    data['Expr3'] = expr3;
    data['Expr4'] = expr4;
    data['Expr7'] = expr7;
    data['ContractTypeID'] = contractTypeID;
    data['TypeName'] = typeName;
    data['MonthCount'] = monthCount;
    data['VisitPrice'] = visitPrice;
    data['firstVisit'] = firstVisit;
    data['SecoundVisit'] = secoundVisit;
    data['theardVisit'] = theardVisit;
    data['MembraneVisit'] = membraneVisit;
    data['ComID'] = comID;
    data['CustomerAccount'] = customerAccount;
    data['Expr9'] = expr9;
    data['ProductAccount'] = productAccount;
    data['SalesAccount'] = salesAccount;
    data['Department'] = department;
    data['ProcessExpence'] = processExpence;
    data['EMID'] = eMID;
    data['EMDepartment'] = eMDepartment;
    data['EDate'] = eDate;
    data['ECode'] = eCode;
    data['EDescription'] = eDescription;
    data['CosrOrMony'] = cosrOrMony;
    data['ProccessID'] = proccessID;
    data['ModifyBy'] = modifyBy;
    data['ModifyAt'] = modifyAt;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['PurchaseID'] = purchaseID;
    data['ProductionID'] = productionID;
    data['UnRelaied'] = unRelaied;
    data['InvoiceID'] = invoiceID;
    data['SourceType'] = sourceType;
    data['CurrancyID'] = currancyID;
    data['Depit'] = depit;
    data['CostItems'] = costItems;
    data['Credit'] = credit;
    data['PaymentAccount'] = paymentAccount;
    data['AcName'] = acName;
    data['RecivemonyCurrancy'] = recivemonyCurrancy;
    data['CName'] = cName;
    data['IsDefult'] = isDefult;
    data['IsDistrib'] = isDistrib;
    data['SName'] = sName;
    data['SupplierCategoryId1'] = supplierCategoryId1;
    data['CustomerAccountName'] = customerAccountName;
    data['DepartmentId'] = departmentId;
    data['SupplierID'] = supplierID;
    data['ExtractionMasterID'] = extractionMasterID;
    data['CustomerExtractionMasterID'] = customerExtractionMasterID;
    data['ShowPerm'] = showPerm;
    data['AddPerm'] = addPerm;
    data['SalesPerm'] = salesPerm;
    data['OutPerm'] = outPerm;
    data['EmployeeAccountID'] = employeeAccountID;
    data['PaymentTitle'] = paymentTitle;
    data['CheckName'] = checkName;
    data['CheckNumber'] = checkNumber;
    data['CheckMaturityDate'] = checkMaturityDate;
    data['CheckReciveDate'] = checkReciveDate;
    data['CheckMainBank'] = checkMainBank;
    data['CheckBankLocation'] = checkBankLocation;
    data['CheckAccountId'] = checkAccountId;
    data['CheckExchangeDate'] = checkExchangeDate;
    data['CheckRestPlace'] = checkRestPlace;
    data['IsCheckSort'] = isCheckSort;
    data['IsCheck'] = isCheck;
    data['ChekPaymentId'] = chekPaymentId;
    data['IsChechExchanged'] = isChechExchanged;
    data['DetailContractId'] = detailContractId;
    data['DetailCustomerId'] = detailCustomerId;
    data['DemandId'] = demandId;
    data['ProcessTypeId'] = processTypeId;
    data['ProcessNumber'] = processNumber;
    data['PaymentTargetDetailId'] = paymentTargetDetailId;
    data['CustomerCode'] = customerCode;
    data['AcIndex'] = acIndex;
    data['EmployeeNameA'] = employeeNameA;
    data['ReciveEmp'] = reciveEmp;
    data['ShippmentOrderId'] = shippmentOrderId;
    data['ExtractionID'] = extractionID;
    data['DetailPurchaseId'] = detailPurchaseId;
    data['SalesMan'] = salesMan;
    data['SafeAutoNumber'] = safeAutoNumber;
    data['AcParent'] = acParent;
    data['ItemQuantity'] = itemQuantity;
    data['ConstSupplierMasterId'] = constSupplierMasterId;
    data['IsNoTax'] = isNoTax;
    data['DefultTaxCategoryID'] = defultTaxCategoryID;
    data['TaxCategoryID'] = taxCategoryID;
    return data;
  }
}
