import 'dart:math' as math;

import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/core/utils/app_styles.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:slidable_button/slidable_button.dart';

import '../../../../core/helper/AlertDialog/alert_dialog.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/location_model.dart';
import '../../data/repositories/attendance_repo_impl.dart';
import '../manager/attendanceCubit/attendance_cubit.dart';

class PresenceAndDeparture extends StatefulWidget {
  const PresenceAndDeparture({
    super.key,
  });

  @override
  State<PresenceAndDeparture> createState() => _PresenceAndDepartureState();
}

class _PresenceAndDepartureState extends State<PresenceAndDeparture> {
  double? lat;
  double? long;
  bool isLocation = false;
  ListValue? myLocation;
  bool isAttend = false;

  @override
  void initState() {
    super.initState();
    getData();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceCubit(
        getIt.get<AttendanceRepoImpl>(),
      )..getAttendanceLocations(),
      child: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is GetAttendanceLocationsSuccess) {
            isValidLocation(state.locationModel.list);
            if (isLocation == false) {
              CustomAlertDialog.alertWithButton(
                  context: context,
                  type: AlertType.error,
                  isCloseButton: false,
                  isOverlayTapDismiss: false,
                  title: S.of(context).error,
                  desc: S.of(context).no_location,
                  onPressed: () {
                    GoRouter.of(context).pop();
                    GoRouter.of(context).pop();
                  });
            }
          }
          if (state is SendAttendanceSuccess) {
            Pref.saveBoolToPref(key: AppStrings.isAttendKey, value: !isAttend);

            GoRouter.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is GetAttendanceLocationsSuccess) {
            return Center(
              child: VerticalSlidableButton(
                height: MediaQuery.of(context).size.height / 3,
                buttonHeight: 60.0,
                color: AppColors.blueGreyLight,
                buttonColor: isAttend ? AppColors.green : AppColors.red,
                dismissible: false,
                width: 90,
                initialPosition: isAttend == true
                    ? SlidableButtonPosition.start
                    : SlidableButtonPosition.end,
                label: Center(
                  child: Text(
                    S.of(context).swipe_to,
                    style: AppStyles.textStyle12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(S.of(context).attend),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Text(S.of(context).leave),
                    ),
                  ],
                ),
                onChanged: (position) {
                  setState(() {
                    if (position == SlidableButtonPosition.end) {
                      BlocProvider.of<AttendanceCubit>(context).sendAttendance(
                        time: DateTime.now().toIso8601String(),
                        machineID: myLocation!.machineID.toString(),
                      );
                    } else {
                      BlocProvider.of<AttendanceCubit>(context).sendAttendance(
                        time: DateTime.now().toIso8601String(),
                        machineID: myLocation!.machineID.toString(),
                      );
                    }
                  });
                },
              ),
            );
          } else if (state is AttendanceFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
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

  getDistanceFromLatLonInKm({
    required double lat1,
    required double long1,
    required double lat2,
    required double long2,
  }) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(long2 - long1);
    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(lat1)) *
            math.cos(deg2rad(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  deg2rad(double deg) {
    return deg * (math.pi / 180);
  }

  isValidLocation(List<ListValue> list) {
    double distance;
    for (var item in list) {
      distance = getDistanceFromLatLonInKm(
        lat1: lat ?? 0.0,
        long1: long ?? 0.0,
        // lat1: 31.181040,
        // long1: 29.928099,
        lat2: item.latitude,
        long2: item.longitude,
      );

      if (distance.toInt() == item.radius ||
          distance.toInt() < item.radius ||
          distance.toInt() == 0) {
        setState(() {
          isLocation = true;
          myLocation = item;
        });
        return;
      } else {
        setState(() {
          isLocation = false;
        });
      }
    }
  }

  void getData() async {
    bool state =
        await Pref.getBoolFromPref(key: AppStrings.isAttendKey) ?? false;
    setState(() {
      isAttend = state;
    });
  }
}