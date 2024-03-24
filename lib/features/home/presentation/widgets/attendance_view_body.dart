import 'package:flutter/material.dart';
import 'package:location/location.dart';

class AttendanceViewBody extends StatefulWidget {
  const AttendanceViewBody({super.key});

  @override
  State<AttendanceViewBody> createState() => _AttendanceViewBodyState();
}

class _AttendanceViewBodyState extends State<AttendanceViewBody> {
  double? lat;
  double? long;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    Location location = Location();

    LocationData? locationData;
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    setState(() {
      lat = locationData?.latitude;
      long = locationData?.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 150,
          ),
          if (lat == null || long == null) const CircularProgressIndicator(),
          if (lat != null || long != null) Text("lat => $lat"),
          if (lat != null || long != null) Text("long => $long"),
        ],
      ),
    );
  }
}
