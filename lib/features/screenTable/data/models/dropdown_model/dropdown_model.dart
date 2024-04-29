class DropdownModel {
  DropdownModel({
    required this.list,
  });
  late final List<ListDropdownModel> list;

  DropdownModel.fromJson(Map<String, dynamic> json) {
    list = List.from(json['list'])
        .map((e) => ListDropdownModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list'] = list.map((e) => e.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['text'] = this.text;
    return data;
  }
}
