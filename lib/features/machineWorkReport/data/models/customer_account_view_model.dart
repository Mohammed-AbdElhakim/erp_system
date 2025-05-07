class CustomerAccountViewModel {
  List<CustomerAccountViewItem>? customerAccountViewItemList;
  int? numberofrecords;

  CustomerAccountViewModel({this.customerAccountViewItemList, this.numberofrecords});

  CustomerAccountViewModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      customerAccountViewItemList = <CustomerAccountViewItem>[];
      json['dynamicList'].forEach((v) {
        customerAccountViewItemList!.add(CustomerAccountViewItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customerAccountViewItemList != null) {
      data['dynamicList'] = customerAccountViewItemList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class CustomerAccountViewItem {
  int? customerAccountID;
  String? customerAccountName;

  CustomerAccountViewItem({
    this.customerAccountID,
    this.customerAccountName,
  });

  CustomerAccountViewItem.fromJson(Map<String, dynamic> json) {
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
