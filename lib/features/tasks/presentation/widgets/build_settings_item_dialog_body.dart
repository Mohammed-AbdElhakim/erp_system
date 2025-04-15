import 'package:erp_system/features/tasks/presentation/widgets/employees_widget.dart';
import 'package:erp_system/features/tasks/presentation/widgets/time_task_widget.dart';
import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import 'note_widget.dart';
import 'progress_widget.dart';


class BuildSettingsItemDialogBody extends StatelessWidget {
  const BuildSettingsItemDialogBody({super.key, required this.idOFSettingItem, required this.taskDate});
  final int idOFSettingItem;
  final Parent taskDate;

  @override
  Widget build(BuildContext context) {

    if(idOFSettingItem==1){
      return EmployeesWidget(idTask: taskDate.tID.toString());
    }else if(idOFSettingItem==2){
      return Text(
        taskDate.tDescription!,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16),
      );
    }else if(idOFSettingItem==3){
      return TimeTaskWidget(idTask: taskDate.tID.toString());
    }else if(idOFSettingItem==4){

      return NoteWidget(idTask: taskDate.tID!);
    }else if(idOFSettingItem==5){

      return ProgressWidget(idTask: taskDate.tID!);
    }else{
      return const SizedBox();
    }

  }
}
