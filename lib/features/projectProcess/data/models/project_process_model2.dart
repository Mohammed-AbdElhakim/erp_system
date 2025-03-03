class ProjectProcessModel2 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  ProjectProcessModel2({this.dynamicList, this.numberofrecords});

  ProjectProcessModel2.fromJson(Map<String, dynamic> json) {
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
  String? contractName;
  String? contractDescription;
  double? extractionQuantity;
  double? extractionPrice;
  int? contractQuantity;
  double? contractPrice;
  int? extactionPercentageFromProject;
  bool? isCustomerContract;

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
      this.contractName,
      this.contractDescription,
      this.extractionQuantity,
      this.extractionPrice,
      this.contractQuantity,
      this.contractPrice,
      this.extactionPercentageFromProject,
      this.isCustomerContract});

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
    contractName = json['ContractName'];
    contractDescription = json['ContractDescription'];
    extractionQuantity = json['ExtractionQuantity'];
    extractionPrice = json['ExtractionPrice'];
    contractQuantity = json['ContractQuantity'];
    contractPrice = json['ContractPrice'];
    extactionPercentageFromProject = json['ExtactionPercentageFromProject'];
    isCustomerContract = json['isCustomerContract'];
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
    data['ContractName'] = contractName;
    data['ContractDescription'] = contractDescription;
    data['ExtractionQuantity'] = extractionQuantity;
    data['ExtractionPrice'] = extractionPrice;
    data['ContractQuantity'] = contractQuantity;
    data['ContractPrice'] = contractPrice;
    data['ExtactionPercentageFromProject'] = extactionPercentageFromProject;
    data['isCustomerContract'] = isCustomerContract;
    return data;
  }
}
