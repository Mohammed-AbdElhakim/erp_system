class CustomerAccountEntriesModel {
  List<CustomerAccountEntriesItem>? customerAccountEntriesItemList;
  int? numberofrecords;

  CustomerAccountEntriesModel({this.customerAccountEntriesItemList, this.numberofrecords});

  CustomerAccountEntriesModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      customerAccountEntriesItemList = <CustomerAccountEntriesItem>[];
      json['dynamicList'].forEach((v) {
        customerAccountEntriesItemList!.add(CustomerAccountEntriesItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerAccountEntriesItemList != null) {
      data['dynamicList'] = customerAccountEntriesItemList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class CustomerAccountEntriesItem {
  int? customerAccountID;
  String? customerAccountName;

  CustomerAccountEntriesItem({
    this.customerAccountID,
    this.customerAccountName,
  });

  CustomerAccountEntriesItem.fromJson(Map<String, dynamic> json) {
    customerAccountID = json['CustomerAccountID'];
    customerAccountName = json['CustomerAccountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CustomerAccountID'] = customerAccountID;
    data['CustomerAccountName'] = customerAccountName;

    return data;
  }

  @override
  String toString() {
    return '$customerAccountName';
  }
}
