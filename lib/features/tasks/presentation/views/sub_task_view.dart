import 'package:erp_system/core/widgets/change_status_bar_color.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/tasks/presentation/manager/get_task_by_id/get_task_by_id_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repo_impl.dart';
import '../widgets/custom_expansion_tile.dart';

class SubTaskView extends StatefulWidget {
  const SubTaskView({super.key, required this.taskData});

  final TaskModel taskData;

  @override
  State<SubTaskView> createState() => _SubTaskViewState();
}

class _SubTaskViewState extends State<SubTaskView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTaskByIdCubit(
        getIt.get<TaskRepoImpl>(),
      )..getTaskById(widget.taskData.parent!.tID!.toString()),
      child: ChangeStatusBarColor(
        child: Scaffold(
          appBar: const CustomAppBar(
            isPortrait: true,
            title: "",
          ),
          body: BlocBuilder<GetTaskByIdCubit, GetTaskByIdState>(
            builder: (context, state) {
              if (state is GetTaskByIdSuccess) {
                TaskModel taskModel = state.taskModel;
                List<Parent> noDoList = [];
                List<Parent> doList = [];
                List<Parent> underRevisionList = [];
                List<Parent> revisionList = [];
                for (var i in taskModel.children!) {
                  if (i.onProgress == false && i.isDone == false) {
                    noDoList.add(i);
                  } else if (i.onProgress == true) {
                    doList.add(i);
                  } else if (i.isDone == true) {
                    underRevisionList.add(i);
                  } else {
                    revisionList.add(i);
                  }
                }
                return ListView(
                  children: [
                    CustomExpansionTile(
                      color: Colors.redAccent,
                      title: 'لم تبدأ',
                      children: noDoList,
                      stepIndex: 1,
                    ),
                    CustomExpansionTile(
                      color: Colors.orange,
                      title: 'تم بدأالعمل عليها',
                      children: doList,
                      stepIndex: 2,
                    ),
                    CustomExpansionTile(
                      color: Colors.green,
                      title: 'تحت المراجعة',
                      children: underRevisionList,
                      stepIndex: 3,
                    ),
                    CustomExpansionTile(
                      color: Colors.teal,
                      title: 'تم المراجعة',
                      children: revisionList,
                      stepIndex: 4,
                    ),
                  ],
                );
              } else if (state is GetTaskByIdFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else {
                return const CustomLoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }
}