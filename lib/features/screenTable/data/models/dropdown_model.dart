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
    final _data = <String, dynamic>{};
    _data['list'] = list.map((e) => e.toJson()).toList();
    return _data;
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
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['text'] = text;
    return _data;
  }
}
