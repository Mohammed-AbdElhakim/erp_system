class CustomerAccountViewModel0 {
  List<CustomerAccountItem>? dynamicList;
  int? numberofrecords;

  CustomerAccountViewModel0({this.dynamicList, this.numberofrecords});

  CustomerAccountViewModel0.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <CustomerAccountItem>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(CustomerAccountItem.fromJson(v));
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

class CustomerAccountItem {
  String? creditOrDepit;
  int? openBalanceAccountID;
  String? openBalance;
  int? customerAccountParentID;
  String? isPrivate;
  String? isGovernment;
  int? stageID;
  String? eInvoiceCountry;
  String? eInvoiceGov;
  String? eInvoiceRegionCity;
  String? eInvoiceStreet;
  String? eInvoiceBuildingNumber;
  String? eInvoiceType;
  int? eInvoiceCodeID;
  int? customerAccountID;
  String? customerAccountName;
  String? gov;
  String? customerAccountAddress;
  String? customerAccountCity;
  String? customerAccountTelephone2;
  String? customerAccountEmail;
  String? isContracted;
  int? candidateID;
  int? codeiD;
  String? areaName;
  String? govName;
  String? cWork;
  String? customerAccountCode;
  String? cardID;
  String? cardArea;
  String? cardName;
  String? religion;
  String? nationality;
  String? place;
  String? iSBuy;
  String? salary;
  String? aDSName;
  String? aDSDescription;
  int? adsMasterId;
  int? adsID;
  String? nearPerson;
  String? nearPostion;
  String? nearPhon;
  String? nearAddress;
  String? nearMobile;
  String? nearWork;
  String? phone4;
  String? phone3;
  String? phone2;
  int? contractcount;
  String? customerAccountMobile1;
  String? birthDate;
  String? iSpublic;
  String? createBy;
  String? modifyBy;
  String? createAt;
  String? modifyAt;
  int? comID;
  String? userName;
  String? password;
  String? secoundPrice;
  String? birthMounth;
  String? salesMan;
  String? supplierID;
  String? salesManName;
  String? cCName;
  String? categoryID;
  int? departmentId;
  int? createByID;
  String? nonActiveCustomer;
  String? pERM;
  int? code;
  String? dropDownSearch;
  bool? isDublicated;
  String? directMangerName;
  String? directManger;
  String? isActiveEmployee;
  String? managerName;
  String? adsMethod;
  int? adsMethodId;
  String? gov2;
  int? industryID;
  String? countryName2;
  String? areaname2;
  String? govename2;
  String? createtime;
  String? createDate;
  String? countryName;
  String? categoryName2;
  String? categoryName3;
  String? category3;
  String? category2;
  String? labelConCat;
  String? labelConCat2;
  String? fullDublicated;
  String? phoneDublicated;
  String? cusMonthyear;
  String? creditLimit;
  String? customerCreditLimit;
  int? callResaultId;
  String? discription3;
  int? cCreatBy;
  String? cDescription;
  String? cDate;
  int? cEmployee;
  String? cCreateAt;
  String? nextCallDate;
  int? empCustomerDepartment;
  String? empIndexString;
  int? accountID;
  String? closelocation;

  CustomerAccountItem(
      {this.creditOrDepit,
      this.openBalanceAccountID,
      this.openBalance,
      this.customerAccountParentID,
      this.isPrivate,
      this.isGovernment,
      this.stageID,
      this.eInvoiceCountry,
      this.eInvoiceGov,
      this.eInvoiceRegionCity,
      this.eInvoiceStreet,
      this.eInvoiceBuildingNumber,
      this.eInvoiceType,
      this.eInvoiceCodeID,
      this.customerAccountID,
      this.customerAccountName,
      this.gov,
      this.customerAccountAddress,
      this.customerAccountCity,
      this.customerAccountTelephone2,
      this.customerAccountEmail,
      this.isContracted,
      this.candidateID,
      this.codeiD,
      this.areaName,
      this.govName,
      this.cWork,
      this.customerAccountCode,
      this.cardID,
      this.cardArea,
      this.cardName,
      this.religion,
      this.nationality,
      this.place,
      this.iSBuy,
      this.salary,
      this.aDSName,
      this.aDSDescription,
      this.adsMasterId,
      this.adsID,
      this.nearPerson,
      this.nearPostion,
      this.nearPhon,
      this.nearAddress,
      this.nearMobile,
      this.nearWork,
      this.phone4,
      this.phone3,
      this.phone2,
      this.contractcount,
      this.customerAccountMobile1,
      this.birthDate,
      this.iSpublic,
      this.createBy,
      this.modifyBy,
      this.createAt,
      this.modifyAt,
      this.comID,
      this.userName,
      this.password,
      this.secoundPrice,
      this.birthMounth,
      this.salesMan,
      this.supplierID,
      this.salesManName,
      this.cCName,
      this.categoryID,
      this.departmentId,
      this.createByID,
      this.nonActiveCustomer,
      this.pERM,
      this.code,
      this.dropDownSearch,
      this.isDublicated,
      this.directMangerName,
      this.directManger,
      this.isActiveEmployee,
      this.managerName,
      this.adsMethod,
      this.adsMethodId,
      this.gov2,
      this.industryID,
      this.countryName2,
      this.areaname2,
      this.govename2,
      this.createtime,
      this.createDate,
      this.countryName,
      this.categoryName2,
      this.categoryName3,
      this.category3,
      this.category2,
      this.labelConCat,
      this.labelConCat2,
      this.fullDublicated,
      this.phoneDublicated,
      this.cusMonthyear,
      this.creditLimit,
      this.customerCreditLimit,
      this.callResaultId,
      this.discription3,
      this.cCreatBy,
      this.cDescription,
      this.cDate,
      this.cEmployee,
      this.cCreateAt,
      this.nextCallDate,
      this.empCustomerDepartment,
      this.empIndexString,
      this.accountID,
      this.closelocation});

  CustomerAccountItem.fromJson(Map<String, dynamic> json) {
    creditOrDepit = json['CreditOrDepit'];
    openBalanceAccountID = json['OpenBalanceAccountID'];
    openBalance = json['OpenBalance'];
    customerAccountParentID = json['CustomerAccountParentID'];
    isPrivate = json['IsPrivate'];
    isGovernment = json['IsGovernment'];
    stageID = json['StageID'];
    eInvoiceCountry = json['EInvoiceCountry'];
    eInvoiceGov = json['EInvoiceGov'];
    eInvoiceRegionCity = json['EInvoiceRegionCity'];
    eInvoiceStreet = json['EInvoiceStreet'];
    eInvoiceBuildingNumber = json['EInvoiceBuildingNumber'];
    eInvoiceType = json['EInvoiceType'];
    eInvoiceCodeID = json['EInvoiceCodeID'];
    customerAccountID = json['CustomerAccountID'];
    customerAccountName = json['CustomerAccountName'];
    gov = json['Gov'];
    customerAccountAddress = json['CustomerAccountAddress'];
    customerAccountCity = json['CustomerAccountCity'];
    customerAccountTelephone2 = json['CustomerAccountTelephone2'];
    customerAccountEmail = json['CustomerAccountEmail'];
    isContracted = json['isContracted'];
    candidateID = json['CandidateID'];
    codeiD = json['CodeiD'];
    areaName = json['AreaName'];
    govName = json['GovName'];
    cWork = json['CWork'];
    customerAccountCode = json['CustomerAccountCode'];
    cardID = json['CardID'];
    cardArea = json['CardArea'];
    cardName = json['CardName'];
    religion = json['religion'];
    nationality = json['Nationality'];
    place = json['Place'];
    iSBuy = json['ISBuy'];
    salary = json['Salary'];
    aDSName = json['ADSName'];
    aDSDescription = json['ADSDescription'];
    adsMasterId = json['AdsMasterId'];
    adsID = json['AdsID'];
    nearPerson = json['NearPerson'];
    nearPostion = json['NearPostion'];
    nearPhon = json['NearPhon'];
    nearAddress = json['NearAddress'];
    nearMobile = json['NearMobile'];
    nearWork = json['NearWork'];
    phone4 = json['Phone4'];
    phone3 = json['Phone3'];
    phone2 = json['Phone2'];
    contractcount = json['contractcount'];
    customerAccountMobile1 = json['CustomerAccountMobile1'];
    birthDate = json['BirthDate'];
    iSpublic = json['ISpublic'];
    createBy = json['CreateBy'];
    modifyBy = json['ModifyBy'];
    createAt = json['CreateAt'];
    modifyAt = json['ModifyAt'];
    comID = json['ComID'];
    userName = json['UserName'];
    password = json['Password'];
    secoundPrice = json['SecoundPrice'];
    birthMounth = json['BirthMounth'];
    salesMan = json['SalesMan'];
    supplierID = json['SupplierID'];
    salesManName = json['SalesManName'];
    cCName = json['CCName'];
    categoryID = json['CategoryID'];
    departmentId = json['DepartmentId'];
    createByID = json['CreateByID'];
    nonActiveCustomer = json['NonActiveCustomer'];
    pERM = json['PERM'];
    code = json['Code'];
    dropDownSearch = json['DropDownSearch'];
    isDublicated = json['IsDublicated'];
    directMangerName = json['DirectMangerName'];
    directManger = json['DirectManger'];
    isActiveEmployee = json['IsActiveEmployee'];
    managerName = json['ManagerName'];
    adsMethod = json['AdsMethod'];
    adsMethodId = json['AdsMethodId'];
    gov2 = json['Gov2'];
    industryID = json['IndustryID'];
    countryName2 = json['CountryName2'];
    areaname2 = json['areaname2'];
    govename2 = json['govename2'];
    createtime = json['createtime'];
    createDate = json['createDate'];
    countryName = json['CountryName'];
    categoryName2 = json['CategoryName2'];
    categoryName3 = json['CategoryName3'];
    category3 = json['Category3'];
    category2 = json['Category2'];
    labelConCat = json['LabelConCat'];
    labelConCat2 = json['LabelConCat2'];
    fullDublicated = json['FullDublicated'];
    phoneDublicated = json['phoneDublicated'];
    cusMonthyear = json['CusMonthyear'];
    creditLimit = json['CreditLimit'];
    customerCreditLimit = json['CustomerCreditLimit'];
    callResaultId = json['CallResaultId'];
    discription3 = json['Discription3'];
    cCreatBy = json['CCreatBy'];
    cDescription = json['CDescription'];
    cDate = json['CDate'];
    cEmployee = json['CEmployee'];
    cCreateAt = json['CCreateAt'];
    nextCallDate = json['NextCallDate'];
    empCustomerDepartment = json['EmpCustomerDepartment'];
    empIndexString = json['EmpIndexString'];
    accountID = json['AccountID'];
    closelocation = json['Closelocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CreditOrDepit'] = creditOrDepit;
    data['OpenBalanceAccountID'] = openBalanceAccountID;
    data['OpenBalance'] = openBalance;
    data['CustomerAccountParentID'] = customerAccountParentID;
    data['IsPrivate'] = isPrivate;
    data['IsGovernment'] = isGovernment;
    data['StageID'] = stageID;
    data['EInvoiceCountry'] = eInvoiceCountry;
    data['EInvoiceGov'] = eInvoiceGov;
    data['EInvoiceRegionCity'] = eInvoiceRegionCity;
    data['EInvoiceStreet'] = eInvoiceStreet;
    data['EInvoiceBuildingNumber'] = eInvoiceBuildingNumber;
    data['EInvoiceType'] = eInvoiceType;
    data['EInvoiceCodeID'] = eInvoiceCodeID;
    data['CustomerAccountID'] = customerAccountID;
    data['CustomerAccountName'] = customerAccountName;
    data['Gov'] = gov;
    data['CustomerAccountAddress'] = customerAccountAddress;
    data['CustomerAccountCity'] = customerAccountCity;
    data['CustomerAccountTelephone2'] = customerAccountTelephone2;
    data['CustomerAccountEmail'] = customerAccountEmail;
    data['isContracted'] = isContracted;
    data['CandidateID'] = candidateID;
    data['CodeiD'] = codeiD;
    data['AreaName'] = areaName;
    data['GovName'] = govName;
    data['CWork'] = cWork;
    data['CustomerAccountCode'] = customerAccountCode;
    data['CardID'] = cardID;
    data['CardArea'] = cardArea;
    data['CardName'] = cardName;
    data['religion'] = religion;
    data['Nationality'] = nationality;
    data['Place'] = place;
    data['ISBuy'] = iSBuy;
    data['Salary'] = salary;
    data['ADSName'] = aDSName;
    data['ADSDescription'] = aDSDescription;
    data['AdsMasterId'] = adsMasterId;
    data['AdsID'] = adsID;
    data['NearPerson'] = nearPerson;
    data['NearPostion'] = nearPostion;
    data['NearPhon'] = nearPhon;
    data['NearAddress'] = nearAddress;
    data['NearMobile'] = nearMobile;
    data['NearWork'] = nearWork;
    data['Phone4'] = phone4;
    data['Phone3'] = phone3;
    data['Phone2'] = phone2;
    data['contractcount'] = contractcount;
    data['CustomerAccountMobile1'] = customerAccountMobile1;
    data['BirthDate'] = birthDate;
    data['ISpublic'] = iSpublic;
    data['CreateBy'] = createBy;
    data['ModifyBy'] = modifyBy;
    data['CreateAt'] = createAt;
    data['ModifyAt'] = modifyAt;
    data['ComID'] = comID;
    data['UserName'] = userName;
    data['Password'] = password;
    data['SecoundPrice'] = secoundPrice;
    data['BirthMounth'] = birthMounth;
    data['SalesMan'] = salesMan;
    data['SupplierID'] = supplierID;
    data['SalesManName'] = salesManName;
    data['CCName'] = cCName;
    data['CategoryID'] = categoryID;
    data['DepartmentId'] = departmentId;
    data['CreateByID'] = createByID;
    data['NonActiveCustomer'] = nonActiveCustomer;
    data['PERM'] = pERM;
    data['Code'] = code;
    data['DropDownSearch'] = dropDownSearch;
    data['IsDublicated'] = isDublicated;
    data['DirectMangerName'] = directMangerName;
    data['DirectManger'] = directManger;
    data['IsActiveEmployee'] = isActiveEmployee;
    data['ManagerName'] = managerName;
    data['AdsMethod'] = adsMethod;
    data['AdsMethodId'] = adsMethodId;
    data['Gov2'] = gov2;
    data['IndustryID'] = industryID;
    data['CountryName2'] = countryName2;
    data['areaname2'] = areaname2;
    data['govename2'] = govename2;
    data['createtime'] = createtime;
    data['createDate'] = createDate;
    data['CountryName'] = countryName;
    data['CategoryName2'] = categoryName2;
    data['CategoryName3'] = categoryName3;
    data['Category3'] = category3;
    data['Category2'] = category2;
    data['LabelConCat'] = labelConCat;
    data['LabelConCat2'] = labelConCat2;
    data['FullDublicated'] = fullDublicated;
    data['phoneDublicated'] = phoneDublicated;
    data['CusMonthyear'] = cusMonthyear;
    data['CreditLimit'] = creditLimit;
    data['CustomerCreditLimit'] = customerCreditLimit;
    data['CallResaultId'] = callResaultId;
    data['Discription3'] = discription3;
    data['CCreatBy'] = cCreatBy;
    data['CDescription'] = cDescription;
    data['CDate'] = cDate;
    data['CEmployee'] = cEmployee;
    data['CCreateAt'] = cCreateAt;
    data['NextCallDate'] = nextCallDate;
    data['EmpCustomerDepartment'] = empCustomerDepartment;
    data['EmpIndexString'] = empIndexString;
    data['AccountID'] = accountID;
    data['Closelocation'] = closelocation;
    return data;
  }
}
