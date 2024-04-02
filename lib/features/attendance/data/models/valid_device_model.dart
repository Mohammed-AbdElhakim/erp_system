class ValidDeviceModel {
  ValidDeviceModel({
    required this.status,
  });
  late final String status;

  ValidDeviceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}
