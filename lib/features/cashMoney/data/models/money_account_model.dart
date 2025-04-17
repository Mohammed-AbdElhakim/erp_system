class MoneyAccountModel {
  List<MoneyAccountList>? dynamicList;
  int? numberofrecords;

  MoneyAccountModel({this.dynamicList, this.numberofrecords});

  MoneyAccountModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <MoneyAccountList>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(new MoneyAccountList.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (dynamicList != null) {
      data['dynamicList'] = dynamicList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class MoneyAccountList {
  int? acID;
  String? acName;
  bool? creditORDepit;
  bool? allORDetail;
  bool? iSCost;
  int? acParent;
  int? comID;
  String? parent;
  int? acType;
  String? sName;
  int? costID;
  String? cMName;
  String? sheetName;
  int? sheet;
  int? acCode;
  int? acIndex;
  String? setting;
  String? eSName;
  int? indexchar;
  bool? openAccount;
  String? openDate;
  bool? openIsDepit;
  String? fullName;
  int? lastcount;
  int? monyindex;
  String? addPerm;
  String? salesPerm;
  String? showPerm;
  String? outPerm;
  String? acNameKSA;

  MoneyAccountList(
      {this.acID,
      this.acName,
      this.creditORDepit,
      this.allORDetail,
      this.iSCost,
      this.acParent,
      this.comID,
      this.parent,
      this.acType,
      this.sName,
      this.costID,
      this.cMName,
      this.sheetName,
      this.sheet,
      this.acCode,
      this.acIndex,
      this.setting,
      this.eSName,
      this.indexchar,
      this.openAccount,
      this.openDate,
      this.openIsDepit,
      this.fullName,
      this.lastcount,
      this.monyindex,
      this.addPerm,
      this.salesPerm,
      this.showPerm,
      this.outPerm,
      this.acNameKSA});

  MoneyAccountList.fromJson(Map<String, dynamic> json) {
    acID = json['AcID'];
    acName = json['AcName'];
    creditORDepit = json['CreditORDepit'];
    allORDetail = json['AllORDetail'];
    iSCost = json['ISCost'];
    acParent = json['AcParent'];
    comID = json['ComID'];
    parent = json['Parent'];
    acType = json['AcType'];
    sName = json['SName'];
    costID = json['CostID'];
    cMName = json['CMName'];
    sheetName = json['SheetName'];
    sheet = json['Sheet'];
    acCode = json['AcCode'];
    acIndex = json['AcIndex'];
    setting = json['Setting'];
    eSName = json['ESName'];
    indexchar = json['indexchar'];
    openAccount = json['OpenAccount'];
    openDate = json['OpenDate'];
    openIsDepit = json['OpenIsDepit'];
    fullName = json['FullName'];
    lastcount = json['lastcount'];
    monyindex = json['monyindex'];
    addPerm = json['AddPerm'];
    salesPerm = json['SalesPerm'];
    showPerm = json['ShowPerm'];
    outPerm = json['OutPerm'];
    acNameKSA = json['AcNameKSA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AcID'] = acID;
    data['AcName'] = acName;
    data['CreditORDepit'] = creditORDepit;
    data['AllORDetail'] = allORDetail;
    data['ISCost'] = iSCost;
    data['AcParent'] = acParent;
    data['ComID'] = comID;
    data['Parent'] = parent;
    data['AcType'] = acType;
    data['SName'] = sName;
    data['CostID'] = costID;
    data['CMName'] = cMName;
    data['SheetName'] = sheetName;
    data['Sheet'] = sheet;
    data['AcCode'] = acCode;
    data['AcIndex'] = acIndex;
    data['Setting'] = setting;
    data['ESName'] = eSName;
    data['indexchar'] = indexchar;
    data['OpenAccount'] = openAccount;
    data['OpenDate'] = openDate;
    data['OpenIsDepit'] = openIsDepit;
    data['FullName'] = fullName;
    data['lastcount'] = lastcount;
    data['monyindex'] = monyindex;
    data['AddPerm'] = addPerm;
    data['SalesPerm'] = salesPerm;
    data['ShowPerm'] = showPerm;
    data['OutPerm'] = outPerm;
    data['AcNameKSA'] = acNameKSA;
    return data;
  }
}
