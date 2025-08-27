class SupplyOrderPurchaseOrdersModel {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  SupplyOrderPurchaseOrdersModel({this.dynamicList, this.numberofrecords});

  SupplyOrderPurchaseOrdersModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? date;
  String? note;
  String? requestDate;
  String? employeeNameA;
  int? supplierOrderId;
  int? supplierSupplyOrderId;
  String? sOMName;
  int? customerID;
  String? customerAccountName;
  String? oMName;
  int? offerMasterID;
  int? serialNumber;
  String? projectName;

  DynamicList(
      {this.id,
      this.date,
      this.note,
      this.requestDate,
      this.employeeNameA,
      this.supplierOrderId,
      this.supplierSupplyOrderId,
      this.sOMName,
      this.customerID,
      this.customerAccountName,
      this.oMName,
      this.offerMasterID,
      this.serialNumber,
      this.projectName});

  DynamicList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    date = json['Date'];
    note = json['Note'];
    requestDate = json['RequestDate'];
    employeeNameA = json['EmployeeNameA'];
    supplierOrderId = json['SupplierOrderId'];
    supplierSupplyOrderId = json['SupplierSupplyOrderId'];
    sOMName = json['SOMName'];
    customerID = json['CustomerID'];
    customerAccountName = json['CustomerAccountName'];
    oMName = json['OMName'];
    offerMasterID = json['OfferMasterID'];
    serialNumber = json['SerialNumber'];
    projectName = json['projectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Date'] = date;
    data['Note'] = note;
    data['RequestDate'] = requestDate;
    data['EmployeeNameA'] = employeeNameA;
    data['SupplierOrderId'] = supplierOrderId;
    data['SupplierSupplyOrderId'] = supplierSupplyOrderId;
    data['SOMName'] = sOMName;
    data['CustomerID'] = customerID;
    data['CustomerAccountName'] = customerAccountName;
    data['OMName'] = oMName;
    data['OfferMasterID'] = offerMasterID;
    data['SerialNumber'] = serialNumber;
    data['projectName'] = projectName;
    return data;
  }
}
