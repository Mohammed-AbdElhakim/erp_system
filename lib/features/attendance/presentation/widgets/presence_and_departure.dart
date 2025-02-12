import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:slidable_button/slidable_button.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_error_massage.dart';
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
  List<double> radius = [];
  bool isLocation = false;
  ListValue? myLocation;
  bool isAttend = false;
  String deviceName = '';

  @override
  void initState() {
    super.initState();
    getData();
    getLocation();
    getDeviceName();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (lat != null && long != null)
          BlocProvider(
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
                        desc:
                            "${S.of(context).distance} ${radius.last}\n${S.of(context).no_location}",
                        onPressed: () {
                          GoRouter.of(context).pop();
                          GoRouter.of(context).pop();
                        });
                  }
                }
                if (state is SendAttendanceSuccess) {
                  Pref.saveBoolToPref(
                      key: AppStrings.isAttendKey, value: !isAttend);

                  GoRouter.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is GetAttendanceLocationsSuccess) {
                  return Column(
                    children: [
                      // Text("اسم الجهاز: $deviceName",
                      //     style: const TextStyle(fontSize: 20)),
                      Center(
                        child: VerticalSlidableButton(
                          height: MediaQuery.of(context).size.height / 3,
                          buttonHeight: 60.0,
                          color: AppColors.blueGreyLight,
                          buttonColor:
                              isAttend ? AppColors.green : AppColors.red,
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
                                BlocProvider.of<AttendanceCubit>(context)
                                    .sendAttendance(
                                  time: DateTime.now().toIso8601String(),
                                  machineID: myLocation!.machineID.toString(),
                                  checkType: "CheckOut",
                                );
                              } else {
                                BlocProvider.of<AttendanceCubit>(context)
                                    .sendAttendance(
                                  time: DateTime.now().toIso8601String(),
                                  machineID: myLocation!.machineID.toString(),
                                  checkType: "CheckIn",
                                );
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is AttendanceFailure) {
                  return CustomErrorMassage(errorMassage: state.errorMassage);
                } else {
                  return const CustomLoadingWidget();
                }
              },
            ),
          ),
        if (lat == null && long == null)
          const Column(
            children: [
              CustomLoadingWidget(),
              SizedBox(
                height: 15,
              ),
              Text(
                "Please wait to get your location...",
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
      ],
    );
  }

  isValidLocation(List<ListValue> list) {
    double distance;
    for (var item in list) {
      distance = (Geolocator.distanceBetween(
            lat ?? 0.0,
            long ?? 0.0,
            item.latitude,
            item.longitude,
          )) /
          1000;
      radius.add(distance);
      if (distance == item.radius ||
          distance < item.radius ||
          distance == 0.0) {
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

  Future<void> getLocation() async {
    Location location = Location();

    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var locationData = await location.getLocation();
    setState(() {
      lat = locationData.latitude;
      long = locationData.longitude;
    });
  }

  Future<void> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String name = "";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      name = androidInfo.name;
      if (name.isEmpty) {
        name = "${androidInfo.manufacturer} ${androidInfo.model}";
      }
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      name = iosInfo.name;
      if (name.isEmpty) {
        name = iosInfo.utsname.machine;
      }
    }

    setState(() {
      deviceName = name;
    });
  }
}
