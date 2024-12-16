class SupplierProcessModel5 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  SupplierProcessModel5({this.dynamicList, this.numberofrecords});

  SupplierProcessModel5.fromJson(Map<String, dynamic> json) {
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
  String? depit;
  String? depitCurrancy;
  String? eMID;
  String? comID;
  String? eDate;
  String? eCode;
  String? eNote;
  String? eDID;
  String? accountID;
  String? creditORDepit;
  String? eMasterID;
  String? acID;
  String? acName;
  String? acCode;
  String? acParent;
  String? expr1;
  String? sourceType;
  String? createBy;
  String? createAt;
  String? cID;
  String? cName;
  String? cPerDollar;
  String? currancyID;
  String? mony;
  String? monyActCurrancy;
  String? supplierID;
  String? sName;
  String? discountCurrancy;
  String? discount;
  String? balance;
  String? color;
  String? accountStatus;
  String? eDescription;
  String? currancyEX;
  String? credit;
  String? paperNumber;

  DynamicList(
      {this.depit,
      this.depitCurrancy,
      this.eMID,
      this.comID,
      this.eDate,
      this.eCode,
      this.eNote,
      this.eDID,
      this.accountID,
      this.creditORDepit,
      this.eMasterID,
      this.acID,
      this.acName,
      this.acCode,
      this.acParent,
      this.expr1,
      this.sourceType,
      this.createBy,
      this.createAt,
      this.cID,
      this.cName,
      this.cPerDollar,
      this.currancyID,
      this.mony,
      this.monyActCurrancy,
      this.supplierID,
      this.sName,
      this.discountCurrancy,
      this.discount,
      this.balance,
      this.color,
      this.accountStatus,
      this.eDescription,
      this.currancyEX,
      this.credit,
      this.paperNumber});

  DynamicList.fromJson(Map<String, dynamic> json) {
    depit = json['depit'];
    depitCurrancy = json['DepitCurrancy'];
    eMID = json['EMID'];
    comID = json['ComID'];
    eDate = json['EDate'];
    eCode = json['ECode'];
    eNote = json['ENote'];
    eDID = json['EDID'];
    accountID = json['AccountID'];
    creditORDepit = json['CreditORDepit'];
    eMasterID = json['EMasterID'];
    acID = json['AcID'];
    acName = json['AcName'];
    acCode = json['AcCode'];
    acParent = json['AcParent'];
    expr1 = json['Expr1'];
    sourceType = json['SourceType'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    cID = json['CID'];
    cName = json['CName'];
    cPerDollar = json['CPerDollar'];
    currancyID = json['CurrancyID'];
    mony = json['Mony'];
    monyActCurrancy = json['MonyActCurrancy'];
    supplierID = json['SupplierID'];
    sName = json['SName'];
    discountCurrancy = json['DiscountCurrancy'];
    discount = json['Discount'];
    balance = json['balance'];
    color = json['Color'];
    accountStatus = json['AccountStatus'];
    eDescription = json['EDescription'];
    currancyEX = json['CurrancyEX'];
    credit = json['credit'];
    paperNumber = json['PaperNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['depit'] = depit;
    data['DepitCurrancy'] = depitCurrancy;
    data['EMID'] = eMID;
    data['ComID'] = comID;
    data['EDate'] = eDate;
    data['ECode'] = eCode;
    data['ENote'] = eNote;
    data['EDID'] = eDID;
    data['AccountID'] = accountID;
    data['CreditORDepit'] = creditORDepit;
    data['EMasterID'] = eMasterID;
    data['AcID'] = acID;
    data['AcName'] = acName;
    data['AcCode'] = acCode;
    data['AcParent'] = acParent;
    data['Expr1'] = expr1;
    data['SourceType'] = sourceType;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['CID'] = cID;
    data['CName'] = cName;
    data['CPerDollar'] = cPerDollar;
    data['CurrancyID'] = currancyID;
    data['Mony'] = mony;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['SupplierID'] = supplierID;
    data['SName'] = sName;
    data['DiscountCurrancy'] = discountCurrancy;
    data['Discount'] = discount;
    data['balance'] = balance;
    data['Color'] = color;
    data['AccountStatus'] = accountStatus;
    data['EDescription'] = eDescription;
    data['CurrancyEX'] = currancyEX;
    data['credit'] = credit;
    data['PaperNumber'] = paperNumber;
    return data;
  }
}
