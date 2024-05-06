import 'package:erp_system/features/tasks/data/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_styles.dart';
import 'button_move.dart';

class SubTaskItem extends StatelessWidget {
  const SubTaskItem(
      {super.key,
      required this.color,
      required this.taskData,
      required this.stepIndex});

  final Parent taskData;
  final Color color;
  final int stepIndex;

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
                ButtonMove(
                  icon: Icons.arrow_upward,
                  onTap: () {
                    if (stepIndex == 2) {
                    } else if (stepIndex == 3) {
                    } else if (stepIndex == 4) {}
                  },
                ),
              if (stepIndex == 1 || stepIndex == 2 || stepIndex == 3)
                ButtonMove(
                  icon: Icons.arrow_downward,
                  onTap: () {
                    if (stepIndex == 1) {
                    } else if (stepIndex == 2) {
                    } else if (stepIndex == 3) {}
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
                Text(
                  taskData.tName!,
                  style: AppStyles.textStyle18.copyWith(color: Colors.black),
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
                Text(
                  taskData.endDate!.isNotEmpty
                      ? DateFormat("yyyy-MM-dd", 'en')
                          .format(DateTime.parse(taskData.createdDate!))
                      : "",
                  style: AppStyles.textStyle18.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
