class SupplierCustomerProcessModel4 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  SupplierCustomerProcessModel4({this.dynamicList, this.numberofrecords});

  SupplierCustomerProcessModel4.fromJson(Map<String, dynamic> json) {
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
  String? proName;
  String? customerAccountName;
  double? depit;
  double? credit;
  String? sName;
  int? paperNumber;
  int? index;
  double? balance;
  String? productdes;
  String? cIName;
  String? companyName;
  double? qty;
  double? priceCurrancy;
  int? contractID;
  double? width;
  double? length;
  double? hight;
  double? secQuntity;

  DynamicList(
      {this.acName,
      this.eDID,
      this.eCode,
      this.mony,
      this.creditORDepit,
      this.eDescription,
      this.description,
      this.eDate,
      this.proName,
      this.customerAccountName,
      this.depit,
      this.credit,
      this.sName,
      this.paperNumber,
      this.index,
      this.balance,
      this.productdes,
      this.cIName,
      this.companyName,
      this.qty,
      this.priceCurrancy,
      this.contractID,
      this.width,
      this.length,
      this.hight,
      this.secQuntity});

  DynamicList.fromJson(Map<String, dynamic> json) {
    acName = json['AcName'];
    eDID = json['EDID'];
    eCode = json['ECode'];
    mony = json['Mony'];
    creditORDepit = json['CreditORDepit'];
    eDescription = json['EDescription'];
    description = json['description'];
    eDate = json['EDate'];
    proName = json['ProName'];
    customerAccountName = json['CustomerAccountName'];
    depit = json['depit'];
    credit = json['credit'];
    sName = json['SName'];
    paperNumber = json['PaperNumber'];
    index = json['index'];
    balance = json['balance'];
    productdes = json['productdes'];
    cIName = json['CIName'];
    companyName = json['CompanyName'];
    qty = json['Qty'];
    priceCurrancy = json['PriceCurrancy'];
    contractID = json['ContractID'];
    width = json['Width'];
    length = json['length'];
    hight = json['Hight'];
    secQuntity = json['SecQuntity'];
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
    data['ProName'] = proName;
    data['CustomerAccountName'] = customerAccountName;
    data['depit'] = depit;
    data['credit'] = credit;
    data['SName'] = sName;
    data['PaperNumber'] = paperNumber;
    data['index'] = index;
    data['balance'] = balance;
    data['productdes'] = productdes;
    data['CIName'] = cIName;
    data['CompanyName'] = companyName;
    data['Qty'] = qty;
    data['PriceCurrancy'] = priceCurrancy;
    data['ContractID'] = contractID;
    data['Width'] = width;
    data['length'] = length;
    data['Hight'] = hight;
    data['SecQuntity'] = secQuntity;
    return data;
  }
}
