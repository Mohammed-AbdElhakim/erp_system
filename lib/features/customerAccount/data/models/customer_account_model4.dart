class CustomerAccountModel4 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  CustomerAccountModel4({this.dynamicList, this.numberofrecords});

  CustomerAccountModel4.fromJson(Map<String, dynamic> json) {
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
  String? acName;
  int? eDID;
  int? eCode;
  double? mony;
  bool? creditORDepit;
  String? eDescription;
  String? description;
  String? eDate;
  String? customerAccountName;
  double? depit;
  double? credit;
  int? paperNumber;
  int? index;
  double? balance;
  String? productdes;
  String? companyName;
  String? proName;
  double? qty;
  double? priceCurrancy;
  int? contractID;
  String? sName;
  String? cIName;

  DynamicList(
      {this.acName,
      this.eDID,
      this.eCode,
      this.mony,
      this.creditORDepit,
      this.eDescription,
      this.description,
      this.eDate,
      this.customerAccountName,
      this.depit,
      this.credit,
      this.paperNumber,
      this.index,
      this.balance,
      this.productdes,
      this.companyName,
      this.proName,
      this.qty,
      this.priceCurrancy,
      this.contractID,
      this.sName,
      this.cIName});

  DynamicList.fromJson(Map<String, dynamic> json) {
    acName = json['AcName'];
    eDID = json['EDID'];
    eCode = json['ECode'];
    mony = json['Mony'];
    creditORDepit = json['CreditORDepit'];
    eDescription = json['EDescription'];
    description = json['description'];
    eDate = json['EDate'];
    customerAccountName = json['CustomerAccountName'];
    depit = json['depit'];
    credit = json['credit'];
    paperNumber = json['PaperNumber'];
    index = json['index'];
    balance = json['balance'];
    productdes = json['productdes'];
    companyName = json['CompanyName'];
    proName = json['ProName'];
    qty = json['Qty'];
    priceCurrancy = json['PriceCurrancy'];
    contractID = json['ContractID'];
    sName = json['SName'];
    cIName = json['CIName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcName'] = acName;
    data['EDID'] = eDID;
    data['ECode'] = eCode;
    data['Mony'] = mony;
    data['CreditORDepit'] = creditORDepit;
    data['EDescription'] = eDescription;
    data['description'] = description;
    data['EDate'] = eDate;
    data['CustomerAccountName'] = customerAccountName;
    data['depit'] = depit;
    data['credit'] = credit;
    data['PaperNumber'] = paperNumber;
    data['index'] = index;
    data['balance'] = balance;
    data['productdes'] = productdes;
    data['CompanyName'] = companyName;
    data['ProName'] = proName;
    data['Qty'] = qty;
    data['PriceCurrancy'] = priceCurrancy;
    data['ContractID'] = contractID;
    data['SName'] = sName;
    data['CIName'] = cIName;
    return data;
  }
}
