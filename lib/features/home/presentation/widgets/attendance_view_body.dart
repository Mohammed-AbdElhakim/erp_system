import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_strings.dart';
import 'custom_circular_button.dart';

class AttendanceViewBody extends StatefulWidget {
  const AttendanceViewBody({super.key});

  @override
  State<AttendanceViewBody> createState() => _AttendanceViewBodyState();
}

class _AttendanceViewBodyState extends State<AttendanceViewBody> {
  double? lat;
  double? long;
  String? uniqueId;
  bool youHavePermission = false;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    uniqueId = await Pref.getStringFromPref(key: AppStrings.uniqueIdKey) ?? "";
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
    return youHavePermission
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                if (lat == null || long == null)
                  const CircularProgressIndicator(),
                if (lat != null || long != null) Text("lat => $lat"),
                if (lat != null || long != null) Text("long => $long"),
                if (uniqueId != null) Text("uniqueId => $uniqueId"),
                const CustomCircularButton(
                  text: 'Presence',
                  color: Colors.green,
                ),
                const CustomCircularButton(
                  text: 'Departure',
                  color: Colors.red,
                ),
              ],
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    "You do not have permission yet, Refresh the page!!!"),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        youHavePermission = true;
                      });
                    },
                    child: const Text("Refresh"))
              ],
            ),
          );
  }
}