class SupplyOrderPurchaseRequestDetailModel {
  List<DynamicListItem>? dynamicList;
  int? numberofrecords;

  SupplyOrderPurchaseRequestDetailModel({this.dynamicList, this.numberofrecords});

  SupplyOrderPurchaseRequestDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <DynamicListItem>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(DynamicListItem.fromJson(v));
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

/*class DynamicListItem {
  String? date;
  double? cost;
  int? id;
  String? requestDate;
  String? note;
  bool? confirmatoin1;
  bool? confirmation2;
  int? projectMasterId;
  int? detailId;
  int? masterId;
  double? quntity;
  double? secQuntity;
  int? unitID;
  String? proName;
  String? description;
  int? colorID;
  int? sizeID;
  double? length;
  int? employeeId;
  double? width;
  double? hight;
  int? productId;
  String? cName;
  String? uName;
  int? purchaseOrderId;
  int? productProcessItemId;
  int? supplierOrderId;
  int? comID;
  String? employeeNameA;
  double? totalCost;
  int? projectId;
  int? contractDetailTreeItemId;
  int? detailItemID;
  String? projectName;
  String? constructionItemName;
  String? mainTreeItemsName;
  int? supplyOrderDetailId;
  int? createdBy;
  String? createdAt;
  int? modifiedBy;
  String? modifyAt;
  String? note1;
  String? note2;
  int? serialNumber;

  DynamicListItem(
      {this.date,
      this.cost,
      this.id,
      this.requestDate,
      this.note,
      this.confirmatoin1,
      this.confirmation2,
      this.projectMasterId,
      this.detailId,
      this.masterId,
      this.quntity,
      this.secQuntity,
      this.unitID,
      this.proName,
      this.description,
      this.colorID,
      this.sizeID,
      this.length,
      this.employeeId,
      this.width,
      this.hight,
      this.productId,
      this.cName,
      this.uName,
      this.purchaseOrderId,
      this.productProcessItemId,
      this.supplierOrderId,
      this.comID,
      this.employeeNameA,
      this.totalCost,
      this.projectId,
      this.contractDetailTreeItemId,
      this.detailItemID,
      this.projectName,
      this.constructionItemName,
      this.mainTreeItemsName,
      this.supplyOrderDetailId,
      this.createdBy,
      this.createdAt,
      this.modifiedBy,
      this.modifyAt,
      this.note1,
      this.note2,
      this.serialNumber});

  DynamicListItem.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    cost = json['cost'];
    id = json['Id'];
    requestDate = json['RequestDate'];
    note = json['Note'];
    confirmatoin1 = json['Confirmatoin1'];
    confirmation2 = json['Confirmation2'];
    projectMasterId = json['ProjectMasterId'];
    detailId = json['detailId'];
    masterId = json['masterId'];
    quntity = json['Quntity'];
    secQuntity = json['SecQuntity'];
    unitID = json['UnitID'];
    proName = json['ProName'];
    description = json['Description'];
    colorID = json['ColorID'];
    sizeID = json['SizeID'];
    length = json['length'];
    employeeId = json['employeeId'];
    width = json['Width'];
    hight = json['Hight'];
    productId = json['ProductId'];
    cName = json['CName'];
    uName = json['UName'];
    purchaseOrderId = json['PurchaseOrderId'];
    productProcessItemId = json['ProductProcessItemId'];
    supplierOrderId = json['SupplierOrderId'];
    comID = json['ComID'];
    employeeNameA = json['EmployeeNameA'];
    totalCost = json['TotalCost'];
    projectId = json['ProjectId'];
    contractDetailTreeItemId = json['ContractDetailTreeItemId'];
    detailItemID = json['DetailItemID'];
    projectName = json['ProjectName'];
    constructionItemName = json['ConstructionItemName'];
    mainTreeItemsName = json['MainTreeItemsName'];
    supplyOrderDetailId = json['SupplyOrderDetailId'];
    createdBy = json['CreatedBy'];
    createdAt = json['CreatedAt'];
    modifiedBy = json['ModifiedBy'];
    modifyAt = json['ModifyAt'];
    note1 = json['Note1'];
    note2 = json['Note2'];
    serialNumber = json['SerialNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['cost'] = cost;
    data['Id'] = id;
    data['RequestDate'] = requestDate;
    data['Note'] = note;
    data['Confirmatoin1'] = confirmatoin1;
    data['Confirmation2'] = confirmation2;
    data['ProjectMasterId'] = projectMasterId;
    data['detailId'] = detailId;
    data['masterId'] = masterId;
    data['Quntity'] = quntity;
    data['SecQuntity'] = secQuntity;
    data['UnitID'] = unitID;
    data['ProName'] = proName;
    data['Description'] = description;
    data['ColorID'] = colorID;
    data['SizeID'] = sizeID;
    data['length'] = length;
    data['employeeId'] = employeeId;
    data['Width'] = width;
    data['Hight'] = hight;
    data['ProductId'] = productId;
    data['CName'] = cName;
    data['UName'] = uName;
    data['PurchaseOrderId'] = purchaseOrderId;
    data['ProductProcessItemId'] = productProcessItemId;
    data['SupplierOrderId'] = supplierOrderId;
    data['ComID'] = comID;
    data['EmployeeNameA'] = employeeNameA;
    data['TotalCost'] = totalCost;
    data['ProjectId'] = projectId;
    data['ContractDetailTreeItemId'] = contractDetailTreeItemId;
    data['DetailItemID'] = detailItemID;
    data['ProjectName'] = projectName;
    data['ConstructionItemName'] = constructionItemName;
    data['MainTreeItemsName'] = mainTreeItemsName;
    data['SupplyOrderDetailId'] = supplyOrderDetailId;
    data['CreatedBy'] = createdBy;
    data['CreatedAt'] = createdAt;
    data['ModifiedBy'] = modifiedBy;
    data['ModifyAt'] = modifyAt;
    data['Note1'] = note1;
    data['Note2'] = note2;
    data['SerialNumber'] = serialNumber;
    return data;
  }
}*/
class DynamicListItem {
  int? id;
  int? supplierOrderId;
  String? sOMName;
  String? date;
  String? requestDate;
  int? detailID;
  int? purchaseRequestDetailId;
  int? masterId;
  String? cName;
  String? uName;
  String? employeeNameA;
  int? productId;
  String? proName;
  int? colorID;
  int? sizeID;
  double? length;
  double? width;
  double? hight;
  double? secQuntity;
  double? originalQuantity;
  double? pulledQuantity;
  double? remainingQuantity;
  int? customerID;
  String? customerAccountName;
  String? oMName;
  int? offerMasterID;
  double? proPrice;
  double? proCost;
  int? projectId;
  String? projectName;
  int? projectDetailId;
  int? contractDetailTreeItemId;
  int? detailItemID;
  String? note1;
  String? note2;

