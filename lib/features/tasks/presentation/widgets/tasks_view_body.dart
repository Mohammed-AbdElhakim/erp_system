import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/tasks/data/models/task_model.dart';
import 'package:erp_system/features/tasks/presentation/manager/task/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/custom_container.dart';
import 'item_task_grid_view.dart';

class TasksViewBody extends StatefulWidget {
  const TasksViewBody({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<TasksViewBody> createState() => _TasksViewBodyState();
}

class _TasksViewBodyState extends State<TasksViewBody> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        isOrientationPortrait(context)
            ? SliverToBoxAdapter(
                child: CustomContainer(
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      lang == AppStrings.enLangKey
                          ? widget.pageData.nameEn
                          : widget.pageData.nameAr,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: AppStyles.textStyle26,
                    ),
                  ),
                ),
              )
            : const SliverToBoxAdapter(
                child: SizedBox(
                  height: 25,
                ),
              ),
        SliverToBoxAdapter(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskSuccess) {
                List<TaskModel> taskList = state.taskList;
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: isOrientationPortrait(context) ? 1 : 2,
                  physics: const NeverScrollableScrollPhysics(),
                  // childAspectRatio: isOrientationPortrait(context)
                  //     ? ((MediaQuery.of(context).size.width) / 226.1)
                  //     : ((MediaQuery.of(context).size.width * .5) / 230.1),
                  childAspectRatio: isOrientationPortrait(context)
                      ? ((MediaQuery.of(context).size.width) / 205)
                      : ((MediaQuery.of(context).size.width * .5) / 209),
                  mainAxisSpacing: 35,
                  crossAxisSpacing: 35,
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  children: List.generate(
                      taskList.length,
                      (index) => ItemTaskGridView(
                            taskData: taskList[index],
                          )),
                );
              } else if (state is TaskFailure) {
                return CustomErrorMassage(errorMassage: state.errorMassage);
              } else {
                return const CustomLoadingWidget();
              }
            },
          ),
        ),
      ],
    );
  }
}
