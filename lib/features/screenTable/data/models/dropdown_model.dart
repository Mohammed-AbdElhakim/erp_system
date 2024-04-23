class DropdownModel {
  DropdownModel({
    required this.list,
  });
  late final List<ListDropdown> list;

  DropdownModel.fromJson(Map<String, dynamic> json) {
    list =
        List.from(json['list']).map((e) => ListDropdown.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list'] = list.map((e) => e.toJson()).toList();
    return data;
  }
}

class ListDropdown {
  ListDropdown({
    required this.value,
    required this.text,
  });
  late final int value;
  late final String text;

  ListDropdown.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}
