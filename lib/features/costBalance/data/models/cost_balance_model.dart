class CostBalanceModel {
  int? acParent;
  String? acName;
  int? acID;
  String? acIndex;
  int? level;
  bool? beforCorD;
  double? beformony;
  double? creditmony;
  double? depitmony;
  bool? creditORDepit;
  double? mony;
  bool? isLast;

  CostBalanceModel(
      {this.acParent,
      this.acName,
      this.acID,
      this.acIndex,
      this.level,
      this.beforCorD,
      this.beformony,
      this.creditmony,
      this.depitmony,
      this.creditORDepit,
      this.mony,
      this.isLast});

  CostBalanceModel.fromJson(Map<String, dynamic> json) {
    acParent = json['AcParent'];
    acName = json['AcName'];
    acID = json['AcID'];
    acIndex = json['AcIndex'];
    level = json['level'];
    beforCorD = json['beforCorD'];
    beformony = json['beformony'];
    creditmony = json['Creditmony'];
    depitmony = json['depitmony'];
    creditORDepit = json['CreditORDepit'];
    mony = json['mony'];
    isLast = json['IsLast'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcParent'] = acParent;
    data['AcName'] = acName;
    data['AcID'] = acID;
    data['AcIndex'] = acIndex;
    data['level'] = level;
    data['beforCorD'] = beforCorD;
    data['beformony'] = beformony;
    data['Creditmony'] = creditmony;
    data['depitmony'] = depitmony;
    data['CreditORDepit'] = creditORDepit;
    data['mony'] = mony;
    data['IsLast'] = isLast;
    return data;
  }
}
