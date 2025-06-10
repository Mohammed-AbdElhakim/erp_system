class TrialCostModel {
  List<TrialCostItem>? trialCostItemsList;

  TrialCostModel({this.trialCostItemsList});

  TrialCostModel.fromJson(Map<String, dynamic> json) {
    if (json['display'] != null) {
      trialCostItemsList = <TrialCostItem>[];
      json['display'].forEach((v) {
        trialCostItemsList!.add(TrialCostItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (trialCostItemsList != null) {
      data['display'] = trialCostItemsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrialCostItem {
  String? acName;
  int? acID;
  int? acIndex;
  int? level;
  bool? beforCorD;
  double? beformony;
  double? creditmony;
  double? depitmony;
  bool? creditORDepit;
  double? mony;
  int? acParent;

  TrialCostItem(
      {this.acName,
      this.acID,
      this.acIndex,
      this.level,
      this.beforCorD,
      this.beformony,
      this.creditmony,
      this.depitmony,
      this.creditORDepit,
      this.mony,
      this.acParent});

  TrialCostItem.fromJson(Map<String, dynamic> json) {
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
    acParent = json['AcParent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['AcParent'] = acParent;
    return data;
  }
}
