class DropdownModel {
  DropdownModel({
    required this.list,
  });
  List<ListDropdownModel>? list;

  DropdownModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ListDropdownModel>[];
      json['list'].forEach((v) {
        list!.add(ListDropdownModel.fromJson(v));
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

class ListDropdownModel {
  final int value;
  final String? text;

  ListDropdownModel({required this.value, required this.text});
  factory ListDropdownModel.fromJson(Map<String, dynamic> json) =>
      ListDropdownModel(
        text: json['text'] ?? '' as String?,
        value: json['value'] as int,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['text'] = text;
    return data;
  }
}
