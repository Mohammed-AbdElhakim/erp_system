class TaxDeclarationModel1 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  TaxDeclarationModel1({this.dynamicList, this.numberofrecords});

  TaxDeclarationModel1.fromJson(Map<String, dynamic> json) {
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
  int? supplierID;
  String? sName;
  int? purchaseID;
  int? pONumber;
  String? acName;
  String? eDate;
  bool? isPurchase;
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
      this.supplierID,
      this.sName,
      this.purchaseID,
      this.pONumber,
      this.acName,
      this.eDate,
      this.isPurchase,
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
    supplierID = json['SupplierID'];
    sName = json['SName'];
    purchaseID = json['PurchaseID'];
    pONumber = json['PONumber'];
    acName = json['AcName'];
    eDate = json['EDate'];
    isPurchase = json['IsPurchase'];
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
    data['SupplierID'] = supplierID;
    data['SName'] = sName;
    data['PurchaseID'] = purchaseID;
    data['PONumber'] = pONumber;
    data['AcName'] = acName;
    data['EDate'] = eDate;
    data['IsPurchase'] = isPurchase;
    data['TCName'] = tCName;
    data['TCID'] = tCID;
    return data;
  }
}
