class BillsDataModel {
  double? totalbeforshippingPrice;
  double? totalAfterDiscount;
  double? discount;
  double? discountDetailTotal;
  double? tax;
  double? addTax;
  double? taxDetailTotal;
  double? finaltotal;
  double? finalValue;
  double? contractQuantity;
  int? contractID;
  String? contractDate;
  int? comID;
  String? contractNote;
  int? customerID;
  String? customerAccountName;
  int? maxend;
  int? maxstart;
  int? minstart;
  int? minend;
  int? estCount;
  int? autoNumber;
  String? autostates;
  int? stateCode;
  String? customerAccountAddress;
  String? customerAccountMobile1;
  String? customerAccountEmail;
  double? totalOrder;
  double? shippingPrice;
  String? salesManName;
  String? phone2;
  String? areaName;
  String? govName;

  BillsDataModel({
    this.totalbeforshippingPrice,
    this.totalAfterDiscount,
    this.discount,
    this.discountDetailTotal,
    this.tax,
    this.addTax,
    this.taxDetailTotal,
    this.finaltotal,
    this.finalValue,
    this.contractQuantity,
    this.contractID,
    this.contractDate,
    this.comID,
    this.contractNote,
    this.customerID,
    this.customerAccountName,
    this.maxend,
    this.maxstart,
    this.minstart,
    this.minend,
    this.estCount,
    this.autoNumber,
    this.autostates,
    this.stateCode,
    this.customerAccountAddress,
    this.customerAccountMobile1,
    this.customerAccountEmail,
    this.totalOrder,
    this.shippingPrice,
    this.salesManName,
    this.phone2,
    this.areaName,
    this.govName,
  });

  BillsDataModel.fromJson(Map<String, dynamic> json) {
    totalbeforshippingPrice = json['totalbeforshippingPrice'];
    totalAfterDiscount = json['TotalAfterDiscount'];
    discount = json['Discount'];
    discountDetailTotal = json['DiscountDetailTotal'];
    tax = json['Tax'];
    addTax = json['AddTax'];
    taxDetailTotal = json['TaxDetailTotal'];
    finaltotal = json['finaltotal'];
    finalValue = json['finalValue'];
    contractQuantity = json['ContractQuantity'];
    contractID = json['ContractID'];
    contractDate = json['ContractDate'];
    comID = json['ComID'];
    contractNote = json['ContractNote'];
    customerID = json['CustomerID'];
    customerAccountName = json['CustomerAccountName'];
    maxend = json['maxend'];
    maxstart = json['maxstart'];
    minstart = json['minstart'];
    minend = json['minend'];
    estCount = json['EstCount'];
    autoNumber = json['AutoNumber'];
    autostates = json['autostates'];
    stateCode = json['StateCode'];
    customerAccountAddress = json['CustomerAccountAddress'];
    customerAccountMobile1 = json['CustomerAccountMobile1'];
    customerAccountEmail = json['CustomerAccountEmail'];
    totalOrder = json['TotalOrder'];
    shippingPrice = json['shippingPrice'];
    salesManName = json['SalesManName'];
    phone2 = json['Phone2'];
    areaName = json['AreaName'];
    govName = json['GovName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalbeforshippingPrice'] = totalbeforshippingPrice;
    data['TotalAfterDiscount'] = totalAfterDiscount;
    data['Discount'] = discount;
    data['DiscountDetailTotal'] = discountDetailTotal;
    data['Tax'] = tax;
    data['AddTax'] = addTax;
    data['TaxDetailTotal'] = taxDetailTotal;
    data['finaltotal'] = finaltotal;
    data['finalValue'] = finalValue;
    data['ContractQuantity'] = contractQuantity;
    data['ContractID'] = contractID;
    data['ContractDate'] = contractDate;
    data['ComID'] = comID;
    data['ContractNote'] = contractNote;
    data['CustomerID'] = customerID;
    data['CustomerAccountName'] = customerAccountName;
    data['maxend'] = maxend;
    data['maxstart'] = maxstart;
    data['minstart'] = minstart;
    data['minend'] = minend;
    data['EstCount'] = estCount;
    data['AutoNumber'] = autoNumber;
    data['autostates'] = autostates;
    data['StateCode'] = stateCode;
    data['CustomerAccountAddress'] = customerAccountAddress;
    data['CustomerAccountMobile1'] = customerAccountMobile1;
    data['CustomerAccountEmail'] = customerAccountEmail;
    data['TotalOrder'] = totalOrder;
    data['shippingPrice'] = shippingPrice;
    data['SalesManName'] = salesManName;
    data['Phone2'] = phone2;
    data['AreaName'] = areaName;
    data['GovName'] = govName;
    return data;
  }
}
