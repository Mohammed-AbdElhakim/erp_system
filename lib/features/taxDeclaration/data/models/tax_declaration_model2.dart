class TaxDeclarationModel2 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  TaxDeclarationModel2({this.dynamicList, this.numberofrecords});

  TaxDeclarationModel2.fromJson(Map<String, dynamic> json) {
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
  int? eDID;
  String? eDescription;
  double? mony;
  double? depit;
  double? credit;
  bool? creditORDepit;
  int? eCode;
  int? comID;
  int? customerAccountID;
  String? customerAccountName;
  String? customerDepartment;
  int? contractID;
  int? autoNumber;
  String? acName;
  String? eDate;
  bool? isPurchase;
  bool? isSales;
  String? tCName;
  int? tCID;

  DynamicList(
      {this.eDID,
      this.eDescription,
      this.mony,
      this.depit,
      this.credit,
      this.creditORDepit,
      this.eCode,
      this.comID,
      this.customerAccountID,
      this.customerAccountName,
      this.customerDepartment,
      this.contractID,
      this.autoNumber,
      this.acName,
      this.eDate,
      this.isPurchase,
      this.isSales,
      this.tCName,
      this.tCID});

  DynamicList.fromJson(Map<String, dynamic> json) {
    eDID = json['EDID'];
    eDescription = json['EDescription'];
    mony = json['Mony'];
    depit = json['Depit'];
    credit = json['Credit'];
    creditORDepit = json['CreditORDepit'];
    eCode = json['ECode'];
    comID = json['ComID'];
    customerAccountID = json['CustomerAccountID'];
    customerAccountName = json['CustomerAccountName'];
    customerDepartment = json['CustomerDepartment'];
    contractID = json['ContractID'];
    autoNumber = json['AutoNumber'];
    acName = json['AcName'];
    eDate = json['EDate'];
    isPurchase = json['IsPurchase'];
    isSales = json['IsSales'];
    tCName = json['TCName'];
    tCID = json['TCID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EDID'] = eDID;
    data['EDescription'] = eDescription;
    data['Mony'] = mony;
    data['Depit'] = depit;
    data['Credit'] = credit;
    data['CreditORDepit'] = creditORDepit;
    data['ECode'] = eCode;
    data['ComID'] = comID;
    data['CustomerAccountID'] = customerAccountID;
    data['CustomerAccountName'] = customerAccountName;
    data['CustomerDepartment'] = customerDepartment;
    data['ContractID'] = contractID;
    data['AutoNumber'] = autoNumber;
    data['AcName'] = acName;
    data['EDate'] = eDate;
    data['IsPurchase'] = isPurchase;
    data['IsSales'] = isSales;
    data['TCName'] = tCName;
    data['TCID'] = tCID;
    return data;
  }
}
