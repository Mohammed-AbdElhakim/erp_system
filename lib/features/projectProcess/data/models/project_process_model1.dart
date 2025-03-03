class ProjectProcessModel1 {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  ProjectProcessModel1({this.dynamicList, this.numberofrecords});

  ProjectProcessModel1.fromJson(Map<String, dynamic> json) {
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
  String? contractName;
  String? contractDescription;
  int? itemID;
  String? itemName;
  String? itemDescription;
  int? contractDetailID;
  double? contractQuantity;
  int? contractPrice;
  int? mainItemID;
  String? mainItemName;
  String? delvarydate;
  String? contractDate;
  String? extractionDate;
  bool? isCustomerContract;
  int? constructionItemID;
  int? contractDetailTreeItemId;
  int? customerOwnerID;

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
      this.contractName,
      this.contractDescription,
      this.itemID,
      this.itemName,
      this.itemDescription,
      this.contractDetailID,
      this.contractQuantity,
      this.contractPrice,
      this.mainItemID,
      this.mainItemName,
      this.delvarydate,
      this.contractDate,
      this.extractionDate,
      this.isCustomerContract,
      this.constructionItemID,
      this.contractDetailTreeItemId,
      this.customerOwnerID});

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
    contractName = json['ContractName'];
    contractDescription = json['ContractDescription'];
    itemID = json['ItemID'];
    itemName = json['ItemName'];
    itemDescription = json['ItemDescription'];
    contractDetailID = json['ContractDetailID'];
    contractQuantity = json['ContractQuantity'];
    contractPrice = json['ContractPrice'];
    mainItemID = json['MainItemID'];
    mainItemName = json['MainItemName'];
    delvarydate = json['Delvarydate'];
    contractDate = json['ContractDate'];
    extractionDate = json['ExtractionDate'];
    isCustomerContract = json['IsCustomerContract'];
    constructionItemID = json['ConstructionItemID'];
    contractDetailTreeItemId = json['ContractDetailTreeItemId'];
    customerOwnerID = json['CustomerOwnerID'];
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
    data['ContractName'] = contractName;
    data['ContractDescription'] = contractDescription;
    data['ItemID'] = itemID;
    data['ItemName'] = itemName;
    data['ItemDescription'] = itemDescription;
    data['ContractDetailID'] = contractDetailID;
    data['ContractQuantity'] = contractQuantity;
    data['ContractPrice'] = contractPrice;
    data['MainItemID'] = mainItemID;
    data['MainItemName'] = mainItemName;
    data['Delvarydate'] = delvarydate;
    data['ContractDate'] = contractDate;
    data['ExtractionDate'] = extractionDate;
    data['IsCustomerContract'] = isCustomerContract;
    data['ConstructionItemID'] = constructionItemID;
    data['ContractDetailTreeItemId'] = contractDetailTreeItemId;
    data['CustomerOwnerID'] = customerOwnerID;
    return data;
  }
}
