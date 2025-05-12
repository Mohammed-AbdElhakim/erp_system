class CallsViewModel2 {
  List<CallsItem>? dynamicList;
  int? numberofrecords;

  CallsViewModel2({this.dynamicList, this.numberofrecords});

  CallsViewModel2.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <CallsItem>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(CallsItem.fromJson(v));
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

class CallsItem {
  int? cID;
  int? customer;
  String? cDescription;
  String? cName;
  String? cDate;
  int? productID;
  int? cEmployee;
  String? proName;
  String? employeeNameA;
  int? comID;
  String? customerAccountName;
  bool? isdone;
  String? customerAccountTelephone2;
  String? phone2;
  String? phone3;
  String? phone4;
  String? customerAccountMobile1;
  String? aDSName;
  int? adsMasterId;
  String? aDSAutoCode;
  String? aDsCusomer;
  String? cCName;
  int? category;
  bool? isIn;
  String? createAt;
  String? createdCustomerAt;
  String? modifyAt;
  String? createBy;
  String? modifyBY;
  String? iSpublic;
  int? createByID;
  int? modifyByID;
  String? netxVisitDate;
  String? nextVisitTitle;
  String? nextCallDate;
  String? nextCallTitle;
  String? customerAccountAddress;
  String? customerAccountCity;
  String? customerAccountEmail;
  String? categoryName;
  String? salesMan;
  int? createCust;
  int? customerDepartmentID;
  int? cDID;
  String? cDName;
  int? customerID;
  String? cDKeyName;
  String? cDDescription;
  String? cDMobile;
  String? cDPhone;
  String? cDPhone2;
  String? cDEmail;
  int? aDSID;
  int? aDsCusomerID;
  int? expr2;
  String? discription1;
  String? discription2;
  String? discription3;
  String? discription4;
  String? pERM;
  String? custPERM;
  int? callResaultId;
  String? nonActiveCustomer;
  String? callResaultName;
  String? modifyTime;
  String? createTime;
  String? nearPhon;
  String? adsMethod;
  int? demandId;
  String? categoryName2;
  String? categoryName3;
  int? cardID;
  String? cWork;
  String? place;
  int? directManger;
  int? suppyOrderID;

  CallsItem(
      {this.cID,
      this.customer,
      this.cDescription,
      this.cName,
      this.cDate,
      this.productID,
      this.cEmployee,
      this.proName,
      this.employeeNameA,
      this.comID,
      this.customerAccountName,
      this.isdone,
      this.customerAccountTelephone2,
      this.phone2,
      this.phone3,
      this.phone4,
      this.customerAccountMobile1,
      this.aDSName,
      this.adsMasterId,
      this.aDSAutoCode,
      this.aDsCusomer,
      this.cCName,
      this.category,
      this.isIn,
      this.createAt,
      this.createdCustomerAt,
      this.modifyAt,
      this.createBy,
      this.modifyBY,
      this.iSpublic,
      this.createByID,
      this.modifyByID,
      this.netxVisitDate,
      this.nextVisitTitle,
      this.nextCallDate,
      this.nextCallTitle,
      this.customerAccountAddress,
      this.customerAccountCity,
      this.customerAccountEmail,
      this.categoryName,
      this.salesMan,
      this.createCust,
      this.customerDepartmentID,
      this.cDID,
      this.cDName,
      this.customerID,
      this.cDKeyName,
      this.cDDescription,
      this.cDMobile,
      this.cDPhone,
      this.cDPhone2,
      this.cDEmail,
      this.aDSID,
      this.aDsCusomerID,
      this.expr2,
      this.discription1,
      this.discription2,
      this.discription3,
      this.discription4,
      this.pERM,
      this.custPERM,
      this.callResaultId,
      this.nonActiveCustomer,
      this.callResaultName,
      this.modifyTime,
      this.createTime,
      this.nearPhon,
      this.adsMethod,
      this.demandId,
      this.categoryName2,
      this.categoryName3,
      this.cardID,
      this.cWork,
      this.place,
      this.directManger,
      this.suppyOrderID});

  CallsItem.fromJson(Map<String, dynamic> json) {
    cID = json['CID'];
    customer = json['Customer'];
    cDescription = json['CDescription'];
    cName = json['CName'];
    cDate = json['CDate'];
    productID = json['ProductID'];
    cEmployee = json['CEmployee'];
    proName = json['ProName'];
    employeeNameA = json['EmployeeNameA'];
    comID = json['ComID'];
    customerAccountName = json['CustomerAccountName'];
    isdone = json['Isdone'];
    customerAccountTelephone2 = json['CustomerAccountTelephone2'];
    phone2 = json['Phone2'];
    phone3 = json['Phone3'];
    phone4 = json['Phone4'];
    customerAccountMobile1 = json['CustomerAccountMobile1'];
    aDSName = json['ADSName'];
    adsMasterId = json['AdsMasterId'];
    aDSAutoCode = json['ADSAutoCode'];
    aDsCusomer = json['ADsCusomer'];
    cCName = json['CCName'];
    category = json['Category'];
    isIn = json['IsIn'];
    createAt = json['CreateAt'];
    createdCustomerAt = json['CreatedCustomerAt'];
    modifyAt = json['ModifyAt'];
    createBy = json['CreateBy'];
    modifyBY = json['modifyBY'];
    iSpublic = json['ISpublic'];
    createByID = json['CreateByID'];
    modifyByID = json['ModifyByID'];
    netxVisitDate = json['NetxVisitDate'];
    nextVisitTitle = json['NextVisitTitle'];
    nextCallDate = json['NextCallDate'];
    nextCallTitle = json['NextCallTitle'];
    customerAccountAddress = json['CustomerAccountAddress'];
    customerAccountCity = json['CustomerAccountCity'];
    customerAccountEmail = json['CustomerAccountEmail'];
    categoryName = json['CategoryName'];
    salesMan = json['SalesMan'];
    createCust = json['CreateCust'];
    customerDepartmentID = json['CustomerDepartmentID'];
    cDID = json['CDID'];
    cDName = json['CDName'];
    customerID = json['CustomerID'];
    cDKeyName = json['CDKeyName'];
    cDDescription = json['CDDescription'];
    cDMobile = json['CDMobile'];
    cDPhone = json['CDPhone'];
    cDPhone2 = json['CDPhone2'];
    cDEmail = json['CDEmail'];
    aDSID = json['ADSID'];
    aDsCusomerID = json['ADsCusomerID'];
    expr2 = json['Expr2'];
    discription1 = json['Discription1'];
    discription2 = json['Discription2'];
    discription3 = json['Discription3'];
    discription4 = json['Discription4'];
    pERM = json['PERM'];
    custPERM = json['CustPERM'];
    callResaultId = json['CallResaultId'];
    nonActiveCustomer = json['NonActiveCustomer'];
    callResaultName = json['CallResaultName'];
    modifyTime = json['ModifyTime'];
    createTime = json['CreateTime'];
    nearPhon = json['NearPhon'];
    adsMethod = json['AdsMethod'];
    demandId = json['DemandId'];
    categoryName2 = json['CategoryName2'];
    categoryName3 = json['CategoryName3'];
    cardID = json['CardID'];
    cWork = json['CWork'];
    place = json['Place'];
    directManger = json['DirectManger'];
    suppyOrderID = json['SuppyOrderID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CID'] = cID;
    data['Customer'] = customer;
    data['CDescription'] = cDescription;
    data['CName'] = cName;
    data['CDate'] = cDate;
    data['ProductID'] = productID;
    data['CEmployee'] = cEmployee;
    data['ProName'] = proName;
    data['EmployeeNameA'] = employeeNameA;
    data['ComID'] = comID;
    data['CustomerAccountName'] = customerAccountName;
    data['Isdone'] = isdone;
    data['CustomerAccountTelephone2'] = customerAccountTelephone2;
    data['Phone2'] = phone2;
    data['Phone3'] = phone3;
    data['Phone4'] = phone4;
    data['CustomerAccountMobile1'] = customerAccountMobile1;
    data['ADSName'] = aDSName;
    data['AdsMasterId'] = adsMasterId;
    data['ADSAutoCode'] = aDSAutoCode;
    data['ADsCusomer'] = aDsCusomer;
    data['CCName'] = cCName;
    data['Category'] = category;
    data['IsIn'] = isIn;
    data['CreateAt'] = createAt;
    data['CreatedCustomerAt'] = createdCustomerAt;
    data['ModifyAt'] = modifyAt;
    data['CreateBy'] = createBy;
    data['modifyBY'] = modifyBY;
    data['ISpublic'] = iSpublic;
    data['CreateByID'] = createByID;
    data['ModifyByID'] = modifyByID;
    data['NetxVisitDate'] = netxVisitDate;
    data['NextVisitTitle'] = nextVisitTitle;
    data['NextCallDate'] = nextCallDate;
    data['NextCallTitle'] = nextCallTitle;
    data['CustomerAccountAddress'] = customerAccountAddress;
    data['CustomerAccountCity'] = customerAccountCity;
    data['CustomerAccountEmail'] = customerAccountEmail;
    data['CategoryName'] = categoryName;
    data['SalesMan'] = salesMan;
    data['CreateCust'] = createCust;
    data['CustomerDepartmentID'] = customerDepartmentID;
    data['CDID'] = cDID;
    data['CDName'] = cDName;
    data['CustomerID'] = customerID;
    data['CDKeyName'] = cDKeyName;
    data['CDDescription'] = cDDescription;
    data['CDMobile'] = cDMobile;
    data['CDPhone'] = cDPhone;
    data['CDPhone2'] = cDPhone2;
    data['CDEmail'] = cDEmail;
    data['ADSID'] = aDSID;
    data['ADsCusomerID'] = aDsCusomerID;
    data['Expr2'] = expr2;
    data['Discription1'] = discription1;
    data['Discription2'] = discription2;
    data['Discription3'] = discription3;
    data['Discription4'] = discription4;
    data['PERM'] = pERM;
    data['CustPERM'] = custPERM;
    data['CallResaultId'] = callResaultId;
    data['NonActiveCustomer'] = nonActiveCustomer;
    data['CallResaultName'] = callResaultName;
    data['ModifyTime'] = modifyTime;
    data['CreateTime'] = createTime;
    data['NearPhon'] = nearPhon;
    data['AdsMethod'] = adsMethod;
    data['DemandId'] = demandId;
    data['CategoryName2'] = categoryName2;
    data['CategoryName3'] = categoryName3;
    data['CardID'] = cardID;
    data['CWork'] = cWork;
    data['Place'] = place;
    data['DirectManger'] = directManger;
    data['SuppyOrderID'] = suppyOrderID;
    return data;
  }
}
