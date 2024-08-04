class TrialBalanceBodyModel {
  String? datefrom;
  String? dateto;
  int? product;
  int? comID;
  bool? iszero;
  int? currancy;
  int? customer;
  int? supplier;
  int? cost;
  bool? iscompany;

  TrialBalanceBodyModel(
      {this.datefrom,
      this.dateto,
      this.product,
      this.comID,
      this.iszero,
      this.currancy,
      this.customer,
      this.supplier,
      this.cost,
      this.iscompany});

  TrialBalanceBodyModel.fromJson(Map<String, dynamic> json) {
    datefrom = json['datefrom'];
    dateto = json['dateto'];
    product = json['product'];
    comID = json['ComID'];
    iszero = json['Iszero'];
    currancy = json['currancy'];
    customer = json['customer'];
    supplier = json['supplier'];
    cost = json['cost'];
    iscompany = json['Iscompany'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['datefrom'] = datefrom;
    data['dateto'] = dateto;
    data['product'] = product;
    data['ComID'] = comID;
    data['Iszero'] = iszero;
    data['currancy'] = currancy;
    data['customer'] = customer;
    data['supplier'] = supplier;
    data['cost'] = cost;
    data['Iscompany'] = iscompany;
    return data;
  }
}
