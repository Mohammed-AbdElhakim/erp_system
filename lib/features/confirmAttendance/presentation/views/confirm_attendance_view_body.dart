import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_date_widget.dart';
import '../../../../core/widgets/custom_dropdown_list.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/confirm_attendance_model.dart';
import '../../data/models/group_model.dart';
import '../../data/models/project_model.dart';
import '../manager/confirmAttendance/confirm_attendance_cubit.dart';
import '../manager/getDataConfirmAttendance/confirm_attendance_cubit.dart';
import 'custom_table_widget.dart';

class ConfirmAttendanceViewBody extends StatefulWidget {
  const ConfirmAttendanceViewBody({super.key});

  @override
  State<ConfirmAttendanceViewBody> createState() => _ConfirmAttendanceViewBodyState();
}

class _ConfirmAttendanceViewBodyState extends State<ConfirmAttendanceViewBody> {
  String date = "";
  int groupID = 0;
  List<ProjectItem> listProjects = [];
  List<GroupItem> listGroups = [];
  Map<String, dynamic> bodyRequest = {};
  List<Map<String, dynamic>> confirmBodyRequest = [];

  @override
  void initState() {
    initStateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 12, right: 12),
          child: Column(
            children: [
              CustomDropdownList<GroupItem>(
                listData: listGroups,
                onChanged: (groupItem) {
                  setState(() {
                    groupID = groupItem?.groupID ?? 0;
                    if (groupID == 0) {
                      bodyRequest.remove("groupId");
                    } else {
                      bodyRequest["groupId"] = groupID;
                    }
                  });
                  if (date.isNotEmpty) {
                    BlocProvider.of<GetDataConfirmAttendanceCubit>(context).getDataConfirmAttendance(
                      bodyRequest: bodyRequest,
                    );
                  }
                },
                title: S.of(context).group,
              ),
              const SizedBox(height: 8),
              CustomDateWidget(
                onSelect: (myDate) {
                  setState(() {
                    date = myDate;
                    if (date == "") {
                      bodyRequest.remove("date");
                    } else {
                      bodyRequest["date"] = date;
                    }
                  });
                  if (groupID != 0) {
                    BlocProvider.of<GetDataConfirmAttendanceCubit>(context).getDataConfirmAttendance(
                      bodyRequest: bodyRequest,
                    );
                  }
                },
                title: S.of(context).date,
              ),
            ],
          ),
        ),
        if (confirmBodyRequest.isNotEmpty)
          BlocConsumer<ConfirmAttendanceCubit, ConfirmAttendanceState>(
            listener: (context, state) {
              if (state is ConfirmAttendanceSuccess) {
                BlocProvider.of<GetDataConfirmAttendanceCubit>(context).getDataConfirmAttendance(
                  bodyRequest: bodyRequest,
                );
              } else if (state is ConfirmAttendanceFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 6),
                    content: Text(
                      state.errorMassage,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    backgroundColor: AppColors.blueLight,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is ConfirmAttendanceLoading) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: CustomLoadingWidget(),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CustomButton(
                    text: S.of(context).confirm,
                    width: MediaQuery.sizeOf(context).width * .5,
                    onTap: () {
                      BlocProvider.of<ConfirmAttendanceCubit>(context).confirmAttendance(
                        bodyRequest: confirmBodyRequest,
                      );
                    },
                  ),
                );
              }
            },
          ),
        BlocBuilder<GetDataConfirmAttendanceCubit, GetDataConfirmAttendanceState>(
          builder: (context, state) {
            if (state is GetDataConfirmAttendanceSuccess) {
              List<ConfirmAttendanceModel> confirmAttendanceList = state.listDataConfirmAttendance;
              return CustomTableWidget(
                listData: confirmAttendanceList,
                listProjects: listProjects,
                onTapRow: (rowData) {
                  confirmBodyRequest.clear();
                  for (var i in rowData) {
                    final ConfirmAttendanceModel model = i['model'];
                    model.isCheck = true;
                    model.machineID = i['project'];
                    model.startDate = bodyRequest["date"];
                    confirmBodyRequest.add(model.toJson());
                  }
                  setState(() {});
                },
              );
            } else if (state is GetDataConfirmAttendanceFailure) {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            } else if (state is GetDataConfirmAttendanceLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CustomLoadingWidget(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }

  void initStateData() {
    fetchProjects();
    fetchGroups();
  }

  void fetchProjects() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> data = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "[Machine]"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      setState(() {
        listProjects = ProjectModel.fromJson(data).listProject!;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  void fetchGroups() async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";

      Map<String, dynamic> data = await ApiService(Dio()).post(
        endPoint: "web/Structure/getDataGlobal",
        data: {"tableName": "[Group]"},
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      setState(() {
        listGroups = GroupModel.fromJson(data).listGroup!;
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }
}
