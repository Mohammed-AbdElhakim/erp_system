class OfferMasterModel {
  List<States>? states;
  List<Offers>? offerNOStats;

  OfferMasterModel({this.states, this.offerNOStats});

  OfferMasterModel.fromJson(Map<String, dynamic> json) {
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(States.fromJson(v));
      });
    }
    if (json['offerNOStats'] != null) {
      offerNOStats = <Offers>[];
      json['offerNOStats'].forEach((v) {
        offerNOStats!.add(Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (states != null) {
      data['states'] = states!.map((v) => v.toJson()).toList();
    }
    if (offerNOStats != null) {
      data['offerNOStats'] = offerNOStats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  String? arName;
  String? enName;
  String? color;
  int? id;
  double? totMony;
  List<Offers>? offers;

  States({this.arName, this.enName, this.color, this.id, this.totMony, this.offers});

  States.fromJson(Map<String, dynamic> json) {
    arName = json['ArName'];
    enName = json['EnName'];
    color = json['Color'];
    id = json['Id'];
    totMony = json['totMony'];
    if (json['offers'] != null) {
      offers = <Offers>[];
      json['offers'].forEach((v) {
        offers!.add(Offers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ArName'] = arName;
    data['EnName'] = enName;
    data['Color'] = color;
    data['Id'] = id;
    data['totMony'] = totMony;
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Offers {
  String? oMName;
  String? offerDate;
  int? stateId;
  int? oMID;
  double? mony;
  String? customer;

  Offers({this.oMName, this.offerDate, this.stateId, this.oMID, this.mony, this.customer});

  Offers.fromJson(Map<String, dynamic> json) {
    oMName = json['OMName'] ?? "";
    offerDate = json['OfferDate'] ?? "";
    stateId = json['StateId'] ?? -1;
    oMID = json['OMID'] ?? -1;
    mony = json['mony'] ?? 0;
    customer = json['Customer'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OMName'] = oMName;
    data['OfferDate'] = offerDate;
    data['StateId'] = stateId;
    data['OMID'] = oMID;
    data['mony'] = mony;
    data['Customer'] = customer;
    return data;
  }
}