  DynamicListItem(
      {this.id,
      this.supplierOrderId,
      this.sOMName,
      this.date,
      this.requestDate,
      this.detailID,
      this.purchaseRequestDetailId,
      this.masterId,
      this.cName,
      this.uName,
      this.employeeNameA,
      this.productId,
      this.proName,
      this.colorID,
      this.sizeID,
      this.length,
      this.width,
      this.hight,
      this.secQuntity,
      this.originalQuantity,
      this.pulledQuantity,
      this.remainingQuantity,
      this.customerID,
      this.customerAccountName,
      this.oMName,
      this.offerMasterID,
      this.proPrice,
      this.proCost,
      this.projectId,
      this.projectName,
      this.projectDetailId,
      this.contractDetailTreeItemId,
      this.detailItemID,
      this.note1,
      this.note2});

  DynamicListItem.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    supplierOrderId = json['SupplierOrderId'];
    sOMName = json['SOMName'];
    date = json['Date'];
    requestDate = json['RequestDate'];
    detailID = json['DetailID'];
    purchaseRequestDetailId = json['PurchaseRequestDetailId'];
    masterId = json['masterId'];
    cName = json['CName'];
    uName = json['UName'];
    employeeNameA = json['EmployeeNameA'];
    productId = json['productId'];
    proName = json['ProName'];
    colorID = json['ColorID'];
    sizeID = json['SizeID'];
    length = json['length'];
    width = json['Width'];
    hight = json['Hight'];
    secQuntity = json['SecQuntity'];
    originalQuantity = json['OriginalQuantity'];
    pulledQuantity = json['PulledQuantity'];
    remainingQuantity = json['RemainingQuantity'];
    customerID = json['CustomerID'];
    customerAccountName = json['CustomerAccountName'];
    oMName = json['OMName'];
    offerMasterID = json['OfferMasterID'];
    proPrice = json['ProPrice'];
    proCost = json['ProCost'];
    projectId = json['projectId'];
    projectName = json['projectName'];
    projectDetailId = json['ProjectDetailId'];
    contractDetailTreeItemId = json['ContractDetailTreeItemId'];
    detailItemID = json['DetailItemID'];
    note1 = json['Note1'];
    note2 = json['Note2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['SupplierOrderId'] = supplierOrderId;
    data['SOMName'] = sOMName;
    data['Date'] = date;
    data['RequestDate'] = requestDate;
    data['DetailID'] = detailID;
    data['PurchaseRequestDetailId'] = purchaseRequestDetailId;
    data['masterId'] = masterId;
    data['CName'] = cName;
    data['UName'] = uName;
    data['EmployeeNameA'] = employeeNameA;
    data['productId'] = productId.toString();
    data['ProName'] = proName;
    data['ColorID'] = colorID;
    data['SizeID'] = sizeID;
    data['length'] = length;
    data['Width'] = width;
    data['Hight'] = hight;
    data['SecQuntity'] = secQuntity;
    data['OriginalQuantity'] = originalQuantity;
    data['PulledQuantity'] = pulledQuantity;
    data['RemainingQuantity'] = remainingQuantity;
    data['CustomerID'] = customerID;
    data['CustomerAccountName'] = customerAccountName;
    data['OMName'] = oMName;
    data['OfferMasterID'] = offerMasterID;
    data['ProPrice'] = proPrice;
    data['ProCost'] = proCost;
    data['projectId'] = projectId;
    data['projectName'] = projectName;
    data['ProjectDetailId'] = projectDetailId;
    data['ContractDetailTreeItemId'] = contractDetailTreeItemId;
    data['DetailItemID'] = detailItemID;
    data['Note1'] = note1;
    data['Note2'] = note2;
    return data;
  }
}
