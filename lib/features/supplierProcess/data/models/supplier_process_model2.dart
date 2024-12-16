class SupplierProcessModel2 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  SupplierProcessModel2({this.dynamicList, this.numberofrecords});

  SupplierProcessModel2.fromJson(Map<String, dynamic> json) {
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
  int? paymentID;
  double? recivemony;
  String? reciveDate;
  int? entryDetailID;
  double? paymentAmount;
  bool? isReceived;
  String? actualPayDate;
  int? empID;
  int? model;
  bool? inOrOut;
  int? paymentAutoNumber;
  int? eDID;
  int? monyAccount;
  double? mony;
  bool? creditORDepit;
  int? eMasterID;
  int? customerID;
  double? monyActCurrancy;
  double? currancyEX;
  int? accountID;
  int? comID;
  int? eMID;
  String? eDate;
  int? eCode;
  int? createBy;
  String? createAt;
  bool? unRelaied;
  int? sourceType;
  double? credit;
  String? paymentAccount;
  String? acName;
  double? recivemonyCurrancy;
  String? sName;
  int? supplierCategoryId1;
  String? customerAccountName;
  int? supplierID;
  String? showPerm;
  String? addPerm;
  String? salesPerm;
  String? outPerm;
  int? paymentTitle;
  int? customerCode;
  double? acIndex;
  String? employeeNameA;
  int? acParent;
  String? note;
  String? paymentNotes;
  int? expr1;
  String? paperNumber;
  String? eNote;
  String? eDescription;
  int? modifyBy;
  String? modifyAt;
  int? currancyID;
  double? depit;
  String? cName;
  bool? isDefult;

  DynamicList(
      {this.pRID,
      this.paymentID,
      this.recivemony,
      this.reciveDate,
      this.entryDetailID,
      this.paymentAmount,
      this.isReceived,
      this.actualPayDate,
      this.empID,
      this.model,
      this.inOrOut,
      this.paymentAutoNumber,
      this.eDID,
      this.monyAccount,
      this.mony,
      this.creditORDepit,
      this.eMasterID,
      this.customerID,
      this.monyActCurrancy,
      this.currancyEX,
      this.accountID,
      this.comID,
      this.eMID,
      this.eDate,
      this.eCode,
      this.createBy,
      this.createAt,
      this.unRelaied,
      this.sourceType,
      this.credit,
      this.paymentAccount,
      this.acName,
      this.recivemonyCurrancy,
      this.sName,
      this.supplierCategoryId1,
      this.customerAccountName,
      this.supplierID,
      this.showPerm,
      this.addPerm,
      this.salesPerm,
      this.outPerm,
      this.paymentTitle,
      this.customerCode,
      this.acIndex,
      this.employeeNameA,
      this.acParent,
      this.note,
      this.paymentNotes,
      this.expr1,
      this.paperNumber,
      this.eNote,
      this.eDescription,
      this.modifyBy,
      this.modifyAt,
      this.currancyID,
      this.depit,
      this.cName,
      this.isDefult});

  DynamicList.fromJson(Map<String, dynamic> json) {
    pRID = json['PRID'];
    paymentID = json['PaymentID'];
    recivemony = json['Recivemony'];
    reciveDate = json['ReciveDate'];
    entryDetailID = json['EntryDetailID'];
    paymentAmount = json['PaymentAmount'];
    isReceived = json['IsReceived'];
    actualPayDate = json['ActualPayDate'];
    empID = json['EmpID'];
    model = json['Model'];
    inOrOut = json['InOrOut'];
    paymentAutoNumber = json['PaymentAutoNumber'];
    eDID = json['EDID'];
    monyAccount = json['MonyAccount'];
    mony = json['Mony'];
    creditORDepit = json['CreditORDepit'];
    eMasterID = json['EMasterID'];
    customerID = json['CustomerID'];
    monyActCurrancy = json['MonyActCurrancy'];
    currancyEX = json['CurrancyEX'];
    accountID = json['AccountID'];
    comID = json['ComID'];
    eMID = json['EMID'];
    eDate = json['EDate'];
    eCode = json['ECode'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    unRelaied = json['UnRelaied'];
    sourceType = json['SourceType'];
    credit = json['Credit'];
    paymentAccount = json['PaymentAccount'];
    acName = json['AcName'];
    recivemonyCurrancy = json['RecivemonyCurrancy'];
    sName = json['SName'];
    supplierCategoryId1 = json['SupplierCategoryId1'];
    customerAccountName = json['CustomerAccountName'];
    supplierID = json['SupplierID'];
    showPerm = json['ShowPerm'];
    addPerm = json['AddPerm'];
    salesPerm = json['SalesPerm'];
    outPerm = json['OutPerm'];
    paymentTitle = json['PaymentTitle'];
    customerCode = json['CustomerCode'];
    acIndex = json['AcIndex'];
    employeeNameA = json['EmployeeNameA'];
    acParent = json['AcParent'];
    note = json['Note'];
    paymentNotes = json['PaymentNotes'];
    expr1 = json['Expr1'];
    paperNumber = json['PaperNumber'];
    eNote = json['ENote'];
    eDescription = json['EDescription'];
    modifyBy = json['ModifyBy'];
    modifyAt = json['ModifyAt'];
    currancyID = json['CurrancyID'];
    depit = json['Depit'];
    cName = json['CName'];
    isDefult = json['IsDefult'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PRID'] = pRID;
    data['PaymentID'] = paymentID;
    data['Recivemony'] = recivemony;
    data['ReciveDate'] = reciveDate;
    data['EntryDetailID'] = entryDetailID;
    data['PaymentAmount'] = paymentAmount;
    data['IsReceived'] = isReceived;
    data['ActualPayDate'] = actualPayDate;
    data['EmpID'] = empID;
    data['Model'] = model;
    data['InOrOut'] = inOrOut;
    data['PaymentAutoNumber'] = paymentAutoNumber;
    data['EDID'] = eDID;
    data['MonyAccount'] = monyAccount;
    data['Mony'] = mony;
    data['CreditORDepit'] = creditORDepit;
    data['EMasterID'] = eMasterID;
    data['CustomerID'] = customerID;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['CurrancyEX'] = currancyEX;
    data['AccountID'] = accountID;
    data['ComID'] = comID;
    data['EMID'] = eMID;
    data['EDate'] = eDate;
    data['ECode'] = eCode;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['UnRelaied'] = unRelaied;
    data['SourceType'] = sourceType;
    data['Credit'] = credit;
    data['PaymentAccount'] = paymentAccount;
    data['AcName'] = acName;
    data['RecivemonyCurrancy'] = recivemonyCurrancy;
    data['SName'] = sName;
    data['SupplierCategoryId1'] = supplierCategoryId1;
    data['CustomerAccountName'] = customerAccountName;
    data['SupplierID'] = supplierID;
    data['ShowPerm'] = showPerm;
    data['AddPerm'] = addPerm;
    data['SalesPerm'] = salesPerm;
    data['OutPerm'] = outPerm;
    data['PaymentTitle'] = paymentTitle;
    data['CustomerCode'] = customerCode;
    data['AcIndex'] = acIndex;
    data['EmployeeNameA'] = employeeNameA;
    data['AcParent'] = acParent;
    data['Note'] = note;
    data['PaymentNotes'] = paymentNotes;
    data['Expr1'] = expr1;
    data['PaperNumber'] = paperNumber;
    data['ENote'] = eNote;
    data['EDescription'] = eDescription;
    data['ModifyBy'] = modifyBy;
    data['ModifyAt'] = modifyAt;
    data['CurrancyID'] = currancyID;
    data['Depit'] = depit;
    data['CName'] = cName;
    data['IsDefult'] = isDefult;
    return data;
  }
}
