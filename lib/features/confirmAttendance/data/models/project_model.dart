class ProjectModel {
  List<ProjectItem>? listProject;
  int? numberofrecords;

  ProjectModel({this.listProject, this.numberofrecords});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      listProject = <ProjectItem>[];
      json['dynamicList'].forEach((v) {
        listProject!.add(ProjectItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listProject != null) {
      data['dynamicList'] = listProject!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class ProjectItem {
  int? mID;
  String? serialNumber;
  int? projectID;
  String? location;
  String? startDate;
  String? endDate;
  int? comID;
  String? lastDateTime;
  bool? isOverShiftCheckOut;
  String? overShiftStratTime;
  String? overShiftEndTime;
  String? mName;
  double? longitude;
  double? latitude;
  double? radius;

  ProjectItem(
      {this.mID,
      this.serialNumber,
      this.projectID,
      this.location,
      this.startDate,
      this.endDate,
      this.comID,
      this.lastDateTime,
      this.isOverShiftCheckOut,
      this.overShiftStratTime,
      this.overShiftEndTime,
      this.mName,
      this.longitude,
      this.latitude,
      this.radius});

  @override
  String toString() {
    return '$location';
  }

  ProjectItem.fromJson(Map<String, dynamic> json) {
    mID = json['MID'];
    serialNumber = json['SerialNumber'];
    projectID = json['ProjectID'];
    location = json['Location'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    comID = json['ComID'];
    lastDateTime = json['LastDateTime'];
    isOverShiftCheckOut = json['IsOverShiftCheckOut'];
    overShiftStratTime = json['OverShiftStratTime'];
    overShiftEndTime = json['OverShiftEndTime'];
    mName = json['MName'];
    longitude = json['Longitude'];
    latitude = json['Latitude'];
    radius = json['Radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MID'] = mID;
    data['SerialNumber'] = serialNumber;
    data['ProjectID'] = projectID;
    data['Location'] = location;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['ComID'] = comID;
    data['LastDateTime'] = lastDateTime;
    data['IsOverShiftCheckOut'] = isOverShiftCheckOut;
    data['OverShiftStratTime'] = overShiftStratTime;
    data['OverShiftEndTime'] = overShiftEndTime;
    data['MName'] = mName;
    data['Longitude'] = longitude;
    data['Latitude'] = latitude;
    data['Radius'] = radius;
    return data;
  }
}
