class CostItemAccountReportModel4 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  CostItemAccountReportModel4({this.dynamicList, this.numberofrecords});

  CostItemAccountReportModel4.fromJson(Map<String, dynamic> json) {
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
  int? eDMXID;
  String? proPrice;
  double? outquntity;
  String? sName;
  int? storeID;
  double? total;
  double? totalcost;
  String? totalprice;
  String? proName;
  int? proID;
  String? modalityName;
  String? companyName;
  int? comID;
  double? inquntity;
  String? expr1;
  double? proCost;
  String? proParent;
  String? description;
  String? prolevel;
  int? modality;
  String? iSCall;
  String? size;
  String? paymentPeriod;
  String? downPayment;
  String? delvarydate;
  String? note;
  int? unitID;
  String? secoundUnit;
  String? uName;
  String? barCode;
  String? purchCode;
  String? salesCode;
  String? cIName;
  int? cIID;

  DynamicList(
      {this.eDMXID,
      this.proPrice,
      this.outquntity,
      this.sName,
      this.storeID,
      this.total,
      this.totalcost,
      this.totalprice,
      this.proName,
      this.proID,
      this.modalityName,
      this.companyName,
      this.comID,
      this.inquntity,
      this.expr1,
      this.proCost,
      this.proParent,
      this.description,
      this.prolevel,
      this.modality,
      this.iSCall,
      this.size,
      this.paymentPeriod,
      this.downPayment,
      this.delvarydate,
      this.note,
      this.unitID,
      this.secoundUnit,
      this.uName,
      this.barCode,
      this.purchCode,
      this.salesCode,
      this.cIName,
      this.cIID});

  DynamicList.fromJson(Map<String, dynamic> json) {
    eDMXID = json['EDMXID'];
    proPrice = json['ProPrice'];
    outquntity = json['outquntity'];
    sName = json['SName'];
    storeID = json['StoreID'];
    total = json['total'];
    totalcost = json['totalcost'];
    totalprice = json['totalprice'];
    proName = json['ProName'];
    proID = json['ProID'];
    modalityName = json['ModalityName'];
    companyName = json['CompanyName'];
    comID = json['ComID'];
    inquntity = json['inquntity'];
    expr1 = json['Expr1'];
    proCost = json['ProCost'];
    proParent = json['ProParent'];
    description = json['Description'];
    prolevel = json['Prolevel'];
    modality = json['Modality'];
    iSCall = json['ISCall'];
    size = json['Size'];
    paymentPeriod = json['paymentPeriod'];
    downPayment = json['DownPayment'];
    delvarydate = json['Delvarydate'];
    note = json['Note'];
    unitID = json['UnitID'];
    secoundUnit = json['SecoundUnit'];
    uName = json['UName'];
    barCode = json['BarCode'];
    purchCode = json['PurchCode'];
    salesCode = json['SalesCode'];
    cIName = json['CIName'];
    cIID = json['CIID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EDMXID'] = eDMXID;
    data['ProPrice'] = proPrice;
    data['outquntity'] = outquntity;
    data['SName'] = sName;
    data['StoreID'] = storeID;
    data['total'] = total;
    data['totalcost'] = totalcost;
    data['totalprice'] = totalprice;
    data['ProName'] = proName;
    data['ProID'] = proID;
    data['ModalityName'] = modalityName;
    data['CompanyName'] = companyName;
    data['ComID'] = comID;
    data['inquntity'] = inquntity;
    data['Expr1'] = expr1;
    data['ProCost'] = proCost;
    data['ProParent'] = proParent;
    data['Description'] = description;
    data['Prolevel'] = prolevel;
    data['Modality'] = modality;
    data['ISCall'] = iSCall;
    data['Size'] = size;
    data['paymentPeriod'] = paymentPeriod;
    data['DownPayment'] = downPayment;
    data['Delvarydate'] = delvarydate;
    data['Note'] = note;
    data['UnitID'] = unitID;
    data['SecoundUnit'] = secoundUnit;
    data['UName'] = uName;
    data['BarCode'] = barCode;
    data['PurchCode'] = purchCode;
    data['SalesCode'] = salesCode;
    data['CIName'] = cIName;
    data['CIID'] = cIID;
    return data;
  }
}
