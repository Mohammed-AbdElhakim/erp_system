class SupplierProcessModel {
  List<SupplierProcessItem>? dynamicList;
  int? numberofrecords;

  SupplierProcessModel({this.dynamicList, this.numberofrecords});

  SupplierProcessModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <SupplierProcessItem>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(SupplierProcessItem.fromJson(v));
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

class SupplierProcessItem {
  String? eMID;
  String? dontShowCheque;
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
  String? depit;
  String? sourceType;
  String? createBy;
  String? createAt;
  String? depitCurrancy;
  String? productID;
  String? monyActCurrancy;
  String? proName;
  String? entrySource;
  String? description;
  String? pIndex;
  String? opositAccount;
  String? opositeIds;
  String? balance;
  String? credit;
  String? paperNumber;
  String? color;

  SupplierProcessItem(
      {this.eMID,
      this.dontShowCheque,
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
      this.depit,
      this.sourceType,
      this.createBy,
      this.createAt,
      this.depitCurrancy,
      this.productID,
      this.monyActCurrancy,
      this.proName,
      this.entrySource,
      this.description,
      this.pIndex,
      this.opositAccount,
      this.opositeIds,
      this.balance,
      this.credit,
      this.paperNumber,
      this.color});

  SupplierProcessItem.fromJson(Map<String, dynamic> json) {
    eMID = json['EMID'];
    dontShowCheque = json['DontShowCheque'];
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
    depit = json['Depit'];
    sourceType = json['SourceType'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    depitCurrancy = json['DepitCurrancy'];
    productID = json['ProductID'];
    monyActCurrancy = json['MonyActCurrancy'];
    proName = json['ProName'];
    entrySource = json['EntrySource'];
    description = json['description'];
    pIndex = json['PIndex'];
    opositAccount = json['OpositAccount'];
    opositeIds = json['opositeIds'];
    balance = json['balance'];
    credit = json['Credit'];
    paperNumber = json['PaperNumber'];
    color = json['Color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EMID'] = eMID;
    data['DontShowCheque'] = dontShowCheque;
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
    data['Depit'] = depit;
    data['SourceType'] = sourceType;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['DepitCurrancy'] = depitCurrancy;
    data['ProductID'] = productID;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['ProName'] = proName;
    data['EntrySource'] = entrySource;
    data['description'] = description;
    data['PIndex'] = pIndex;
    data['OpositAccount'] = opositAccount;
    data['opositeIds'] = opositeIds;
    data['balance'] = balance;
    data['Credit'] = credit;
    data['PaperNumber'] = paperNumber;
    data['Color'] = color;
    return data;
  }
}
