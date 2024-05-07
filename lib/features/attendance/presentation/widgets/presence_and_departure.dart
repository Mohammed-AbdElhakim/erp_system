import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/core/utils/app_styles.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:slidable_button/slidable_button.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
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
  double lat = 0;
  double long = 0;
  List<double> radius = [];
  bool isLocation = false;
  ListValue? myLocation;
  bool isAttend = false;

  @override
  void initState() {
    super.initState();
    getData();
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
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(end: 15, bottom: 15),
                  child: Text(
                    "User Location: ( Long => $long )  ( Lat => $lat )  ( Distance => $radius )",
                    textDirection: TextDirection.ltr,
                  ),
                ),
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ...List.generate(
                      state.locationModel.list.length,
                      (index) => Padding(
                        padding: const EdgeInsetsDirectional.only(
                            bottom: 15, end: 15),
                        child: Text(
                          "Location in Api ( ${index + 1} ): ( Long => ${state.locationModel.list[index].longitude} )  ( Lat => ${state.locationModel.list[index].latitude} )  ( Radius => ${state.locationModel.list[index].radius} )",
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: VerticalSlidableButton(
                    height: 170,
                    // height: MediaQuery.of(context).size.height / 3,
                    // buttonHeight: 60.0,
                    buttonHeight: 50.0,
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
    );
  }

  isValidLocation(List<ListValue> list) {
    double distance;
    for (var item in list) {
      distance = (Geolocator.distanceBetween(
            lat,
            long,
            item.latitude,
            item.longitude,
          )) /
          1000;
      radius.add(distance);
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
    double latPref =
        await Pref.getDoubleFromPref(key: AppStrings.latKey) ?? 0.0;
    double longPref =
        await Pref.getDoubleFromPref(key: AppStrings.longKey) ?? 0.0;
    setState(() {
      isAttend = state;
      lat = latPref;
      long = longPref;
    });
  }
}
