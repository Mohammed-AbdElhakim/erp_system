class AllDropdownModel {
  String? columnName;
  List<ListDrop>? list;

  AllDropdownModel({this.columnName, this.list});

  AllDropdownModel.fromJson(Map<String, dynamic> json) {
    columnName = json['ColumnName'];
    if (json['List'] != null) {
      list = <ListDrop>[];
      json['List'].forEach((v) {
        list!.add(ListDrop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ColumnName'] = columnName;
    if (list != null) {
      data['List'] = list!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Text'] = text;
    return data;
  }
}
