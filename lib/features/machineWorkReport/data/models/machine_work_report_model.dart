class MachineWorkReportModel {
  List<MachineWorkReportItem>? listMachineWorkReport;
  int? numberofrecords;

  MachineWorkReportModel({this.listMachineWorkReport, this.numberofrecords});

  MachineWorkReportModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      listMachineWorkReport = <MachineWorkReportItem>[];
      json['dynamicList'].forEach((v) {
        listMachineWorkReport!.add(MachineWorkReportItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listMachineWorkReport != null) {
      data['dynamicList'] = listMachineWorkReport!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class MachineWorkReportItem {
  int? eMID;
  int? machinProcessID;
  String? mWPrice;
  String? mWCount;
  String? mWTimeFrom;
  String? mWTimeTo;
  int? mWDTypeID;
  String? safeAccount;
  String? paidMony;
  int? machinWorkMastersID;
  int? mWMID;
  int? productID;
  int? employeeID;
  int? createBy;
  String? createat;
  String? description;
  String? note;
  String? eDate;
  int? supplierID;
  int? machimWorkSettingID;
  int? entrymasterID;
  int? mPID;
  int? machinID;
  String? processName;
  String? processPrice;
  String? hourPrice;
  String? dayprice;
  String? capacty;
  int? mWID;
  String? mWName;
  String? supplierAccount;
  String? processAccount;
  String? discountAccount;
  String? mWTName;
  String? paperNumber;
  String? sName;
  String? sNote;
  int? comID;
  String? discount1;
  String? discount2;
  String? unitQuntity;
  String? discountQuntity;
  String? totalquntity;
  String? finalquntity;
  double? credit;
  String? totalprice;
  String? mWDescription;
  String? assetsSuplier;
  String? processSuplier;
  String? customerAccountName;
  int? customerID;
  int? constractionItemId;
  double? depit;
  int? costItem;
  int? accountStatus;
  int? acID;
  int? eDID;
  String? acName;
  int? accountID;
  int? projectID;
  double? filnaltotal;
  int? cIIndex;

  MachineWorkReportItem(
      {this.eMID,
      this.machinProcessID,
      this.mWPrice,
      this.mWCount,
      this.mWTimeFrom,
      this.mWTimeTo,
      this.mWDTypeID,
      this.safeAccount,
      this.paidMony,
      this.machinWorkMastersID,
      this.mWMID,
      this.productID,
      this.employeeID,
      this.createBy,
      this.createat,
      this.description,
      this.note,
      this.eDate,
      this.supplierID,
      this.machimWorkSettingID,
      this.entrymasterID,
      this.mPID,
      this.machinID,
      this.processName,
      this.processPrice,
      this.hourPrice,
      this.dayprice,
      this.capacty,
      this.mWID,
      this.mWName,
      this.supplierAccount,
      this.processAccount,
      this.discountAccount,
      this.mWTName,
      this.paperNumber,
      this.sName,
      this.sNote,
      this.comID,
      this.discount1,
      this.discount2,
      this.unitQuntity,
      this.discountQuntity,
      this.totalquntity,
      this.finalquntity,
      this.credit,
      this.totalprice,
      this.mWDescription,
      this.assetsSuplier,
      this.processSuplier,
      this.customerAccountName,
      this.customerID,
      this.constractionItemId,
      this.depit,
      this.costItem,
      this.accountStatus,
      this.acID,
      this.eDID,
      this.acName,
      this.accountID,
      this.projectID,
      this.filnaltotal,
      this.cIIndex});

  MachineWorkReportItem.fromJson(Map<String, dynamic> json) {
    eMID = json['EMID'];
    machinProcessID = json['MachinProcessID'];
    mWPrice = json['MWPrice'];
    mWCount = json['MWCount'];
    mWTimeFrom = json['MWTimeFrom'];
    mWTimeTo = json['MWTimeTo'];
    mWDTypeID = json['MWDTypeID'];
    safeAccount = json['SafeAccount'];
    paidMony = json['PaidMony'];
    machinWorkMastersID = json['MachinWorkMastersID'];
    mWMID = json['MWMID'];
    productID = json['ProductID'];
    employeeID = json['EmployeeID'];
    createBy = json['CreateBy'];
    createat = json['Createat'];
    description = json['Description'];
    note = json['Note'];
    eDate = json['EDate'];
    supplierID = json['SupplierID'];
    machimWorkSettingID = json['MachimWorkSettingID'];
    entrymasterID = json['EntrymasterID'];
    mPID = json['MPID'];
    machinID = json['MachinID'];
    processName = json['ProcessName'];
    processPrice = json['ProcessPrice'];
    hourPrice = json['HourPrice'];
    dayprice = json['Dayprice'];
    capacty = json['Capacty'];
    mWID = json['MWID'];
    mWName = json['MWName'];
    supplierAccount = json['SupplierAccount'];
    processAccount = json['ProcessAccount'];
    discountAccount = json['DiscountAccount'];
    mWTName = json['MWTName'];
    paperNumber = json['PaperNumber'];
    sName = json['SName'];
    sNote = json['SNote'];
    comID = json['ComID'];
    discount1 = json['Discount1'];
    discount2 = json['Discount2'];
    unitQuntity = json['UnitQuntity'];
    discountQuntity = json['DiscountQuntity'];
    totalquntity = json['totalquntity'];
    finalquntity = json['finalquntity'];
    credit = json['Credit'];
    totalprice = json['totalprice'];
    mWDescription = json['MWDescription'];
    assetsSuplier = json['assetsSuplier'];
    processSuplier = json['processSuplier'];
    customerAccountName = json['CustomerAccountName'];
    customerID = json['CustomerID'];
    constractionItemId = json['ConstractionItemId'];
    depit = json['Depit'];
    costItem = json['CostItem'];
    accountStatus = json['AccountStatus'];
    acID = json['AcID'];
    eDID = json['EDID'];
    acName = json['AcName'];
    accountID = json['AccountID'];
    projectID = json['ProjectID'];
    filnaltotal = json['filnaltotal'];
    cIIndex = json['CIIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EMID'] = eMID;
    data['MachinProcessID'] = machinProcessID;
    data['MWPrice'] = mWPrice;
    data['MWCount'] = mWCount;
    data['MWTimeFrom'] = mWTimeFrom;
    data['MWTimeTo'] = mWTimeTo;
    data['MWDTypeID'] = mWDTypeID;
    data['SafeAccount'] = safeAccount;
    data['PaidMony'] = paidMony;
    data['MachinWorkMastersID'] = machinWorkMastersID;
    data['MWMID'] = mWMID;
    data['ProductID'] = productID;
    data['EmployeeID'] = employeeID;
    data['CreateBy'] = createBy;
    data['Createat'] = createat;
    data['Description'] = description;
    data['Note'] = note;
    data['EDate'] = eDate;
    data['SupplierID'] = supplierID;
    data['MachimWorkSettingID'] = machimWorkSettingID;
    data['EntrymasterID'] = entrymasterID;
    data['MPID'] = mPID;
    data['MachinID'] = machinID;
    data['ProcessName'] = processName;
    data['ProcessPrice'] = processPrice;
    data['HourPrice'] = hourPrice;
    data['Dayprice'] = dayprice;
    data['Capacty'] = capacty;
    data['MWID'] = mWID;
    data['MWName'] = mWName;
    data['SupplierAccount'] = supplierAccount;
    data['ProcessAccount'] = processAccount;
    data['DiscountAccount'] = discountAccount;
    data['MWTName'] = mWTName;
    data['PaperNumber'] = paperNumber;
    data['SName'] = sName;
    data['SNote'] = sNote;
    data['ComID'] = comID;
    data['Discount1'] = discount1;
    data['Discount2'] = discount2;
    data['UnitQuntity'] = unitQuntity;
    data['DiscountQuntity'] = discountQuntity;
    data['totalquntity'] = totalquntity;
    data['finalquntity'] = finalquntity;
    data['Credit'] = credit;
    data['totalprice'] = totalprice;
    data['MWDescription'] = mWDescription;
    data['assetsSuplier'] = assetsSuplier;
    data['processSuplier'] = processSuplier;
    data['CustomerAccountName'] = customerAccountName;
    data['CustomerID'] = customerID;
    data['ConstractionItemId'] = constractionItemId;
    data['Depit'] = depit;
    data['CostItem'] = costItem;
    data['AccountStatus'] = accountStatus;
    data['AcID'] = acID;
    data['EDID'] = eDID;
    data['AcName'] = acName;
    data['AccountID'] = accountID;
    data['ProjectID'] = projectID;
    data['filnaltotal'] = filnaltotal;
    data['CIIndex'] = cIIndex;
    return data;
  }
}
