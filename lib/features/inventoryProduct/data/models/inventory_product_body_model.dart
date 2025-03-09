class InventoryProductBodyModel {
  late final String datefrom;
  late final String dateto;
  // late final int comID;
  // late final bool iszero;
  // late final int limit;
  // late final int page;
  late final int pram;
  // late final int totalRecords;
  late final int type;
  // late final bool iscompany;

  InventoryProductBodyModel({
    required this.datefrom,
    required this.dateto,
    // required this.comID,
    // required this.iszero,
    // required this.limit,
    // required this.page,
    required this.pram,
    // required this.totalRecords,
    this.type = 6,
    // required this.iscompany
  });

  InventoryProductBodyModel.fromJson(Map<String, dynamic> json) {
    datefrom = json['datefrom'];
    dateto = json['dateto'];
    // comID = json['ComID'];
    // iszero = json['Iszero'];
    // limit = json['limit'];
    // page = json['page'];
    pram = json['pram'];
    // totalRecords = json['totalRecords'];
    type = json['type'];
    // iscompany = json['Iscompany'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['datefrom'] = datefrom;
    data['dateto'] = dateto;
    // data['ComID'] = comID;
    // data['Iszero'] = iszero;
    // data['limit'] = limit;
    // data['page'] = page;
    data['pram'] = pram;
    // data['totalRecords'] = totalRecords;
    data['type'] = type;
    // data['Iscompany'] = iscompany;
    return data;
  }
}
