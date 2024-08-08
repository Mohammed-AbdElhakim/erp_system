class ProfitBodyModel {
  late final String datefrom;
  late final String dateto;
  late final int product;
  late final int comID;
  late final bool iszero;
  late final int currancy;
  late final int customer;
  late final int supplier;
  late final int cost;
  late final bool iscompany;

  ProfitBodyModel(
      {required this.datefrom,
      required this.dateto,
      required this.product,
      required this.comID,
      required this.iszero,
      required this.currancy,
      required this.customer,
      required this.supplier,
      required this.cost,
      required this.iscompany});

  ProfitBodyModel.fromJson(Map<String, dynamic> json) {
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
