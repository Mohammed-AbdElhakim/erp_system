import 'package:erp_system/features/tasks/presentation/widgets/sub_task_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../data/models/task_model.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile(
      {super.key,
      required this.color,
      required this.title,
      required this.children,
      required this.stepIndex});
  final Color color;
  final String title;
  final List<Parent> children;
  final int stepIndex;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        backgroundColor: color.withOpacity(0.5),
        collapsedBackgroundColor: color,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              child: Text(
                children.length.toString(),
                style: AppStyles.textStyle18,
              ),
            ),
            Text(
              title,
              style: AppStyles.textStyle18,
            ),
          ],
        ),
        children: List.generate(
            children.length,
            (index) => SubTaskItem(
                  taskData: children[index],
                  color: color,
                  stepIndex: stepIndex,
                )),
      ),
    );
  }
}
