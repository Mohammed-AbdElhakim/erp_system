import 'package:erp_system/features/tasks/presentation/widgets/sub_task_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/task_model.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile(
      {super.key,
      required this.color,
      required this.title,
      required this.children,
      required this.stepIndex,
      required this.idMainTask});
  final Color color;
  final String title;
  final List<Parent> children;
  final int stepIndex;
  final String idMainTask;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  late int open;
  bool _initialized = false;
  @override
  void initState() {
    getNumberOpenStep();
    // Schedule function call after the widget is ready to display
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
    super.initState();
  }

  void _initialize() {
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        // Check that the widget is still mounted
        setState(() {
          _initialized = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        initiallyExpanded: widget.stepIndex == open ? true : false,
        backgroundColor: widget.color.withOpacity(0.5),
        collapsedBackgroundColor: widget.color,
        title: Row(
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              child: Text(
                widget.children.length.toString(),
                style: AppStyles.textStyle18,
              ),
            ),
            Text(
              widget.title,
              style: AppStyles.textStyle18,
            ),
          ],
        ),
        onExpansionChanged: (value) {
          if (value == true) {
            Pref.saveIntToPref(key: "OPEN", value: widget.stepIndex);
          } else {
            Pref.saveIntToPref(key: "OPEN", value: -1);
          }
        },
        children: List.generate(
            widget.children.length,
            (index) => SubTaskItem(
                  taskData: widget.children[index],
                  color: widget.color,
                  stepIndex: widget.stepIndex,
                  idMainTask: widget.idMainTask,
                )),
      ),
    );
  }

  void getNumberOpenStep() async {
    int stateOpen = await Pref.getIntFromPref(key: "OPEN") ?? -1;
    setState(() {
      open = stateOpen;
    });
  }
}
