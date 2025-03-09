class DropdownModel {
  List<DropdownItem>? list;

  DropdownModel({this.list});

  DropdownModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <DropdownItem>[];
      json['list'].forEach((v) {
        list!.add(DropdownItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DropdownItem {
  String? value;
  String? text;

  DropdownItem({this.value, this.text});

  @override
  String toString() {
    return text!;
  }

  DropdownItem.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}
