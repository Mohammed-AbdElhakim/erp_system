class TrialCostBodyModel {
  late final String datefrom;
  late final String dateto;
  late final int comID;
  late final bool iszero;
  late final int pram;
  late final int type;
  late final bool iscompany;

  TrialCostBodyModel(
      {required this.datefrom,
      required this.dateto,
      required this.comID,
      required this.iszero,
      required this.type,
      required this.pram,
      required this.iscompany});

  TrialCostBodyModel.fromJson(Map<String, dynamic> json) {
    datefrom = json['datefrom'];
    dateto = json['dateto'];
    comID = json['ComID'];
    iszero = json['Iszero'];
    iscompany = json['Iscompany'];
    type = json['type'];
    pram = json['pram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['datefrom'] = datefrom;
    data['dateto'] = dateto;
    data['ComID'] = comID;
    data['Iszero'] = iszero;
    data['type'] = type;
    data['pram'] = pram;
    data['Iscompany'] = iscompany;
    return data;
  }
}
