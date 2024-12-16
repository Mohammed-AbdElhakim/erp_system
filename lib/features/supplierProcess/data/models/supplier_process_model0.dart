class SupplierProcessModel0 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  SupplierProcessModel0({this.dynamicList, this.numberofrecords});

  SupplierProcessModel0.fromJson(Map<String, dynamic> json) {
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
  String? acParent;
  String? expr1;
  String? depit;
  String? sourceType;
  String? createBy;
  String? createAt;
  String? cID;
  String? cName;
  String? cPerDollar;
  String? currancyID;
  String? depitCurrancy;
  String? supplierID;
  String? monyActCurrancy;
  String? sName;
  String? entrySource;
  String? description;
  String? supCode;
  String? opositAccount;
  String? opositeIds;
  String? balance;
  String? color;
  String? eDescription;
  String? eNote;
  String? credit;
  String? creditCurrancy;
  String? currancyEX;
  String? paperNumber;

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
      this.acParent,
      this.expr1,
      this.depit,
      this.sourceType,
      this.createBy,
      this.createAt,
      this.cID,
      this.cName,
      this.cPerDollar,
      this.currancyID,
      this.depitCurrancy,
      this.supplierID,
      this.monyActCurrancy,
      this.sName,
      this.entrySource,
      this.description,
      this.supCode,
      this.opositAccount,
      this.opositeIds,
      this.balance,
      this.color,
      this.eDescription,
      this.eNote,
      this.credit,
      this.creditCurrancy,
      this.currancyEX,
      this.paperNumber});

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
    acParent = json['AcParent'];
    expr1 = json['Expr1'];
    depit = json['Depit'];
    sourceType = json['SourceType'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    cID = json['CID'];
    cName = json['CName'];
    cPerDollar = json['CPerDollar'];
    currancyID = json['CurrancyID'];
    depitCurrancy = json['DepitCurrancy'];
    supplierID = json['SupplierID'];
    monyActCurrancy = json['MonyActCurrancy'];
    sName = json['SName'];
    entrySource = json['EntrySource'];
    description = json['description'];
    supCode = json['SupCode'];
    opositAccount = json['OpositAccount'];
    opositeIds = json['opositeIds'];
    balance = json['balance'];
    color = json['Color'];
    eDescription = json['EDescription'];
    eNote = json['ENote'];
    credit = json['Credit'];
    creditCurrancy = json['CreditCurrancy'];
    currancyEX = json['CurrancyEX'];
    paperNumber = json['PaperNumber'];
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
    data['AcParent'] = acParent;
    data['Expr1'] = expr1;
    data['Depit'] = depit;
    data['SourceType'] = sourceType;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['CID'] = cID;
    data['CName'] = cName;
    data['CPerDollar'] = cPerDollar;
    data['CurrancyID'] = currancyID;
    data['DepitCurrancy'] = depitCurrancy;
    data['SupplierID'] = supplierID;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['SName'] = sName;
    data['EntrySource'] = entrySource;
    data['description'] = description;
    data['SupCode'] = supCode;
    data['OpositAccount'] = opositAccount;
    data['opositeIds'] = opositeIds;
    data['balance'] = balance;
    data['Color'] = color;
    data['EDescription'] = eDescription;
    data['ENote'] = eNote;
    data['Credit'] = credit;
    data['CreditCurrancy'] = creditCurrancy;
    data['CurrancyEX'] = currancyEX;
    data['PaperNumber'] = paperNumber;
    return data;
  }
}
