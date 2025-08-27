class PurchaseOrdersModel {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  PurchaseOrdersModel({this.dynamicList, this.numberofrecords});

  PurchaseOrdersModel.fromJson(Map<String, dynamic> json) {
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
  String? requestDate;
  String? note;
  bool? confirmatoin1;
  bool? confirmation2;
  int? employeeId;
  int? purchaseOrderId;
  int? productProcessItemId;
  int? supplierOrderId;
  String? employeeNameA;
  bool? isCustomer;
  int? serialNumber;

  DynamicList(
      {this.id,
      this.date,
      this.requestDate,
      this.note,
      this.confirmatoin1,
      this.confirmation2,
      this.employeeId,
      this.purchaseOrderId,
      this.productProcessItemId,
      this.supplierOrderId,
      this.employeeNameA,
      this.isCustomer,
      this.serialNumber});

  DynamicList.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    date = json['Date'];
    requestDate = json['RequestDate'];
    note = json['Note'];
    confirmatoin1 = json['Confirmatoin1'];
    confirmation2 = json['Confirmation2'];
    employeeId = json['employeeId'];
    purchaseOrderId = json['PurchaseOrderId'];
    productProcessItemId = json['ProductProcessItemId'];
    supplierOrderId = json['SupplierOrderId'];
    employeeNameA = json['EmployeeNameA'];
    isCustomer = json['IsCustomer'];
    serialNumber = json['SerialNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Date'] = date;
    data['RequestDate'] = requestDate;
    data['Note'] = note;
    data['Confirmatoin1'] = confirmatoin1;
    data['Confirmation2'] = confirmation2;
    data['employeeId'] = employeeId;
    data['PurchaseOrderId'] = purchaseOrderId;
    data['ProductProcessItemId'] = productProcessItemId;
    data['SupplierOrderId'] = supplierOrderId;
    data['EmployeeNameA'] = employeeNameA;
    data['IsCustomer'] = isCustomer;
    data['SerialNumber'] = serialNumber;
    return data;
  }
}
