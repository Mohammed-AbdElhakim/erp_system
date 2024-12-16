class SupplierProcessModel3 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  SupplierProcessModel3({this.dynamicList, this.numberofrecords});

  SupplierProcessModel3.fromJson(Map<String, dynamic> json) {
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
  int? extactionPercentageFromProject;
  int? extractionFromContract;
  int? contractFromProject;
  int? projectID;
  String? projectName;
  int? supplierID;
  String? supplierName;
  int? extractionMasterID;
  String? extractionMasterName;
  int? comID;
  int? extractionID;
  String? extractionName;
  String? extractionDescription;
  double? extractionQuantity;
  double? extractionPrice;
  int? contractMasterID;
  int? contractDetailID;
  double? contractQuantity;
  double? contractPrice;
  String? delvarydate;
  String? contractDate;
  String? extractionDate;
  int? constructionItemID;

  DynamicList(
      {this.extactionPercentageFromProject,
      this.extractionFromContract,
      this.contractFromProject,
      this.projectID,
      this.projectName,
      this.supplierID,
      this.supplierName,
      this.extractionMasterID,
      this.extractionMasterName,
      this.comID,
      this.extractionID,
      this.extractionName,
      this.extractionDescription,
      this.extractionQuantity,
      this.extractionPrice,
      this.contractMasterID,
      this.contractDetailID,
      this.contractQuantity,
      this.contractPrice,
      this.delvarydate,
      this.contractDate,
      this.extractionDate,
      this.constructionItemID});

  DynamicList.fromJson(Map<String, dynamic> json) {
    extactionPercentageFromProject = json['ExtactionPercentageFromProject'];
    extractionFromContract = json['ExtractionFromContract'];
    contractFromProject = json['ContractFromProject'];
    projectID = json['ProjectID'];
    projectName = json['ProjectName'];
    supplierID = json['SupplierID'];
    supplierName = json['SupplierName'];
    extractionMasterID = json['ExtractionMasterID'];
    extractionMasterName = json['ExtractionMasterName'];
    comID = json['ComID'];
    extractionID = json['ExtractionID'];
    extractionName = json['ExtractionName'];
    extractionDescription = json['ExtractionDescription'];
    extractionQuantity = json['ExtractionQuantity'];
    extractionPrice = json['ExtractionPrice'];
    contractMasterID = json['ContractMasterID'];
    contractDetailID = json['ContractDetailID'];
    contractQuantity = json['ContractQuantity'];
    contractPrice = json['ContractPrice'];
    delvarydate = json['Delvarydate'];
    contractDate = json['ContractDate'];
    extractionDate = json['ExtractionDate'];
    constructionItemID = json['ConstructionItemID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ExtactionPercentageFromProject'] = extactionPercentageFromProject;
    data['ExtractionFromContract'] = extractionFromContract;
    data['ContractFromProject'] = contractFromProject;
    data['ProjectID'] = projectID;
    data['ProjectName'] = projectName;
    data['SupplierID'] = supplierID;
    data['SupplierName'] = supplierName;
    data['ExtractionMasterID'] = extractionMasterID;
    data['ExtractionMasterName'] = extractionMasterName;
    data['ComID'] = comID;
    data['ExtractionID'] = extractionID;
    data['ExtractionName'] = extractionName;
    data['ExtractionDescription'] = extractionDescription;
    data['ExtractionQuantity'] = extractionQuantity;
    data['ExtractionPrice'] = extractionPrice;
    data['ContractMasterID'] = contractMasterID;
    data['ContractDetailID'] = contractDetailID;
    data['ContractQuantity'] = contractQuantity;
    data['ContractPrice'] = contractPrice;
    data['Delvarydate'] = delvarydate;
    data['ContractDate'] = contractDate;
    data['ExtractionDate'] = extractionDate;
    data['ConstructionItemID'] = constructionItemID;
    return data;
  }
}
