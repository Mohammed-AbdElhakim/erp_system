class LocationModel {
  LocationModel({
    required this.list,
  });
  late final List<ListValue> list;

  LocationModel.fromJson(Map<String, dynamic> json) {
    list = List.from(json['list']).map((e) => ListValue.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list'] = list.map((e) => e.toJson()).toList();
    return data;
  }
}

class ListValue {
  ListValue({
    required this.employeeID,
    required this.machineID,
    required this.longitude,
    required this.latitude,
    required this.radius,
  });
  late final int employeeID;
  late final int machineID;
  late final double longitude;
  late final double latitude;
  late final double radius;

  ListValue.fromJson(Map<String, dynamic> json) {
    employeeID = json['EmployeeID'];
    machineID = json['MachineID'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    radius = json['Radius'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['EmployeeID'] = employeeID;
    data['MachineID'] = machineID;
    data['Longitude'] = longitude;
    data['Latitude'] = latitude;
    data['Radius'] = radius;
    return data;
  }
}
