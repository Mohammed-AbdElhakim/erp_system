import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/task_model.dart';
import '../manager/task/task_cubit.dart';

class ItemTaskGridView extends StatelessWidget {
  const ItemTaskGridView({super.key, required this.taskData});
  final TaskModel taskData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.kSubTaskView, extra: taskData)
            .then((value) {
          BlocProvider.of<TaskCubit>(context).getTasks();
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: taskData.parent!.progress == 0.0
                ? Colors.redAccent
                : taskData.parent!.progress == 100.0
                    ? Colors.green
                    : Colors.orange,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: AppColors.white,
                    ),
                    Text(
                      taskData.children!.length.toString(),
                      style: AppStyles.textStyle18,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: const Icon(Icons.delete),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: const Icon(Icons.edit),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: const Icon(Icons.group),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.earbuds,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "توصيف: ",
                    style: AppStyles.textStyle18,
                  ),
                  Text(
                    taskData.parent!.tName!,
                    style: AppStyles.textStyle18,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.earbuds,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "تاريخ البداية: ",
                    style: AppStyles.textStyle18,
                  ),
                  Text(
                    taskData.parent!.startDate!.isNotEmpty
                        ? DateFormat("yyyy-MM-dd", 'en')
                            .format(DateTime.parse(taskData.parent!.startDate!))
                        : "",
                    style: AppStyles.textStyle18,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(
                      Icons.earbuds,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "تاريخ النهاية: ",
                    style: AppStyles.textStyle18,
                  ),
                  Text(
                    taskData.parent!.endDate!.isNotEmpty
                        ? DateFormat("yyyy-MM-dd", 'en')
                            .format(DateTime.parse(taskData.parent!.endDate!))
                        : "",
                    style: AppStyles.textStyle18,
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "${taskData.parent!.progress} %",
                      style: AppStyles.textStyle18,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: const Icon(Icons.hourglass_bottom),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
