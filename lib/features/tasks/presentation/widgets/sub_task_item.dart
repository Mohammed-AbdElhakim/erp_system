import 'package:erp_system/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/task_model.dart';
import '../manager/get_task_by_id/get_task_by_id_cubit.dart';
import '../manager/move_task/move_task_cubit.dart';
import 'build_settings_item_dialog_body.dart';
import 'button_move.dart';

class SubTaskItem extends StatefulWidget {
  const SubTaskItem({
    super.key,
    required this.color,
    required this.taskData,
    required this.stepIndex,
    required this.idMainTask,
  });

  final Parent taskData;
  final Color color;
  final int stepIndex;
  final String idMainTask;

  @override
  State<SubTaskItem> createState() => _SubTaskItemState();
}

class _SubTaskItemState extends State<SubTaskItem> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> listSettings = [
    {
      "id": 1,
      "title_ar": "موظفين",
      "title_en": "Employees",
      "icon": Icons.people,
      "iconColor": Colors.black
    },
    {
      "id": 2,
      "title_ar": "كتابة وصف",
      "title_en": "Description",
      "icon": Icons.edit_note,
      "iconColor": Colors.blue.shade900
    },
    {
      "id": 3,
      "title_ar": "تعديل الوقت",
      "title_en": "Edit time",
      "icon": Icons.access_time,
      "iconColor": Colors.red.shade900
    },
    {
      "id": 4,
      "title_ar": "ملاحظة",
      "title_en": "Note",
      "icon": Icons.event_note,
      "iconColor": Colors.yellow.shade900,
    },
    {
      "id": 5,
      "title_ar": "مهمة أضافية",
      "title_en": "Additional task",
      "icon": Icons.note_add,
      "iconColor": Colors.teal.shade900,
    },
  ];
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        buildBottomSheetSettings(context);
        setState(() {
          isTap = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: isTap
                ? Border.all(color: Colors.blue.shade900, width: 2)
                : null),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     color: color,
                //     borderRadius: const BorderRadiusDirectional.only(
                //       bottomEnd: Radius.circular(8),
                //     ),
                //   ),
                //   width: 25,
                //   height: 25,
                //   alignment: Alignment.center,
                //   child: Text(
                //     "11",
                //     style: AppStyles.textStyle18,
                //   ),
                // ),

                //اظهار ال settings===================
                // ButtonSettings(
                //   icon: Icons.settings,
                //   onTap: (){
                //     buildBottomSheetSettings(context);
                //   },
                // ),
                const Spacer(),
                if (widget.stepIndex == 2 || widget.stepIndex == 3)
                  BlocConsumer<MoveTaskCubit, MoveTaskState>(
                    listener: (context, state) {
                      if (state is MoveTaskToToDo ||
                          state is MoveTaskToProgress ||
                          state is MoveTaskToUnderRevision) {
                        BlocProvider.of<GetTaskByIdCubit>(context)
                            .getTaskById(widget.idMainTask);
                      } else if (state is MoveTaskFailure) {
                        CustomAlertDialog.alertWithButton(
                            context: context,
                            type: AlertType.error,
                            title: S.of(context).error,
                            textButton: S.of(context).ok,
                            desc: state.errorMassage,
                            onPressed: () {
                              Navigator.of(context).pop();
                            });
                      }
                    },
                    builder: (context, state) {
                      return ButtonMove(
                        icon: Icons.arrow_upward,
                        onTap: () {
                          if (widget.stepIndex == 2) {
                            BlocProvider.of<MoveTaskCubit>(context)
                                .moveTaskToToDo(
                                    widget.taskData.tID!.toString());
                          } else if (widget.stepIndex == 3) {
                            BlocProvider.of<MoveTaskCubit>(context)
                                .moveTaskToProgress(
                                    widget.taskData.tID!.toString());
                          }
                        },
                      );
                    },
                  ),
                if (widget.stepIndex == 1 || widget.stepIndex == 2)
                  BlocConsumer<MoveTaskCubit, MoveTaskState>(
                    listener: (context, state) {
                      if (state is MoveTaskToProgress ||
                          state is MoveTaskToUnderRevision ||
                          state is MoveTaskToDone) {
                        BlocProvider.of<GetTaskByIdCubit>(context)
                            .getTaskById(widget.idMainTask);
                      } else if (state is MoveTaskFailure) {
                        CustomAlertDialog.alertWithButton(
                            context: context,
                            type: AlertType.error,
                            title: S.of(context).error,
                            textButton: S.of(context).ok,
                            desc: state.errorMassage,
                            onPressed: () {
                              Navigator.of(context).pop();
                            });
                      }
                    },
                    builder: (context, state) {
                      return ButtonMove(
                        icon: Icons.arrow_downward,
                        onTap: () {
                          if (widget.stepIndex == 1) {
                            BlocProvider.of<MoveTaskCubit>(context)
                                .moveTaskToProgress(
                                    widget.taskData.tID!.toString());
                          } else if (widget.stepIndex == 2) {
                            BlocProvider.of<MoveTaskCubit>(context)
                                .moveTaskToUnderRevision(
                                    widget.taskData.tID!.toString());
                          }
                        },
                      );
                    },
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    S.of(context).task,
                    style: AppStyles.textStyle18.copyWith(color: widget.color),
                  ),
                  Expanded(
                    child: Text(
                      widget.taskData.tName!,
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppStyles.textStyle18.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    S.of(context).end_date,
                    style: AppStyles.textStyle18.copyWith(color: widget.color),
                  ),
                  Expanded(
                    child: Text(
                      widget.taskData.endDate!.isNotEmpty
                          ? DateFormat("yyyy-MM-dd", 'en').format(
                              DateTime.parse(widget.taskData.createdDate!))
                          : "",
                      overflow: TextOverflow.ellipsis,
                      style:
                          AppStyles.textStyle18.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buildBottomSheetSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.blue.shade100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ScrollbarTheme(
          data: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Colors.blue.shade200),
            trackColor: WidgetStateProperty.all(Colors.blue.shade100),
            thickness: WidgetStateProperty.all(5),
            radius: const Radius.circular(6),
          ),
          child: SafeArea(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                height: 110,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        listSettings.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                horizontal: 15),
                            child: InkWell(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    listSettings[index]['icon'],
                                    color: listSettings[index]['iconColor'],
                                    size: 30,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    lang == AppStrings.arLangKey
                                        ? listSettings[index]['title_ar']
                                        : listSettings[index]['title_en'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              lang == AppStrings.arLangKey
                                                  ? listSettings[index]
                                                      ['title_ar']
                                                  : listSettings[index]
                                                      ['title_en'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: listSettings[index]
                                                      ['iconColor']),
                                            ),
                                            const SizedBox(height: 12),
                                            BuildSettingsItemDialogBody(
                                              taskDate: widget.taskData,
                                              idOFSettingItem:
                                                  listSettings[index]['id'],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then(
      (value) {
        setState(() {
          isTap = false;
        });
      },
    );
  }
}
