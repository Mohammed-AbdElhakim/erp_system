class CustomerAccountModel0 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  CustomerAccountModel0({this.dynamicList, this.numberofrecords});

  CustomerAccountModel0.fromJson(Map<String, dynamic> json) {
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
  String? eMID;
  String? dontShowCheque;
  String? isContractor;
  String? isSupplier;
  String? comID;
  String? eDate;
  String? eCode;
  String? eDID;
  String? accountID;
  String? mony;
  String? creditORDepit;
  String? eMasterID;
  String? acID;
  String? acName;
  String? acCode;
  String? accountStatus;
  String? acParent;
  String? expr1;
  String? acType;
  String? depit;
  String? sourceType;
  String? createBy;
  String? createAt;
  String? cID;
  String? cName;
  String? cPerDollar;
  String? currancyID;
  String? depitCurrancy;
  String? customerID;
  String? monyActCurrancy;
  String? customerAccountName;
  String? customerAccountID;
  String? entrySource;
  String? custCode;
  String? opositAccount;
  String? opositeIds;
  String? balance;
  String? eDescription;
  String? contractID;
  String? autoNumber;
  String? eNote;
  String? credit;
  String? creditCurrancy;
  String? paperNumber;
  String? color;

  DynamicList(
      {this.eMID,
      this.dontShowCheque,
      this.isContractor,
      this.isSupplier,
      this.comID,
      this.eDate,
      this.eCode,
      this.eDID,
      this.accountID,
      this.mony,
      this.creditORDepit,
      this.eMasterID,
      this.acID,
      this.acName,
      this.acCode,
      this.accountStatus,
      this.acParent,
      this.expr1,
      this.acType,
      this.depit,
      this.sourceType,
      this.createBy,
      this.createAt,
      this.cID,
      this.cName,
      this.cPerDollar,
      this.currancyID,
      this.depitCurrancy,
      this.customerID,
      this.monyActCurrancy,
      this.customerAccountName,
      this.customerAccountID,
      this.entrySource,
      this.custCode,
      this.opositAccount,
      this.opositeIds,
      this.balance,
      this.eDescription,
      this.contractID,
      this.autoNumber,
      this.eNote,
      this.credit,
      this.creditCurrancy,
      this.paperNumber,
      this.color});

  DynamicList.fromJson(Map<String, dynamic> json) {
    eMID = json['EMID'];
    dontShowCheque = json['DontShowCheque'];
    isContractor = json['IsContractor'];
    isSupplier = json['IsSupplier'];
    comID = json['ComID'];
    eDate = json['EDate'];
    eCode = json['ECode'];
    eDID = json['EDID'];
    accountID = json['AccountID'];
    mony = json['Mony'];
    creditORDepit = json['CreditORDepit'];
    eMasterID = json['EMasterID'];
    acID = json['AcID'];
    acName = json['AcName'];
    acCode = json['AcCode'];
    accountStatus = json['AccountStatus'];
    acParent = json['AcParent'];
    expr1 = json['Expr1'];
    acType = json['AcType'];
    depit = json['Depit'];
    sourceType = json['SourceType'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    cID = json['CID'];
    cName = json['CName'];
    cPerDollar = json['CPerDollar'];
    currancyID = json['CurrancyID'];
    depitCurrancy = json['DepitCurrancy'];
    customerID = json['CustomerID'];
    monyActCurrancy = json['MonyActCurrancy'];
    customerAccountName = json['CustomerAccountName'];
    customerAccountID = json['CustomerAccountID'];
    entrySource = json['EntrySource'];
    custCode = json['CustCode'];
    opositAccount = json['OpositAccount'];
    opositeIds = json['opositeIds'];
    balance = json['balance'];
    eDescription = json['EDescription'];
    contractID = json['ContractID'];
    autoNumber = json['AutoNumber'];
    eNote = json['ENote'];
    credit = json['Credit'];
    creditCurrancy = json['CreditCurrancy'];
    paperNumber = json['PaperNumber'];
    color = json['Color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EMID'] = eMID;
    data['DontShowCheque'] = dontShowCheque;
    data['IsContractor'] = isContractor;
    data['IsSupplier'] = isSupplier;
    data['ComID'] = comID;
    data['EDate'] = eDate;
    data['ECode'] = eCode;
    data['EDID'] = eDID;
    data['AccountID'] = accountID;
    data['Mony'] = mony;
    data['CreditORDepit'] = creditORDepit;
    data['EMasterID'] = eMasterID;
    data['AcID'] = acID;
    data['AcName'] = acName;
    data['AcCode'] = acCode;
    data['AccountStatus'] = accountStatus;
    data['AcParent'] = acParent;
    data['Expr1'] = expr1;
    data['AcType'] = acType;
    data['Depit'] = depit;
    data['SourceType'] = sourceType;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['CID'] = cID;
    data['CName'] = cName;
    data['CPerDollar'] = cPerDollar;
    data['CurrancyID'] = currancyID;
    data['DepitCurrancy'] = depitCurrancy;
    data['CustomerID'] = customerID;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['CustomerAccountName'] = customerAccountName;
    data['CustomerAccountID'] = customerAccountID;
    data['EntrySource'] = entrySource;
    data['CustCode'] = custCode;
    data['OpositAccount'] = opositAccount;
    data['opositeIds'] = opositeIds;
    data['balance'] = balance;
    data['EDescription'] = eDescription;
    data['ContractID'] = contractID;
    data['AutoNumber'] = autoNumber;
    data['ENote'] = eNote;
    data['Credit'] = credit;
    data['CreditCurrancy'] = creditCurrancy;
    data['PaperNumber'] = paperNumber;
    data['Color'] = color;
    return data;
  }
}
