class CostItemAccountReportModel0 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  CostItemAccountReportModel0({this.dynamicList, this.numberofrecords});

  CostItemAccountReportModel0.fromJson(Map<String, dynamic> json) {
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
  String? eDate;
  String? eDID;
  String? accountID;
  String? acID;
  String? acName;
  String? paperNumber;
  String? balance;
  String? color;
  String? dontShowCheque;
  String? isContractor;
  String? isSupplier;
  String? comID;
  String? eCode;
  String? eDescription;
  String? mony;
  String? creditORDepit;
  String? eMasterID;
  String? acCode;
  String? acParent;
  String? expr1;
  String? eNote;
  String? depit;
  String? sourceType;
  String? modifyBy;
  String? modifyAt;
  String? createBy;
  String? createAt;
  String? cID;
  String? cName;
  String? cPerDollar;
  String? currancyID;
  String? depitCurrancy;
  String? monyActCurrancy;
  String? currancyEX;
  String? costItems;
  String? cIName;
  String? costParent;
  String? entrySource;
  String? description;
  String? cIIndex;
  String? opositAccount;
  String? opositeIds;
  String? accountStatus;
  String? productID;
  String? proName;
  String? pIndex;
  String? credit;

  DynamicList(
      {this.eMID,
      this.eDate,
      this.eDID,
      this.accountID,
      this.acID,
      this.acName,
      this.paperNumber,
      this.balance,
      this.color,
      this.dontShowCheque,
      this.isContractor,
      this.isSupplier,
      this.comID,
      this.eCode,
      this.eDescription,
      this.mony,
      this.creditORDepit,
      this.eMasterID,
      this.acCode,
      this.acParent,
      this.expr1,
      this.eNote,
      this.depit,
      this.sourceType,
      this.modifyBy,
      this.modifyAt,
      this.createBy,
      this.createAt,
      this.cID,
      this.cName,
      this.cPerDollar,
      this.currancyID,
      this.depitCurrancy,
      this.monyActCurrancy,
      this.currancyEX,
      this.costItems,
      this.cIName,
      this.costParent,
      this.entrySource,
      this.description,
      this.cIIndex,
      this.opositAccount,
      this.opositeIds,
      this.accountStatus,
      this.productID,
      this.proName,
      this.pIndex,
      this.credit});

  DynamicList.fromJson(Map<String, dynamic> json) {
    eMID = json['EMID'];
    eDate = json['EDate'];
    eDID = json['EDID'];
    accountID = json['AccountID'];
    acID = json['AcID'];
    acName = json['AcName'];
    paperNumber = json['PaperNumber'];
    balance = json['balance'];
    color = json['Color'];
    dontShowCheque = json['DontShowCheque'];
    isContractor = json['IsContractor'];
    isSupplier = json['IsSupplier'];
    comID = json['ComID'];
    eCode = json['ECode'];
    eDescription = json['EDescription'];
    mony = json['Mony'];
    creditORDepit = json['CreditORDepit'];
    eMasterID = json['EMasterID'];
    acCode = json['AcCode'];
    acParent = json['AcParent'];
    expr1 = json['Expr1'];
    eNote = json['ENote'];
    depit = json['Depit'];
    sourceType = json['SourceType'];
    modifyBy = json['ModifyBy'];
    modifyAt = json['ModifyAt'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    cID = json['CID'];
    cName = json['CName'];
    cPerDollar = json['CPerDollar'];
    currancyID = json['CurrancyID'];
    depitCurrancy = json['DepitCurrancy'];
    monyActCurrancy = json['MonyActCurrancy'];
    currancyEX = json['CurrancyEX'];
    costItems = json['CostItems'];
    cIName = json['CIName'];
    costParent = json['CostParent'];
    entrySource = json['EntrySource'];
    description = json['description'];
    cIIndex = json['CIIndex'];
    opositAccount = json['OpositAccount'];
    opositeIds = json['opositeIds'];
    accountStatus = json['AccountStatus'];
    productID = json['ProductID'];
    proName = json['ProName'];
    pIndex = json['PIndex'];
    credit = json['Credit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EMID'] = eMID;
    data['EDate'] = eDate;
    data['EDID'] = eDID;
    data['AccountID'] = accountID;
    data['AcID'] = acID;
    data['AcName'] = acName;
    data['PaperNumber'] = paperNumber;
    data['balance'] = balance;
    data['Color'] = color;
    data['DontShowCheque'] = dontShowCheque;
    data['IsContractor'] = isContractor;
    data['IsSupplier'] = isSupplier;
    data['ComID'] = comID;
    data['ECode'] = eCode;
    data['EDescription'] = eDescription;
    data['Mony'] = mony;
    data['CreditORDepit'] = creditORDepit;
    data['EMasterID'] = eMasterID;
    data['AcCode'] = acCode;
    data['AcParent'] = acParent;
    data['Expr1'] = expr1;
    data['ENote'] = eNote;
    data['Depit'] = depit;
    data['SourceType'] = sourceType;
    data['ModifyBy'] = modifyBy;
    data['ModifyAt'] = modifyAt;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['CID'] = cID;
    data['CName'] = cName;
    data['CPerDollar'] = cPerDollar;
    data['CurrancyID'] = currancyID;
    data['DepitCurrancy'] = depitCurrancy;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['CurrancyEX'] = currancyEX;
    data['CostItems'] = costItems;
    data['CIName'] = cIName;
    data['CostParent'] = costParent;
    data['EntrySource'] = entrySource;
    data['description'] = description;
    data['CIIndex'] = cIIndex;
    data['OpositAccount'] = opositAccount;
    data['opositeIds'] = opositeIds;
    data['AccountStatus'] = accountStatus;
    data['ProductID'] = productID;
    data['ProName'] = proName;
    data['PIndex'] = pIndex;
    data['Credit'] = credit;
    return data;
  }
}
