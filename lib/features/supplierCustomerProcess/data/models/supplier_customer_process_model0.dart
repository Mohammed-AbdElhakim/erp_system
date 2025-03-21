class SupplierCustomerProcessModel0 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  SupplierCustomerProcessModel0({this.dynamicList, this.numberofrecords});

  SupplierCustomerProcessModel0.fromJson(Map<String, dynamic> json) {
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
  String? acType;
  String? eNote;
  String? credit;
  String? sourceType;
  String? createBy;
  String? createAt;
  String? cID;
  String? cName;
  String? cPerDollar;
  String? currancyID;
  String? purchaseID;
  String? creditCurrancy;
  String? supplierID;
  String? monyActCurrancy;
  String? currancyEX;
  String? sName;
  String? pOID;
  String? pONumber;
  String? entrySource;
  String? supCode;
  String? opositAccount;
  String? opositeIds;
  String? modifyBy;
  String? modifyAt;
  String? description;
  String? depit;
  String? depitCurrancy;
  String? costItems;
  String? cIName;
  String? costParent;
  String? cIIndex;
  String? productID;
  String? proName;
  String? pIndex;

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
      this.acType,
      this.eNote,
      this.credit,
      this.sourceType,
      this.createBy,
      this.createAt,
      this.cID,
      this.cName,
      this.cPerDollar,
      this.currancyID,
      this.purchaseID,
      this.creditCurrancy,
      this.supplierID,
      this.monyActCurrancy,
      this.currancyEX,
      this.sName,
      this.pOID,
      this.pONumber,
      this.entrySource,
      this.supCode,
      this.opositAccount,
      this.opositeIds,
      this.modifyBy,
      this.modifyAt,
      this.description,
      this.depit,
      this.depitCurrancy,
      this.costItems,
      this.cIName,
      this.costParent,
      this.cIIndex,
      this.productID,
      this.proName,
      this.pIndex});

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
    acType = json['AcType'];
    eNote = json['ENote'];
    credit = json['Credit'];
    sourceType = json['SourceType'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    cID = json['CID'];
    cName = json['CName'];
    cPerDollar = json['CPerDollar'];
    currancyID = json['CurrancyID'];
    purchaseID = json['PurchaseID'];
    creditCurrancy = json['CreditCurrancy'];
    supplierID = json['SupplierID'];
    monyActCurrancy = json['MonyActCurrancy'];
    currancyEX = json['CurrancyEX'];
    sName = json['SName'];
    pOID = json['POID'];
    pONumber = json['PONumber'];
    entrySource = json['EntrySource'];
    supCode = json['SupCode'];
    opositAccount = json['OpositAccount'];
    opositeIds = json['opositeIds'];
    modifyBy = json['ModifyBy'];
    modifyAt = json['ModifyAt'];
    description = json['description'];
    depit = json['Depit'];
    depitCurrancy = json['DepitCurrancy'];
    costItems = json['CostItems'];
    cIName = json['CIName'];
    costParent = json['CostParent'];
    cIIndex = json['CIIndex'];
    productID = json['ProductID'];
    proName = json['ProName'];
    pIndex = json['PIndex'];
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
    data['AcType'] = acType;
    data['ENote'] = eNote;
    data['Credit'] = credit;
    data['SourceType'] = sourceType;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['CID'] = cID;
    data['CName'] = cName;
    data['CPerDollar'] = cPerDollar;
    data['CurrancyID'] = currancyID;
    data['PurchaseID'] = purchaseID;
    data['CreditCurrancy'] = creditCurrancy;
    data['SupplierID'] = supplierID;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['CurrancyEX'] = currancyEX;
    data['SName'] = sName;
    data['POID'] = pOID;
    data['PONumber'] = pONumber;
    data['EntrySource'] = entrySource;
    data['SupCode'] = supCode;
    data['OpositAccount'] = opositAccount;
    data['opositeIds'] = opositeIds;
    data['ModifyBy'] = modifyBy;
    data['ModifyAt'] = modifyAt;
    data['description'] = description;
    data['Depit'] = depit;
    data['DepitCurrancy'] = depitCurrancy;
    data['CostItems'] = costItems;
    data['CIName'] = cIName;
    data['CostParent'] = costParent;
    data['CIIndex'] = cIIndex;
    data['ProductID'] = productID;
    data['ProName'] = proName;
    data['PIndex'] = pIndex;
    return data;
  }
}
