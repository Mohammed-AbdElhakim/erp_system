import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/task_model.dart';
import '../manager/task/task_cubit.dart';
import 'employees_widget.dart';

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
                // ? Colors.redAccent.withOpacity(.7)
                ? Colors.redAccent.withAlpha(179)
                : taskData.parent!.progress == 100.0
                    // ? Colors.green.withOpacity(.7)
                    ? Colors.green.withAlpha(179)
                    // : Colors.orange.withOpacity(.7),
                    : Colors.orange.withAlpha(179),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      taskData.children!.length.toString(),
                      style: AppStyles.textStyle18,
                    ),
                    const Spacer(),
                    /*InkWell(
                      onTap: () {
                        CustomAlertDialog.alertDelete(
                          context: context,
                          contentButton: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocProvider(
                                  create: (context) => DeleteTaskCubit(
                                    getIt.get<TaskRepoImpl>(),
                                  ),
                                  child: BlocConsumer<DeleteTaskCubit,
                                      DeleteTaskState>(
                                    listener: (context, state) {
                                      if (state is DeleteTaskSuccess) {
                                        BlocProvider.of<TaskCubit>(context)
                                            .getTasks();
                                      } else if (state is DeleteTaskFailure) {
                                        CustomAlertDialog.alertWithButton(
                                            context: context,
                                            type: AlertType.error,
                                            title: S.of(context).error,
                                            textButton: S.of(context).ok,
                                            desc: state.errorMassage,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            });
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is DeleteTaskLoading) {
                                        return const CustomLoadingWidget();
                                      } else {
                                        return CustomButton(
                                          text: S.of(context).btn_delete,
                                          width: 80,
                                          onTap: () {
                                            BlocProvider.of<DeleteTaskCubit>(
                                                    context)
                                                .deleteTask(taskData.parent!.tID
                                                    .toString());
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: const Icon(
                          Icons.delete,
                          size: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ),*/
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                  S.of(context).employees  ,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:Colors.black
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  EmployeesWidget(idTask: taskData.parent!.tID.toString(),)
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: const Icon(
                          Icons.group,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Icon(
                          Icons.earbuds,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Text(
                        S.of(context).description_task,
                        style: AppStyles.textStyle18,
                      ),
                      Expanded(
                        child: Text(
                          taskData.parent!.tName!,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textStyle18,
                        ),
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
                          size: 20,
                        ),
                      ),
                      Text(
                        S.of(context).start_date,
                        style: AppStyles.textStyle18,
                      ),
                      Expanded(
                        child: Text(
                          taskData.parent!.startDate!.isNotEmpty
                              ? DateFormat("yyyy-MM-dd", 'en').format(
                                  DateTime.parse(taskData.parent!.startDate!))
                              : "",
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textStyle18,
                        ),
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
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        S.of(context).end_date,
                        style: AppStyles.textStyle18,
                      ),
                      Expanded(
                        child: Text(
                          taskData.parent!.endDate!.isNotEmpty
                              ? DateFormat("yyyy-MM-dd", 'en').format(
                                  DateTime.parse(taskData.parent!.endDate!))
                              : "",
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textStyle18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
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
                      child: Icon(
                        taskData.parent!.progress == 100
                            ? Icons.check
                            : Icons.hourglass_bottom,
                        size: 20,
                      ),
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
