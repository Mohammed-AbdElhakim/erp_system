class ProfitModel {
  int? acID;
  int? level;
  double? mony;
  bool? creditORDepit;
  String? description;
  double? acIndex;
  bool? isLast;
  int? acParent;

  ProfitModel(
      {this.acID,
      this.level,
      this.mony,
      this.creditORDepit,
      this.description,
      this.acIndex,
      this.isLast,
      this.acParent});

  ProfitModel.fromJson(Map<String, dynamic> json) {
    acID = json['AcID'];
    level = json['level'];
    mony = json['Mony'];
    creditORDepit = json['CreditORDepit'];
    description = json['description'];
    acIndex = json['AcIndex'];
    isLast = json['IsLast'];
    acParent = json['AcParent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcID'] = acID;
    data['level'] = level;
    data['Mony'] = mony;
    data['CreditORDepit'] = creditORDepit;
    data['description'] = description;
    data['AcIndex'] = acIndex;
    data['IsLast'] = isLast;
    data['AcParent'] = acParent;
    return data;
  }
}
