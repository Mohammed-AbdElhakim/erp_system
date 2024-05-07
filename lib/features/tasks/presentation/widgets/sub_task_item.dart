import 'package:erp_system/features/tasks/data/models/task_model.dart';
import 'package:erp_system/features/tasks/presentation/manager/get_task_by_id/get_task_by_id_cubit.dart';
import 'package:erp_system/features/tasks/presentation/manager/move_task/move_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';
import 'button_move.dart';

class SubTaskItem extends StatelessWidget {
  const SubTaskItem(
      {super.key,
      required this.color,
      required this.taskData,
      required this.stepIndex,
      required this.idMainTask});

  final Parent taskData;
  final Color color;
  final int stepIndex;
  final String idMainTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
              const Spacer(),
              if (stepIndex == 2 || stepIndex == 3 || stepIndex == 4)
                BlocConsumer<MoveTaskCubit, MoveTaskState>(
                  listener: (context, state) {
                    if (state is MoveTaskToToDo ||
                        state is MoveTaskToProgress ||
                        state is MoveTaskToUnderRevision) {
                      BlocProvider.of<GetTaskByIdCubit>(context)
                          .getTaskById(idMainTask);
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
                        if (stepIndex == 2) {
                          BlocProvider.of<MoveTaskCubit>(context)
                              .moveTaskToToDo(taskData.tID!.toString());
                        } else if (stepIndex == 3) {
                          BlocProvider.of<MoveTaskCubit>(context)
                              .moveTaskToProgress(taskData.tID!.toString());
                        } else if (stepIndex == 4) {
                          BlocProvider.of<MoveTaskCubit>(context)
                              .moveTaskToUnderRevision(
                                  taskData.tID!.toString());
                        }
                      },
                    );
                  },
                ),
              if (stepIndex == 1 || stepIndex == 2 || stepIndex == 3)
                BlocConsumer<MoveTaskCubit, MoveTaskState>(
                  listener: (context, state) {
                    if (state is MoveTaskToProgress ||
                        state is MoveTaskToUnderRevision ||
                        state is MoveTaskToDone) {
                      BlocProvider.of<GetTaskByIdCubit>(context)
                          .getTaskById(idMainTask);
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
                        if (stepIndex == 1) {
                          BlocProvider.of<MoveTaskCubit>(context)
                              .moveTaskToProgress(taskData.tID!.toString());
                        } else if (stepIndex == 2) {
                          BlocProvider.of<MoveTaskCubit>(context)
                              .moveTaskToUnderRevision(
                                  taskData.tID!.toString());
                        } else if (stepIndex == 3) {
                          BlocProvider.of<MoveTaskCubit>(context)
                              .moveTaskToDone(taskData.tID!.toString());
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
                  "المهمة: ",
                  style: AppStyles.textStyle18.copyWith(color: color),
                ),
                Expanded(
                  child: Text(
                    taskData.tName!,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyle18.copyWith(color: Colors.black),
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
                  "تاريخ النهاية: ",
                  style: AppStyles.textStyle18.copyWith(color: color),
                ),
                Expanded(
                  child: Text(
                    taskData.endDate!.isNotEmpty
                        ? DateFormat("yyyy-MM-dd", 'en')
                            .format(DateTime.parse(taskData.createdDate!))
                        : "",
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.textStyle18.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
