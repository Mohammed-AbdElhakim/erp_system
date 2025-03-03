class ProjectProcessModel0 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  ProjectProcessModel0({this.dynamicList, this.numberofrecords});

  ProjectProcessModel0.fromJson(Map<String, dynamic> json) {
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
  String? eNote;
  String? depit;
  String? createBy;
  String? createAt;
  String? cID;
  String? cName;
  String? cPerDollar;
  String? currancyID;
  String? depitCurrancy;
  String? productID;
  String? monyActCurrancy;
  String? costItems;
  String? cIName;
  String? costParent;
  String? proName;
  String? entrySource;
  String? pIndex;
  String? cIIndex;
  String? opositAccount;
  String? opositeIds;
  String? balance;
  String? acType;
  String? modifyBy;
  String? modifyAt;
  String? customerID;
  String? currancyEX;
  String? customerAccountName;
  String? customerAccountID;
  String? custCode;
  String? sourceType;
  String? purchaseID;
  String? pOID;
  String? pONumber;
  String? supplierID;
  String? sName;
  String? supCode;
  String? credit;
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
      this.eNote,
      this.depit,
      this.createBy,
      this.createAt,
      this.cID,
      this.cName,
      this.cPerDollar,
      this.currancyID,
      this.depitCurrancy,
      this.productID,
      this.monyActCurrancy,
      this.costItems,
      this.cIName,
      this.costParent,
      this.proName,
      this.entrySource,
      this.pIndex,
      this.cIIndex,
      this.opositAccount,
      this.opositeIds,
      this.balance,
      this.acType,
      this.modifyBy,
      this.modifyAt,
      this.customerID,
      this.currancyEX,
      this.customerAccountName,
      this.customerAccountID,
      this.custCode,
      this.sourceType,
      this.purchaseID,
      this.pOID,
      this.pONumber,
      this.supplierID,
      this.sName,
      this.supCode,
      this.credit,
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
    eNote = json['ENote'];
    depit = json['Depit'];
    createBy = json['CreateBy'];
    createAt = json['CreateAt'];
    cID = json['CID'];
    cName = json['CName'];
    cPerDollar = json['CPerDollar'];
    currancyID = json['CurrancyID'];
    depitCurrancy = json['DepitCurrancy'];
    productID = json['ProductID'];
    monyActCurrancy = json['MonyActCurrancy'];
    costItems = json['CostItems'];
    cIName = json['CIName'];
    costParent = json['CostParent'];
    proName = json['ProName'];
    entrySource = json['EntrySource'];
    pIndex = json['PIndex'];
    cIIndex = json['CIIndex'];
    opositAccount = json['OpositAccount'];
    opositeIds = json['opositeIds'];
    balance = json['balance'];
    acType = json['AcType'];
    modifyBy = json['ModifyBy'];
    modifyAt = json['ModifyAt'];
    customerID = json['CustomerID'];
    currancyEX = json['CurrancyEX'];
    customerAccountName = json['CustomerAccountName'];
    customerAccountID = json['CustomerAccountID'];
    custCode = json['CustCode'];
    sourceType = json['SourceType'];
    purchaseID = json['PurchaseID'];
    pOID = json['POID'];
    pONumber = json['PONumber'];
    supplierID = json['SupplierID'];
    sName = json['SName'];
    supCode = json['SupCode'];
    credit = json['Credit'];
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
    data['ENote'] = eNote;
    data['Depit'] = depit;
    data['CreateBy'] = createBy;
    data['CreateAt'] = createAt;
    data['CID'] = cID;
    data['CName'] = cName;
    data['CPerDollar'] = cPerDollar;
    data['CurrancyID'] = currancyID;
    data['DepitCurrancy'] = depitCurrancy;
    data['ProductID'] = productID;
    data['MonyActCurrancy'] = monyActCurrancy;
    data['CostItems'] = costItems;
    data['CIName'] = cIName;
    data['CostParent'] = costParent;
    data['ProName'] = proName;
    data['EntrySource'] = entrySource;
    data['PIndex'] = pIndex;
    data['CIIndex'] = cIIndex;
    data['OpositAccount'] = opositAccount;
    data['opositeIds'] = opositeIds;
    data['balance'] = balance;
    data['AcType'] = acType;
    data['ModifyBy'] = modifyBy;
    data['ModifyAt'] = modifyAt;
    data['CustomerID'] = customerID;
    data['CurrancyEX'] = currancyEX;
    data['CustomerAccountName'] = customerAccountName;
    data['CustomerAccountID'] = customerAccountID;
    data['CustCode'] = custCode;
    data['SourceType'] = sourceType;
    data['PurchaseID'] = purchaseID;
    data['POID'] = pOID;
    data['PONumber'] = pONumber;
    data['SupplierID'] = supplierID;
    data['SName'] = sName;
    data['SupCode'] = supCode;
    data['Credit'] = credit;
    data['PaperNumber'] = paperNumber;
    data['Color'] = color;
    return data;
  }
}
