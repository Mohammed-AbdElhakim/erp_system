class CurrencyModel {
  List<CurrencyItem>? currencyItemList;
  int? numberofrecords;

  CurrencyModel({this.currencyItemList, this.numberofrecords});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      currencyItemList = <CurrencyItem>[];
      json['dynamicList'].forEach((v) {
        currencyItemList!.add(CurrencyItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (currencyItemList != null) {
      data['dynamicList'] = currencyItemList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class CurrencyItem {
  int? cID;
  String? cName;

  CurrencyItem({
    this.cID,
    this.cName,
  });

  CurrencyItem.fromJson(Map<String, dynamic> json) {
    cID = json['CID'];
    cName = json['CName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CID'] = cID;
    data['CName'] = cName;

    return data;
  }

  @override
  String toString() {
    return '$cName';
  }
}
