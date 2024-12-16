class SupplierProcessModel4 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  SupplierProcessModel4({this.dynamicList, this.numberofrecords});

  SupplierProcessModel4.fromJson(Map<String, dynamic> json) {
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
  int? projectID;
  String? projectName;
  int? supplierID;
  String? supplierName;
  int? extractionMasterID;
  String? extractionMasterName;
  String? extractionDate;
  int? comID;
  int? contractMasterID;
  double? extractionQuantity;
  double? extractionPrice;
  double? contractQuantity;
  double? contractPrice;
  int? extactionPercentageFromProject;

  DynamicList(
      {this.projectID,
      this.projectName,
      this.supplierID,
      this.supplierName,
      this.extractionMasterID,
      this.extractionMasterName,
      this.extractionDate,
      this.comID,
      this.contractMasterID,
      this.extractionQuantity,
      this.extractionPrice,
      this.contractQuantity,
      this.contractPrice,
      this.extactionPercentageFromProject});

  DynamicList.fromJson(Map<String, dynamic> json) {
    projectID = json['ProjectID'];
    projectName = json['ProjectName'];
    supplierID = json['SupplierID'];
    supplierName = json['SupplierName'];
    extractionMasterID = json['ExtractionMasterID'];
    extractionMasterName = json['ExtractionMasterName'];
    extractionDate = json['ExtractionDate'];
    comID = json['ComID'];
    contractMasterID = json['ContractMasterID'];
    extractionQuantity = json['ExtractionQuantity'];
    extractionPrice = json['ExtractionPrice'];
    contractQuantity = json['ContractQuantity'];
    contractPrice = json['ContractPrice'];
    extactionPercentageFromProject = json['ExtactionPercentageFromProject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProjectID'] = projectID;
    data['ProjectName'] = projectName;
    data['SupplierID'] = supplierID;
    data['SupplierName'] = supplierName;
    data['ExtractionMasterID'] = extractionMasterID;
    data['ExtractionMasterName'] = extractionMasterName;
    data['ExtractionDate'] = extractionDate;
    data['ComID'] = comID;
    data['ContractMasterID'] = contractMasterID;
    data['ExtractionQuantity'] = extractionQuantity;
    data['ExtractionPrice'] = extractionPrice;
    data['ContractQuantity'] = contractQuantity;
    data['ContractPrice'] = contractPrice;
    data['ExtactionPercentageFromProject'] = extactionPercentageFromProject;
    return data;
  }
}
