class NotificationsModel {
  List<Map<String, dynamic>>? notificationItem;
  int? numberofrecords;

  NotificationsModel({this.notificationItem, this.numberofrecords});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      notificationItem = <Map<String, dynamic>>[];
      json['dynamicList'].forEach((v) {
        notificationItem!.add(v);
      });
    }

    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationItem != null) {
      data['dynamicList'] = notificationItem!.map((v) => v).toList();
    }

    data['numberofrecords'] = numberofrecords;
    return data;
  }
}
