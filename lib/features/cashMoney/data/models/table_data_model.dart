class TableDataModel {
  List<ListItem>? listData;
  int? numberofrecords;

  TableDataModel({this.listData, this.numberofrecords});

  TableDataModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      listData = <ListItem>[];
      json['dynamicList'].forEach((v) {
        listData!.add(ListItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listData != null) {
      data['dynamicList'] = listData!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class ListItem {
  String? eMID;
  String? dontShowCheque;
  String? isContractor;
  String? isSupplier;
  String? comID;
  String? eDate;
  String? eCode;
  String? eDescription;
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
  String? eNote;
  String? depit;
  String? createBy;
  String? createAt;
  String? cID;
  String? cName;
  String? cPerDollar;
  String? currancyID;
  String? depitCurrancy;
  String? monyActCurrancy;
  String? currancyEX;
  String? entrySource;
  String? opositAccount;
  String? opositeIds;
  String? balance;
  String? credit;
  String? creditCurrancy;
  String? modifyBy;
  String? modifyAt;
  String? employeeAccount;
  String? employeeNameA;
  String? paperNumber;
  String? color;

  ListItem({this.eMID,
    this.dontShowCheque,
    this.isContractor,
    this.isSupplier,
    this.comID,
    this.eDate,
    this.eCode,
    this.eDescription,
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
    this.eNote,
    this.depit,
    this.createBy,
    this.createAt,
    this.cID,
    this.cName,
    this.cPerDollar,
    this.currancyID,
    this.depitCurrancy,
    this.monyActCurrancy,
    this.currancyEX,
    this.entrySource,
    this.opositAccount,
    this.opositeIds,
    this.balance,
    this.credit,
    this.creditCurrancy,
    this.modifyBy,
    this.modifyAt,
    this.employeeAccount,
    this.employeeNameA,
    this.paperNumber,
    this.color});

  ListItem.fromJson(Map<String, dynamic> json) {
    eMID = json['EMID'];
    dontShowCheque = json['DontShowCheque'];
    isContractor = json['IsContractor'];
    isSupplier = json['IsSupplier'];
    comID = json['ComID'];
    eDate = json['EDate'];
    eCode = json['ECode'];
    eDescription = json['EDescription'];
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
    eNote = json['ENote'];
    depit = json['Depit'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    cID = json['CID'];
    cName = json['CName'];
    cPerDollar = json['CPerDollar'];
    currancyID = json['CurrancyID'];
    depitCurrancy = json['DepitCurrancy'];
    monyActCurrancy = json['MonyActCurrancy'];
    currancyEX = json['CurrancyEX'];
    entrySource = json['EntrySource'];
    opositAccount = json['OpositAccount'];
    opositeIds = json['opositeIds'];
    balance = json['balance'];
    credit = json['Credit'];
    creditCurrancy = json['CreditCurrancy'];
    modifyBy = json['ModifyBy'];
    modifyAt = json['ModifyAt'];
    employeeAccount = json['EmployeeAccount'];
    employeeNameA = json['EmployeeNameA'];
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
    data['EDescription'] = eDescription;
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
    data['ENote'] = eNote;
    data['Depit'] = depit;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['CID'] = cID;
    data['CName'] = cName;
    data['CPerDollar'] = cPerDollar;
    data['CurrancyID'] = currancyID;
    data['DepitCurrancy'] = depitCurrancy;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['CurrancyEX'] = currancyEX;
    data['EntrySource'] = entrySource;
    data['OpositAccount'] = opositAccount;
    data['opositeIds'] = opositeIds;
    data['balance'] = balance;
    data['Credit'] = credit;
    data['CreditCurrancy'] = creditCurrancy;
    data['ModifyBy'] = modifyBy;
    data['ModifyAt'] = modifyAt;
    data['EmployeeAccount'] = employeeAccount;
    data['EmployeeNameA'] = employeeNameA;
    data['PaperNumber'] = paperNumber;
    data['Color'] = color;
    return data;
  }
}
