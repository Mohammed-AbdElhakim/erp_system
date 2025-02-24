class CustomerAccountModel3 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  CustomerAccountModel3({this.dynamicList, this.numberofrecords});

  CustomerAccountModel3.fromJson(Map<String, dynamic> json) {
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
  int? entryDetailID;
  double? paymentAmount;
  bool? isReceived;
  String? actualPayDate;
  int? empID;
  int? model;
  bool? inOrOut;
  int? expr1;
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
  int? currancyID;
  double? depit;
  String? paymentAccount;
  String? acName;
  double? recivemonyCurrancy;
  String? cName;
  bool? isDefult;
  String? customerAccountName;
  int? departmentId;
  String? showPerm;
  String? addPerm;
  String? salesPerm;
  String? outPerm;
  int? paymentTitle;
  int? customerCode;
  double? acIndex;
  String? employeeNameA;
  int? acParent;

  DynamicList(
      {this.pRID,
      this.paymentID,
      this.recivemony,
      this.entryDetailID,
      this.paymentAmount,
      this.isReceived,
      this.actualPayDate,
      this.empID,
      this.model,
      this.inOrOut,
      this.expr1,
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
      this.currancyID,
      this.depit,
      this.paymentAccount,
      this.acName,
      this.recivemonyCurrancy,
      this.cName,
      this.isDefult,
      this.customerAccountName,
      this.departmentId,
      this.showPerm,
      this.addPerm,
      this.salesPerm,
      this.outPerm,
      this.paymentTitle,
      this.customerCode,
      this.acIndex,
      this.employeeNameA,
      this.acParent});

  DynamicList.fromJson(Map<String, dynamic> json) {
    pRID = json['PRID'];
    paymentID = json['PaymentID'];
    recivemony = json['Recivemony'];
    entryDetailID = json['EntryDetailID'];
    paymentAmount = json['PaymentAmount'];
    isReceived = json['IsReceived'];
    actualPayDate = json['ActualPayDate'];
    empID = json['EmpID'];
    model = json['Model'];
    inOrOut = json['InOrOut'];
    expr1 = json['Expr1'];
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
    currancyID = json['CurrancyID'];
    depit = json['Depit'];
    paymentAccount = json['PaymentAccount'];
    acName = json['AcName'];
    recivemonyCurrancy = json['RecivemonyCurrancy'];
    cName = json['CName'];
    isDefult = json['IsDefult'];
    customerAccountName = json['CustomerAccountName'];
    departmentId = json['DepartmentId'];
    showPerm = json['ShowPerm'];
    addPerm = json['AddPerm'];
    salesPerm = json['SalesPerm'];
    outPerm = json['OutPerm'];
    paymentTitle = json['PaymentTitle'];
    customerCode = json['CustomerCode'];
    acIndex = json['AcIndex'];
    employeeNameA = json['EmployeeNameA'];
    acParent = json['AcParent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PRID'] = pRID;
    data['PaymentID'] = paymentID;
    data['Recivemony'] = recivemony;
    data['EntryDetailID'] = entryDetailID;
    data['PaymentAmount'] = paymentAmount;
    data['IsReceived'] = isReceived;
    data['ActualPayDate'] = actualPayDate;
    data['EmpID'] = empID;
    data['Model'] = model;
    data['InOrOut'] = inOrOut;
    data['Expr1'] = expr1;
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
    data['CurrancyID'] = currancyID;
    data['Depit'] = depit;
    data['PaymentAccount'] = paymentAccount;
    data['AcName'] = acName;
    data['RecivemonyCurrancy'] = recivemonyCurrancy;
    data['CName'] = cName;
    data['IsDefult'] = isDefult;
    data['CustomerAccountName'] = customerAccountName;
    data['DepartmentId'] = departmentId;
    data['ShowPerm'] = showPerm;
    data['AddPerm'] = addPerm;
    data['SalesPerm'] = salesPerm;
    data['OutPerm'] = outPerm;
    data['PaymentTitle'] = paymentTitle;
    data['CustomerCode'] = customerCode;
    data['AcIndex'] = acIndex;
    data['EmployeeNameA'] = employeeNameA;
    data['AcParent'] = acParent;
    return data;
  }
}
