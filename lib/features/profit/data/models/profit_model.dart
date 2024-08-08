class ProfitModel {
  int? acID;
  int? level;
  int? mony;
  bool? creditORDepit;
  String? description;
  int? acIndex;
  bool? isLast;

  ProfitModel(
      {this.acID,
      this.level,
      this.mony,
      this.creditORDepit,
      this.description,
      this.acIndex,
      this.isLast});

  ProfitModel.fromJson(Map<String, dynamic> json) {
    acID = json['AcID'];
    level = json['level'];
    mony = json['Mony'];
    creditORDepit = json['CreditORDepit'];
    description = json['description'];
    acIndex = json['AcIndex'];
    isLast = json['IsLast'];
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
    return data;
  }
}
