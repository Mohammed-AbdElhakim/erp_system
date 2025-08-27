class ProductViewModel {
  List<DynamicListProduct>? dynamicListProduct;
  int? numberofrecords;

  ProductViewModel({this.dynamicListProduct, this.numberofrecords});

  ProductViewModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicListProduct = <DynamicListProduct>[];
      json['dynamicList'].forEach((v) {
        dynamicListProduct!.add(DynamicListProduct.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dynamicListProduct != null) {
      data['dynamicList'] = dynamicListProduct!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class DynamicListProduct {
  int? eDMXID;
  int? programID;
  String? eInvoiceCodeType;
  String? eInvoiceCode;
  double? secPrice;
  String? glassSecoretPrice;
  String? glassRawPrice;
  String? glassRentPrice;
  String? notAvaliable;
  int? proID;
  String? proName;
  String? rank;
  String? distributionPercent;
  double? proPrice;
  double? proCost;
  int? proParent;
  String? description;
  int? sizeVector;
  int? prolevel;
  int? modality;
  String? iSCall;
  double? size;
  String? modalityName;
  int? comID;
  String? companyName;
  String? parent;
  String? sName;
  String? paymentPeriod;
  double? downPayment;
  String? delvarydate;
  String? startDate;
  int? customerAccountID;
  String? roomCount;
  String? parking;
  String? note;
  int? supplierID;
  String? supplierPercent;
  String? supplierMony;
  bool? isSell;
  int? govID;
  int? pIndex;
  String? internationalCode;
  String? localCode;
  String? productCode;
  String? createDate;
  String? monthsNumber;
  String? isLocal;
  bool? iSQuntity;
  bool? iSInventory;
  bool? iSService;
  bool? isSerial;
  bool? iSSales;
  bool? saleMoreOne;
  String? iSContractSale;
  bool? iSPrimary;
  bool? iSExpierd;
  bool? iSserviceCntract;
  bool? iSPurchase;
  String? uName;
  int? uIndex;
  int? unitID;
  String? costtype;
  String? barCode;
  String? purchCode;
  String? salesCode;
  String? secoundPrice;
  String? cName;
  int? colorID;
  int? sizeID;
  int? dimantionID;
  int? matrialID;
  bool? isColor;
  bool? isSize;
  int? categoryID;
  String? isDimantion;
  String? proNameEShortCut;
  String? proNameE;
  String? categoryName;
  String? colorName;
  String? sizeName;
  String? dName;
  String? mName;
  String? mNameE;
  String? mNameShortCut;
  String? sizeNameE;
  String? sizeNameShortCut;
  String? colorNameE;
  String? colorNameShortCut;
  String? categoryNameE;
  int? companyID;
  String? categoryNameSortCut;
  String? length;
  double? width;
  double? hight;
  String? density;
  String? isDetailsOnDisplay;
  String? expireDate;
  String? unitsInMasterUnit;
  String? dropDownSearch;
  String? isSurgery;
  int? costitemId;
  double? uQuntity;
  int? secoundUnit;
  String? profitMargin;
  double? prevPurchasePrice;
  String? printdate;
  String? closeSchema;
  int? departementID;
  int? productAutoCode;
  String? proAutoCodeWithModality;

  DynamicListProduct(
      {this.eDMXID,
      this.programID,
      this.eInvoiceCodeType,
      this.eInvoiceCode,
      this.secPrice,
      this.glassSecoretPrice,
      this.glassRawPrice,
      this.glassRentPrice,
      this.notAvaliable,
      this.proID,
      this.proName,
      this.rank,
      this.distributionPercent,
      this.proPrice,
      this.proCost,
      this.proParent,
      this.description,
      this.sizeVector,
      this.prolevel,
      this.modality,
      this.iSCall,
      this.size,
      this.modalityName,
      this.comID,
      this.companyName,
      this.parent,
      this.sName,
      this.paymentPeriod,
      this.downPayment,
      this.delvarydate,
      this.startDate,
      this.customerAccountID,
      this.roomCount,
      this.parking,
      this.note,
      this.supplierID,
      this.supplierPercent,
      this.supplierMony,
      this.isSell,
      this.govID,
      this.pIndex,
      this.internationalCode,
      this.localCode,
      this.productCode,
      this.createDate,
      this.monthsNumber,
      this.isLocal,
      this.iSQuntity,
      this.iSInventory,
      this.iSService,
      this.isSerial,
      this.iSSales,
      this.saleMoreOne,
      this.iSContractSale,
      this.iSPrimary,
      this.iSExpierd,
      this.iSserviceCntract,
      this.iSPurchase,
      this.uName,
      this.uIndex,
      this.unitID,
      this.costtype,
      this.barCode,
      this.purchCode,
      this.salesCode,
      this.secoundPrice,
      this.cName,
      this.colorID,
      this.sizeID,
      this.dimantionID,
      this.matrialID,
      this.isColor,
      this.isSize,
      this.categoryID,
      this.isDimantion,
      this.proNameEShortCut,
      this.proNameE,
      this.categoryName,
      this.colorName,
      this.sizeName,
      this.dName,
      this.mName,
      this.mNameE,
      this.mNameShortCut,
      this.sizeNameE,
      this.sizeNameShortCut,
      this.colorNameE,
      this.colorNameShortCut,
      this.categoryNameE,
      this.companyID,
      this.categoryNameSortCut,
      this.length,
      this.width,
      this.hight,
      this.density,
      this.isDetailsOnDisplay,
      this.expireDate,
      this.unitsInMasterUnit,
      this.dropDownSearch,
      this.isSurgery,
      this.costitemId,
      this.uQuntity,
      this.secoundUnit,
      this.profitMargin,
      this.prevPurchasePrice,
      this.printdate,
      this.closeSchema,
      this.departementID,
      this.productAutoCode,
      this.proAutoCodeWithModality});

  DynamicListProduct.fromJson(Map<String, dynamic> json) {
    eDMXID = json['EDMXID'];
    programID = json['ProgramID'];
    eInvoiceCodeType = json['EInvoiceCodeType'];
    eInvoiceCode = json['EInvoiceCode'];
    secPrice = json['SecPrice'];
    glassSecoretPrice = json['GlassSecoretPrice'];
    glassRawPrice = json['GlassRawPrice'];
    glassRentPrice = json['GlassRentPrice'];
    notAvaliable = json['NotAvaliable'];
    proID = json['ProID'];
    proName = json['ProName'];
    rank = json['rank'];
    distributionPercent = json['DistributionPercent'];
    proPrice = json['ProPrice'];
    proCost = json['ProCost'];
    proParent = json['ProParent'];
    description = json['Description'];
    sizeVector = json['SizeVector'];
    prolevel = json['Prolevel'];
    modality = json['Modality'];
    iSCall = json['ISCall'];
    size = json['Size'];
    modalityName = json['ModalityName'];
    comID = json['ComID'];
    companyName = json['CompanyName'];
    parent = json['parent'];
    sName = json['SName'];
    paymentPeriod = json['paymentPeriod'];
    downPayment = json['DownPayment'];
    delvarydate = json['Delvarydate'];
    startDate = json['StartDate'];
    customerAccountID = json['CustomerAccountID'];
    roomCount = json['RoomCount'];
    parking = json['Parking'];
    note = json['Note'];
    supplierID = json['SupplierID'];
    supplierPercent = json['SupplierPercent'];
    supplierMony = json['SupplierMony'];
    isSell = json['IsSell'];
    govID = json['GovID'];
    pIndex = json['PIndex'];
    internationalCode = json['InternationalCode'];
    localCode = json['LocalCode'];
    productCode = json['ProductCode'];
    createDate = json['CreateDate'];
    monthsNumber = json['MonthsNumber'];
    isLocal = json['IsLocal'];
    iSQuntity = json['ISQuntity'];
    iSInventory = json['ISInventory'];
    iSService = json['ISService'];
    isSerial = json['IsSerial'];
    iSSales = json['ISSales'];
    saleMoreOne = json['SaleMoreOne'];
    iSContractSale = json['ISContractSale'];
    iSPrimary = json['ISPrimary'];
    iSExpierd = json['ISExpierd'];
    iSserviceCntract = json['ISserviceCntract'];
    iSPurchase = json['ISPurchase'];
    uName = json['UName'];
    uIndex = json['UIndex'];
    unitID = json['UnitID'];
    costtype = json['Costtype'];
    barCode = json['BarCode'];
    purchCode = json['PurchCode'];
    salesCode = json['SalesCode'];
    secoundPrice = json['SecoundPrice'];
    cName = json['CName'];
    colorID = json['ColorID'];
    sizeID = json['SizeID'];
    dimantionID = json['DimantionID'];
    matrialID = json['MatrialID'];
    isColor = json['IsColor'];
    isSize = json['IsSize'];
    categoryID = json['CategoryID'];
    isDimantion = json['IsDimantion'];
    proNameEShortCut = json['ProNameEShortCut'];
    proNameE = json['ProNameE'];
    categoryName = json['CategoryName'];
    colorName = json['ColorName'];
    sizeName = json['SizeName'];
    dName = json['DName'];
    mName = json['MName'];
    mNameE = json['MNameE'];
    mNameShortCut = json['MNameShortCut'];
    sizeNameE = json['SizeNameE'];
    sizeNameShortCut = json['SizeNameShortCut'];
    colorNameE = json['ColorNameE'];
    colorNameShortCut = json['ColorNameShortCut'];
    categoryNameE = json['CategoryNameE'];
    companyID = json['CompanyID'];
    categoryNameSortCut = json['CategoryNameSortCut'];
    length = json['length'];
    width = json['Width'];
    hight = json['Hight'];
    density = json['Density'];
    isDetailsOnDisplay = json['IsDetailsOnDisplay'];
    expireDate = json['ExpireDate'];
    unitsInMasterUnit = json['UnitsInMasterUnit'];
    dropDownSearch = json['DropDownSearch'];
    isSurgery = json['IsSurgery'];
    costitemId = json['costitemId'];
    uQuntity = json['UQuntity'];
    secoundUnit = json['SecoundUnit'];
    profitMargin = json['ProfitMargin'];
    prevPurchasePrice = json['PrevPurchasePrice'];
    printdate = json['printdate'];
    closeSchema = json['CloseSchema'];
    departementID = json['DepartementID'];
    productAutoCode = json['ProductAutoCode'];
    proAutoCodeWithModality = json['ProAutoCodeWithModality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EDMXID'] = eDMXID;
    data['ProgramID'] = programID;
    data['EInvoiceCodeType'] = eInvoiceCodeType;
    data['EInvoiceCode'] = eInvoiceCode;
    data['SecPrice'] = secPrice;
    data['GlassSecoretPrice'] = glassSecoretPrice;
    data['GlassRawPrice'] = glassRawPrice;
    data['GlassRentPrice'] = glassRentPrice;
    data['NotAvaliable'] = notAvaliable;
    data['ProID'] = proID;
    data['ProName'] = proName;
    data['rank'] = rank;
    data['DistributionPercent'] = distributionPercent;
    data['ProPrice'] = proPrice;
    data['ProCost'] = proCost;
    data['ProParent'] = proParent;
    data['Description'] = description;
    data['SizeVector'] = sizeVector;
    data['Prolevel'] = prolevel;
    data['Modality'] = modality;
    data['ISCall'] = iSCall;
    data['Size'] = size;
    data['ModalityName'] = modalityName;
    data['ComID'] = comID;
    data['CompanyName'] = companyName;
    data['parent'] = parent;
    data['SName'] = sName;
    data['paymentPeriod'] = paymentPeriod;
    data['DownPayment'] = downPayment;
    data['Delvarydate'] = delvarydate;
    data['StartDate'] = startDate;
    data['CustomerAccountID'] = customerAccountID;
    data['RoomCount'] = roomCount;
    data['Parking'] = parking;
    data['Note'] = note;
    data['SupplierID'] = supplierID;
    data['SupplierPercent'] = supplierPercent;
    data['SupplierMony'] = supplierMony;
    data['IsSell'] = isSell;
    data['GovID'] = govID;
    data['PIndex'] = pIndex;
    data['InternationalCode'] = internationalCode;
    data['LocalCode'] = localCode;
    data['ProductCode'] = productCode;
    data['CreateDate'] = createDate;
    data['MonthsNumber'] = monthsNumber;
    data['IsLocal'] = isLocal;
    data['ISQuntity'] = iSQuntity;
    data['ISInventory'] = iSInventory;
    data['ISService'] = iSService;
    data['IsSerial'] = isSerial;
    data['ISSales'] = iSSales;
    data['SaleMoreOne'] = saleMoreOne;
    data['ISContractSale'] = iSContractSale;
    data['ISPrimary'] = iSPrimary;
    data['ISExpierd'] = iSExpierd;
    data['ISserviceCntract'] = iSserviceCntract;
    data['ISPurchase'] = iSPurchase;
    data['UName'] = uName;
    data['UIndex'] = uIndex;
    data['UnitID'] = unitID;
    data['Costtype'] = costtype;
    data['BarCode'] = barCode;
    data['PurchCode'] = purchCode;
    data['SalesCode'] = salesCode;
    data['SecoundPrice'] = secoundPrice;
    data['CName'] = cName;
    data['ColorID'] = colorID;
    data['SizeID'] = sizeID;
    data['DimantionID'] = dimantionID;
    data['MatrialID'] = matrialID;
    data['IsColor'] = isColor;
    data['IsSize'] = isSize;
    data['CategoryID'] = categoryID;
    data['IsDimantion'] = isDimantion;
    data['ProNameEShortCut'] = proNameEShortCut;
    data['ProNameE'] = proNameE;
    data['CategoryName'] = categoryName;
    data['ColorName'] = colorName;
    data['SizeName'] = sizeName;
    data['DName'] = dName;
    data['MName'] = mName;
    data['MNameE'] = mNameE;
    data['MNameShortCut'] = mNameShortCut;
    data['SizeNameE'] = sizeNameE;
    data['SizeNameShortCut'] = sizeNameShortCut;
    data['ColorNameE'] = colorNameE;
    data['ColorNameShortCut'] = colorNameShortCut;
    data['CategoryNameE'] = categoryNameE;
    data['CompanyID'] = companyID;
    data['CategoryNameSortCut'] = categoryNameSortCut;
    data['length'] = length;
    data['Width'] = width;
    data['Hight'] = hight;
    data['Density'] = density;
    data['IsDetailsOnDisplay'] = isDetailsOnDisplay;
    data['ExpireDate'] = expireDate;
    data['UnitsInMasterUnit'] = unitsInMasterUnit;
    data['DropDownSearch'] = dropDownSearch;
    data['IsSurgery'] = isSurgery;
    data['costitemId'] = costitemId;
    data['UQuntity'] = uQuntity;
    data['SecoundUnit'] = secoundUnit;
    data['ProfitMargin'] = profitMargin;
    data['PrevPurchasePrice'] = prevPurchasePrice;
    data['printdate'] = printdate;
    data['CloseSchema'] = closeSchema;
    data['DepartementID'] = departementID;
    data['ProductAutoCode'] = productAutoCode;
    data['ProAutoCodeWithModality'] = proAutoCodeWithModality;
    return data;
  }
}
