class StoreShowModel {
  List<StoreShowItem>? dynamicList;
  int? numberofrecords;

  StoreShowModel({this.dynamicList, this.numberofrecords});

  StoreShowModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <StoreShowItem>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(StoreShowItem.fromJson(v));
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

class StoreShowItem {
  int? eDMXID;
  double? outquntity;
  String? sName;
  int? storeID;
  double? total;
  double? totalcost;
  String? proName;
  int? proID;
  String? modalityName;
  String? companyName;
  int? comID;
  double? inquntity;
  double? proCost;
  int? modality;
  int? unitID;
  String? uName;
  int? companyID;
  String? showPerm;
  double? proPrice;
  double? totalprice;
  double? expr1;
  int? secoundUnit;
  int? proParent;
  String? note;
  String? barCode;
  String? purchCode;
  int? supplierID;
  int? colorID;
  int? sizeID;

  StoreShowItem(
      {this.eDMXID,
      this.outquntity,
      this.sName,
      this.storeID,
      this.total,
      this.totalcost,
      this.proName,
      this.proID,
      this.modalityName,
      this.companyName,
      this.comID,
      this.inquntity,
      this.proCost,
      this.modality,
      this.unitID,
      this.uName,
      this.companyID,
      this.showPerm,
      this.proPrice,
      this.totalprice,
      this.expr1,
      this.secoundUnit,
      this.proParent,
      this.note,
      this.barCode,
      this.purchCode,
      this.supplierID,
      this.colorID,
      this.sizeID});

  StoreShowItem.fromJson(Map<String, dynamic> json) {
    eDMXID = json['EDMXID'];
    outquntity = json['outquntity'];
    sName = json['SName'];
    storeID = json['StoreID'];
    total = json['total'];
    totalcost = json['totalcost'];
    proName = json['ProName'];
    proID = json['ProID'];
    modalityName = json['ModalityName'];
    companyName = json['CompanyName'];
    comID = json['ComID'];
    inquntity = json['inquntity'];
    proCost = json['ProCost'];
    modality = json['Modality'];
    unitID = json['UnitID'];
    uName = json['UName'];
    companyID = json['CompanyID'];
    showPerm = json['ShowPerm'];
    proPrice = json['ProPrice'];
    totalprice = json['totalprice'];
    expr1 = json['Expr1'];
    secoundUnit = json['SecoundUnit'];
    proParent = json['ProParent'];
    note = json['Note'];
    barCode = json['BarCode'];
    purchCode = json['PurchCode'];
    supplierID = json['SupplierID'];
    colorID = json['ColorID'];
    sizeID = json['SizeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EDMXID'] = eDMXID;
    data['outquntity'] = outquntity;
    data['SName'] = sName;
    data['StoreID'] = storeID;
    data['total'] = total;
    data['totalcost'] = totalcost;
    data['ProName'] = proName;
    data['ProID'] = proID;
    data['ModalityName'] = modalityName;
    data['CompanyName'] = companyName;
    data['ComID'] = comID;
    data['inquntity'] = inquntity;
    data['ProCost'] = proCost;
    data['Modality'] = modality;
    data['UnitID'] = unitID;
    data['UName'] = uName;
    data['CompanyID'] = companyID;
    data['ShowPerm'] = showPerm;
    data['ProPrice'] = proPrice;
    data['totalprice'] = totalprice;
    data['Expr1'] = expr1;
    data['SecoundUnit'] = secoundUnit;
    data['ProParent'] = proParent;
    data['Note'] = note;
    data['BarCode'] = barCode;
    data['PurchCode'] = purchCode;
    data['SupplierID'] = supplierID;
    data['ColorID'] = colorID;
    data['SizeID'] = sizeID;
    return data;
  }
}
