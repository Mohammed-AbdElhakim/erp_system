class AllDropdownModel {
  String? columnName;
  List<ListDrop>? list;

  AllDropdownModel({this.columnName, this.list});

  AllDropdownModel.fromJson(Map<String, dynamic> json) {
    columnName = json['ColumnName'];
    if (json['List'] != null) {
      list = <ListDrop>[];
      json['List'].forEach((v) {
        list!.add(new ListDrop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ColumnName'] = this.columnName;
    if (this.list != null) {
      data['List'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListDrop {
  int? id;
  String? text;

  ListDrop({this.id, this.text});

  ListDrop.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    text = json['Text'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Text'] = this.text;
    return data;
  }
}
