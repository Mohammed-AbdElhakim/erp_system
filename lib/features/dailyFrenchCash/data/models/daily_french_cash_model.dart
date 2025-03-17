class DailyFrenchCashModel {
  List<ListItem>? list;
  List<Total>? totalAccount;
  List<Total>? totalEntry;
  double? totalAll;
  List<Columns>? columns;

  DailyFrenchCashModel(
      {this.list, this.totalAccount, this.totalEntry, this.totalAll, this.columns});

  DailyFrenchCashModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ListItem>[];
      json['list'].forEach((v) {
        list!.add(ListItem.fromJson(v));
      });
    }
    if (json['totalaccount'] != null) {
      totalAccount = <Total>[];
      json['totalaccount'].forEach((v) {
        totalAccount!.add(Total.fromJson(v));
      });
    }
    if (json['totalentry'] != null) {
      totalEntry = <Total>[];
      json['totalentry'].forEach((v) {
        totalEntry!.add(Total.fromJson(v));
      });
    }
    totalAll = json['totalall'];
    if (json['columns'] != null) {
      columns = <Columns>[];
      json['columns'].forEach((v) {
        columns!.add(Columns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (totalAccount != null) {
      data['totalaccount'] = totalAccount!.map((v) => v.toJson()).toList();
    }
    if (totalEntry != null) {
      data['totalentry'] = totalEntry!.map((v) => v.toJson()).toList();
    }
    data['totalall'] = totalAll;
    if (columns != null) {
      data['columns'] = columns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListItem {
  int? accountID;
  String? acName;
  bool? creditORDepit;
  double? mony;
  String? eDate;
  String? eNote;
  String? eDescription;
  int? eMasterID;

  ListItem(
      {this.accountID,
      this.acName,
      this.creditORDepit,
      this.mony,
      this.eDate,
      this.eNote,
      this.eDescription,
      this.eMasterID});

  ListItem.fromJson(Map<String, dynamic> json) {
    accountID = json['AccountID'];
    acName = json['AcName'];
    creditORDepit = json['CreditORDepit'];
    mony = json['Mony'];
    eDate = json['EDate'];
    eNote = json['ENote'];
    eDescription = json['EDescription'];
    eMasterID = json['EMasterID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AccountID'] = accountID;
    data['AcName'] = acName;
    data['CreditORDepit'] = creditORDepit;
    data['Mony'] = mony;
    data['EDate'] = eDate;
    data['ENote'] = eNote;
    data['EDescription'] = eDescription;
    data['EMasterID'] = eMasterID;
    return data;
  }
}

class Total {
  double? total;
  int? key;

  Total({this.total, this.key});

  Total.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    key = json['Key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['Key'] = key;
    return data;
  }
}

class Columns {
  String? acName;
  bool? creditORDepit;
  int? accountID;

  Columns({this.acName, this.creditORDepit, this.accountID});

  Columns.fromJson(Map<String, dynamic> json) {
    acName = json['AcName'];
    creditORDepit = json['CreditORDepit'];
    accountID = json['AccountID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AcName'] = acName;
    data['CreditORDepit'] = creditORDepit;
    data['AccountID'] = accountID;
    return data;
  }
}
