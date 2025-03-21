class SupplierCustomerProcessModel3 {
  List<DynamicList>? dynamicList;
  num? numberofrecords;

  SupplierCustomerProcessModel3({this.dynamicList, this.numberofrecords});

  SupplierCustomerProcessModel3.fromJson(Map<String, dynamic> json) {
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
  num? pDID;
  num? purchaseOrderID;
  num? productID;
  double? cost;
  String? price;
  String? priceOfUnit;
  String? priceAfterDiscount;
  num? earnedDiscount;
  num? quntity;
  String? repurcahseQuntity;
  String? repurcasedate;
  String? proName;
  num? modality;
  double? total;
  num? pOID;
  num? pONumber;
  String? pODate;
  num? supplierID;
  String? farmingSupplyMasterId;
  String? pOValue;
  String? pOPaid;
  num? pOSetting;
  num? currancyID;
  String? pODescription;
  String? orderNote;
  String? ordernumber;
  String? pCode;
  double? purchtotal;
  double? totalOrder;
  double? totalCurrancy;
  String? discount;
  String? discountCurrancy;
  String? pOPaidCurrancy;
  num? currancyEX;
  String? remind;
  String? remindCurrancy;
  String? reciveQuntity;
  double? costCurrancy;
  num? storeID;
  String? secQuntity;
  num? unitID;
  String? secUnit;
  String? expCost;
  String? uName;
  String? cName;
  String? sName;
  String? pSName;
  num? comID;
  String? isRePurch;
  String? expirdate;
  num? colorID;
  num? sizeID;
  num? dimantionID;
  String? length;
  String? width;
  String? hight;
  String? density;
  String? serialNumber;
  String? sPhone;
  String? sAddress;
  num? safeAccounId;
  num? proccessId;
  num? costItemId;
  String? note1;
  String? note2;
  String? note3;
  String? note4;
  String? note5;
  String? note6;
  String? note7;
  String? note8;
  String? note9;
  String? note10;
  String? note11;
  String? note12;
  String? note13;
  String? note14;
  String? note15;
  String? note16;
  num? projectID;
  String? note17;
  String? note18;
  String? note19;
  String? note20;
  String? engWeight;
  num? guideWeight;
  double? guidePrice;
  num? difQty;
  num? difSupplierQty;
  double? difSupplierQtyPrice;
  String? supplierWeight;
  num? employeeId;
  String? taxFile;
  String? detailNote;
  double? tax;
  double? taxCurrancy;
  num? addTax;
  String? addTaxCurrancy;
  double? finalTotal;
  String? barcode;
  String? note;
  String? detailDiscount;
  String? costItemDetail;
  num? requsetId;
  String? sellingPrice;
  String? profitMargin;
  num? maintemTreeId;
  num? itemsTreeId;
  num? purchaseInvoiceId;
  String? isConfirm;
  String? remainingQuantity;
  String? purchCode;
  num? project;
  double? totalCostExp;
  double? totalCostWithExp;
  String? colorName;
  bool? noPurchTax;
  String? sOMID;
  num? supplyerOrderId;
  num? supplyOrderDetailID;

  DynamicList(
      {this.pDID,
      this.purchaseOrderID,
      this.productID,
      this.cost,
      this.price,
      this.priceOfUnit,
      this.priceAfterDiscount,
      this.earnedDiscount,
      this.quntity,
      this.repurcahseQuntity,
      this.repurcasedate,
      this.proName,
      this.modality,
      this.total,
      this.pOID,
      this.pONumber,
      this.pODate,
      this.supplierID,
      this.farmingSupplyMasterId,
      this.pOValue,
      this.pOPaid,
      this.pOSetting,
      this.currancyID,
      this.pODescription,
      this.orderNote,
      this.ordernumber,
      this.pCode,
      this.purchtotal,
      this.totalOrder,
      this.totalCurrancy,
      this.discount,
      this.discountCurrancy,
      this.pOPaidCurrancy,
      this.currancyEX,
      this.remind,
      this.remindCurrancy,
      this.reciveQuntity,
      this.costCurrancy,
      this.storeID,
      this.secQuntity,
      this.unitID,
      this.secUnit,
      this.expCost,
      this.uName,
      this.cName,
      this.sName,
      this.pSName,
      this.comID,
      this.isRePurch,
      this.expirdate,
      this.colorID,
      this.sizeID,
      this.dimantionID,
      this.length,
      this.width,
      this.hight,
      this.density,
      this.serialNumber,
      this.sPhone,
      this.sAddress,
      this.safeAccounId,
      this.proccessId,
      this.costItemId,
      this.note1,
      this.note2,
      this.note3,
      this.note4,
      this.note5,
      this.note6,
      this.note7,
      this.note8,
      this.note9,
      this.note10,
      this.note11,
      this.note12,
      this.note13,
      this.note14,
      this.note15,
      this.note16,
      this.projectID,
      this.note17,
      this.note18,
      this.note19,
      this.note20,
      this.engWeight,
      this.guideWeight,
      this.guidePrice,
      this.difQty,
      this.difSupplierQty,
      this.difSupplierQtyPrice,
      this.supplierWeight,
      this.employeeId,
      this.taxFile,
      this.detailNote,
      this.tax,
      this.taxCurrancy,
      this.addTax,
      this.addTaxCurrancy,
      this.finalTotal,
      this.barcode,
      this.note,
      this.detailDiscount,
      this.costItemDetail,
      this.requsetId,
      this.sellingPrice,
      this.profitMargin,
      this.maintemTreeId,
      this.itemsTreeId,
      this.purchaseInvoiceId,
      this.isConfirm,
      this.remainingQuantity,
      this.purchCode,
      this.project,
      this.totalCostExp,
      this.totalCostWithExp,
      this.colorName,
      this.noPurchTax,
      this.sOMID,
      this.supplyerOrderId,
      this.supplyOrderDetailID});

  DynamicList.fromJson(Map<String, dynamic> json) {
    pDID = json['PDID'];
    purchaseOrderID = json['PurchaseOrderID'];
    productID = json['ProductID'];
    cost = json['Cost'];
    price = json['price'];
    priceOfUnit = json['PriceOfUnit'];
    priceAfterDiscount = json['PriceAfterDiscount'];
    earnedDiscount = json['EarnedDiscount'];
    quntity = json['Quntity'];
    repurcahseQuntity = json['RepurcahseQuntity'];
    repurcasedate = json['Repurcasedate'];
    proName = json['ProName'];
    modality = json['Modality'];
    total = json['Total'];
    pOID = json['POID'];
    pONumber = json['PONumber'];
    pODate = json['PODate'];
    supplierID = json['SupplierID'];
    farmingSupplyMasterId = json['FarmingSupplyMasterId'];
    pOValue = json['POValue'];
    pOPaid = json['POPaid'];
    pOSetting = json['POSetting'];
    currancyID = json['CurrancyID'];
    pODescription = json['PODescription'];
    orderNote = json['OrderNote'];
    ordernumber = json['Ordernumber'];
    pCode = json['PCode'];
    purchtotal = json['purchtotal'];
    totalOrder = json['TotalOrder'];
    totalCurrancy = json['TotalCurrancy'];
    discount = json['Discount'];
    discountCurrancy = json['DiscountCurrancy'];
    pOPaidCurrancy = json['POPaidCurrancy'];
    currancyEX = json['CurrancyEX'];
    remind = json['remind'];
    remindCurrancy = json['remindCurrancy'];
    reciveQuntity = json['ReciveQuntity'];
    costCurrancy = json['CostCurrancy'];
    storeID = json['StoreID'];
    secQuntity = json['SecQuntity'];
    unitID = json['UnitID'];
    secUnit = json['SecUnit'];
    expCost = json['ExpCost'];
    uName = json['UName'];
    cName = json['CName'];
    sName = json['SName'];
    pSName = json['PSName'];
    comID = json['ComID'];
    isRePurch = json['IsRePurch'];
    expirdate = json['Expirdate'];
    colorID = json['ColorID'];
    sizeID = json['SizeID'];
    dimantionID = json['DimantionID'];
    length = json['length'];
    width = json['Width'];
    hight = json['Hight'];
    density = json['Density'];
    serialNumber = json['SerialNumber'];
    sPhone = json['SPhone'];
    sAddress = json['SAddress'];
    safeAccounId = json['SafeAccounId'];
    proccessId = json['ProccessId'];
    costItemId = json['CostItemId'];
    note1 = json['Note1'];
    note2 = json['Note2'];
    note3 = json['Note3'];
    note4 = json['Note4'];
    note5 = json['Note5'];
    note6 = json['Note6'];
    note7 = json['Note7'];
    note8 = json['Note8'];
    note9 = json['Note9'];
    note10 = json['Note10'];
    note11 = json['Note11'];
    note12 = json['Note12'];
    note13 = json['Note13'];
    note14 = json['Note14'];
    note15 = json['Note15'];
    note16 = json['Note16'];
    projectID = json['ProjectID'];
    note17 = json['Note17'];
    note18 = json['Note18'];
    note19 = json['Note19'];
    note20 = json['Note20'];
    engWeight = json['EngWeight'];
    guideWeight = json['GuideWeight'];
    guidePrice = json['GuidePrice'];
    difQty = json['DifQty'];
    difSupplierQty = json['DifSupplierQty'];
    difSupplierQtyPrice = json['DifSupplierQtyPrice'];
    supplierWeight = json['SupplierWeight'];
    employeeId = json['EmployeeId'];
    taxFile = json['TaxFile'];
    detailNote = json['DetailNote'];
    tax = json['Tax'];
    taxCurrancy = json['TaxCurrancy'];
    addTax = json['AddTax'];
    addTaxCurrancy = json['AddTaxCurrancy'];
    finalTotal = json['finalTotal'];
    barcode = json['Barcode'];
    note = json['Note'];
    detailDiscount = json['DetailDiscount'];
    costItemDetail = json['CostItemDetail'];
    requsetId = json['RequsetId'];
    sellingPrice = json['SellingPrice'];
    profitMargin = json['ProfitMargin'];
    maintemTreeId = json['MaintemTreeId'];
    itemsTreeId = json['ItemsTreeId'];
    purchaseInvoiceId = json['purchaseInvoiceId'];
    isConfirm = json['IsConfirm'];
    remainingQuantity = json['RemainingQuantity'];
    purchCode = json['PurchCode'];
    project = json['project'];
    totalCostExp = json['TotalCostExp'];
    totalCostWithExp = json['TotalCostWithExp'];
    colorName = json['ColorName'];
    noPurchTax = json['NoPurchTax'];
    sOMID = json['SOMID'];
    supplyerOrderId = json['supplyerOrderId'];
    supplyOrderDetailID = json['SupplyOrderDetailID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PDID'] = pDID;
    data['PurchaseOrderID'] = purchaseOrderID;
    data['ProductID'] = productID;
    data['Cost'] = cost;
    data['price'] = price;
    data['PriceOfUnit'] = priceOfUnit;
    data['PriceAfterDiscount'] = priceAfterDiscount;
    data['EarnedDiscount'] = earnedDiscount;
    data['Quntity'] = quntity;
    data['RepurcahseQuntity'] = repurcahseQuntity;
    data['Repurcasedate'] = repurcasedate;
    data['ProName'] = proName;
    data['Modality'] = modality;
    data['Total'] = total;
    data['POID'] = pOID;
    data['PONumber'] = pONumber;
    data['PODate'] = pODate;
    data['SupplierID'] = supplierID;
    data['FarmingSupplyMasterId'] = farmingSupplyMasterId;
    data['POValue'] = pOValue;
    data['POPaid'] = pOPaid;
    data['POSetting'] = pOSetting;
    data['CurrancyID'] = currancyID;
    data['PODescription'] = pODescription;
    data['OrderNote'] = orderNote;
    data['Ordernumber'] = ordernumber;
    data['PCode'] = pCode;
    data['purchtotal'] = purchtotal;
    data['TotalOrder'] = totalOrder;
    data['TotalCurrancy'] = totalCurrancy;
    data['Discount'] = discount;
    data['DiscountCurrancy'] = discountCurrancy;
    data['POPaidCurrancy'] = pOPaidCurrancy;
    data['CurrancyEX'] = currancyEX;
    data['remind'] = remind;
    data['remindCurrancy'] = remindCurrancy;
    data['ReciveQuntity'] = reciveQuntity;
    data['CostCurrancy'] = costCurrancy;
    data['StoreID'] = storeID;
    data['SecQuntity'] = secQuntity;
    data['UnitID'] = unitID;
    data['SecUnit'] = secUnit;
    data['ExpCost'] = expCost;
    data['UName'] = uName;
    data['CName'] = cName;
    data['SName'] = sName;
    data['PSName'] = pSName;
    data['ComID'] = comID;
    data['IsRePurch'] = isRePurch;
    data['Expirdate'] = expirdate;
    data['ColorID'] = colorID;
    data['SizeID'] = sizeID;
    data['DimantionID'] = dimantionID;
    data['length'] = length;
    data['Width'] = width;
    data['Hight'] = hight;
    data['Density'] = density;
    data['SerialNumber'] = serialNumber;
    data['SPhone'] = sPhone;
    data['SAddress'] = sAddress;
    data['SafeAccounId'] = safeAccounId;
    data['ProccessId'] = proccessId;
    data['CostItemId'] = costItemId;
    data['Note1'] = note1;
    data['Note2'] = note2;
    data['Note3'] = note3;
    data['Note4'] = note4;
    data['Note5'] = note5;
    data['Note6'] = note6;
    data['Note7'] = note7;
    data['Note8'] = note8;
    data['Note9'] = note9;
    data['Note10'] = note10;
    data['Note11'] = note11;
    data['Note12'] = note12;
    data['Note13'] = note13;
    data['Note14'] = note14;
    data['Note15'] = note15;
    data['Note16'] = note16;
    data['ProjectID'] = projectID;
    data['Note17'] = note17;
    data['Note18'] = note18;
    data['Note19'] = note19;
    data['Note20'] = note20;
    data['EngWeight'] = engWeight;
    data['GuideWeight'] = guideWeight;
    data['GuidePrice'] = guidePrice;
    data['DifQty'] = difQty;
    data['DifSupplierQty'] = difSupplierQty;
    data['DifSupplierQtyPrice'] = difSupplierQtyPrice;
    data['SupplierWeight'] = supplierWeight;
    data['EmployeeId'] = employeeId;
    data['TaxFile'] = taxFile;
    data['DetailNote'] = detailNote;
    data['Tax'] = tax;
    data['TaxCurrancy'] = taxCurrancy;
    data['AddTax'] = addTax;
    data['AddTaxCurrancy'] = addTaxCurrancy;
    data['finalTotal'] = finalTotal;
    data['Barcode'] = barcode;
    data['Note'] = note;
    data['DetailDiscount'] = detailDiscount;
    data['CostItemDetail'] = costItemDetail;
    data['RequsetId'] = requsetId;
    data['SellingPrice'] = sellingPrice;
    data['ProfitMargin'] = profitMargin;
    data['MaintemTreeId'] = maintemTreeId;
    data['ItemsTreeId'] = itemsTreeId;
    data['purchaseInvoiceId'] = purchaseInvoiceId;
    data['IsConfirm'] = isConfirm;
    data['RemainingQuantity'] = remainingQuantity;
    data['PurchCode'] = purchCode;
    data['project'] = project;
    data['TotalCostExp'] = totalCostExp;
    data['TotalCostWithExp'] = totalCostWithExp;
    data['ColorName'] = colorName;
    data['NoPurchTax'] = noPurchTax;
    data['SOMID'] = sOMID;
    data['supplyerOrderId'] = supplyerOrderId;
    data['SupplyOrderDetailID'] = supplyOrderDetailID;
    return data;
  }
}
