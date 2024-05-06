import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class SubTaskView extends StatefulWidget {
  const SubTaskView({super.key});

  @override
  State<SubTaskView> createState() => _SubTaskViewState();
}

class _SubTaskViewState extends State<SubTaskView> {
  List<Item> data = [];
  int? _openIndex;
  List<Stage> stages = [
    Stage('لم تبدأ', ['Task 1', 'Task 2', 'Task 3'], Colors.redAccent),
    Stage('تم بدأالعمل عليها', ['Task 4', 'Task 5'], Colors.lime),
    Stage(
        'تحت المراجعة', ['Task 6', 'Task 7', 'Task 8', 'Task 9'], Colors.teal),
    Stage('تم المراجعة', ['Task 10'], Colors.green),
  ];
  @override
  void initState() {
    super.initState();
    _openIndex = 0;
    data = List<Item>.generate(
      stages.length,
      (int index) => Item(
          headerValue: stages[index].name,
          expandedValue: stages[index].tasks,
          color: stages[index].color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        isPortrait: true,
        title: "Tasks",
      ),
      body: ListView(
        children: data
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  backgroundColor: e.color.withOpacity(0.5),
                  collapsedBackgroundColor: e.color,
                  title: Row(
                    children: [
                      Container(
                        margin: const EdgeInsetsDirectional.only(end: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          e.expandedValue.length.toString(),
                          style: AppStyles.textStyle18,
                        ),
                      ),
                      Text(
                        e.headerValue,
                        style: AppStyles.textStyle18,
                      ),
                    ],
                  ),
                  children: e.expandedValue
                      .map(
                        (ele) => TaskItem(
                          title: ele,
                          color: e.color,
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(8),
                  ),
                ),
                width: 25,
                height: 25,
                alignment: Alignment.center,
                child: Text(
                  "11",
                  style: AppStyles.textStyle18,
                ),
              ),
              const Spacer(),
              Container(
                margin: EdgeInsetsDirectional.only(end: 25),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                width: 30,
                height: 30,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
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
                  "ggg",
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
                  "12/5/2015",
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

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    required this.color,
  });

  List<String> expandedValue;
  String headerValue;

  Color color;
}

class Stage {
  final String name;
  final List<String> tasks;
  final Color color;

  Stage(this.name, this.tasks, this.color);
}
