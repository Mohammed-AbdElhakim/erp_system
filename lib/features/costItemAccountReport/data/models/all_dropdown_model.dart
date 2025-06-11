class AllDropdownModel {
  String? listName;
  List<ListDrop>? list;

  AllDropdownModel({this.listName, this.list});

  AllDropdownModel.fromJson(Map<String, dynamic> json) {
    listName = json['ListName'];
    if (json['List'] != null) {
      list = <ListDrop>[];
      json['List'].forEach((v) {
        list!.add(ListDrop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ListName'] = listName;
    if (list != null) {
      data['List'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListDrop {
  String? columnName;
  List<ItemDrop>? list;

  ListDrop({this.columnName, this.list});

  ListDrop.fromJson(Map<String, dynamic> json) {
    columnName = json['ColumnName'];
    if (json['List'] != null) {
      list = <ItemDrop>[];
      json['List'].forEach((v) {
        list!.add(ItemDrop.fromJson(v));
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

class ItemDrop {
  String? id;
  String? text;

  ItemDrop({this.id, this.text});

  ItemDrop.fromJson(Map<String, dynamic> json) {
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
