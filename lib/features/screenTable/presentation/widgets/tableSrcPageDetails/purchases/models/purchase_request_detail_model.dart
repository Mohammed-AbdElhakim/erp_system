class PurchaseRequestDetailModel {
  List<DynamicListItem>? dynamicList;
  int? numberofrecords;

  PurchaseRequestDetailModel({this.dynamicList, this.numberofrecords});

  PurchaseRequestDetailModel.fromJson(Map<String, dynamic> json) {
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

class DynamicListItem {
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
}
