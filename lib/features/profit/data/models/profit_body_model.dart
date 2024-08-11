class ProfitBodyModel {
  late final String datefrom;
  late final String dateto;
  late final int comID;
  late final bool iszero;
  late final String accName;
  late final String accName2;
  late final bool iscompany;

  ProfitBodyModel(
      {required this.datefrom,
      required this.dateto,
      required this.comID,
      required this.iszero,
      required this.accName,
      required this.accName2,
      required this.iscompany});

  ProfitBodyModel.fromJson(Map<String, dynamic> json) {
    datefrom = json['datefrom'];
    dateto = json['dateto'];
    comID = json['ComID'];
    iszero = json['Iszero'];
    accName = json['accName'];
    accName2 = json['accName2'];
    iscompany = json['Iscompany'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['datefrom'] = datefrom;
    data['dateto'] = dateto;
    data['ComID'] = comID;
    data['Iszero'] = iszero;
    data['accName'] = accName;
    data['accName2'] = accName2;
    data['Iscompany'] = iscompany;
    return data;
  }
}
