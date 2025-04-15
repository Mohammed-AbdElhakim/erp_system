import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/progress_model.dart';
import '../../data/repositories/task_repo_impl.dart';
import '../manager/progress/progress_cubit.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({super.key, required this.idTask});
  final int idTask;

  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  List<ProgressModel> listProgress = [];
  bool show = false;
  bool isEdit = false;
  late ProgressModel progressData;
  String dateFrom = DateTime.now().toString();
  String dateTo = DateTime.now().toString();
  TextEditingController controllerNote = TextEditingController();
  TextEditingController controllerProgress = TextEditingController();
  DateTime? selectedDateTimeFrom;
  DateTime? selectedDateTimeTo;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProgressCubit(getIt.get<TaskRepoImpl>())
        ..getAllProgressList(idTask: widget.idTask),
      child: BlocConsumer<ProgressCubit, ProgressState>(
        listener: (context, state) {
          if (state is AllProgressSuccess) {
            listProgress = state.listProgress;
          }
          if (state is AddProgressSuccess ||
              state is DeleteProgressSuccess ||
              state is UpdateProgressSuccess) {
            BlocProvider.of<ProgressCubit>(context)
                .getAllProgressList(idTask: widget.idTask);
          }
        },
        builder: (context, state) {
          if (state is ProgressFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else if (state is ProgressLoading) {
            return const CustomLoadingWidget();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: show,
                    replacement: CustomButton(
                      text: S.of(context).add_new,
                      onTap: () {
                        setState(() {
                          show = true;
                        });
                      },
                    ),
                    child: Column(
                      children: [
                        buildTextAndNumberWidget(
                            keyboardType: TextInputType.multiline, title: "Note",
                        controller: controllerNote),
                        const SizedBox(height: 5),
                        buildTextAndNumberWidget(
                            keyboardType: TextInputType.number, title: "Progress",
                        controller: controllerProgress),

                        const SizedBox(height: 5),

                        buildDateWidget("Start Time"),

                        const SizedBox(height: 5),

                        buildDateWidget("End Time"),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: CustomButton(
                                  text: isEdit
                                      ? S.of(context).btn_edit
                                      : S.of(context).save
                                  ,
                                  onTap: () {
                                    if (isEdit) {
                                      BlocProvider.of<ProgressCubit>(context)
                                          .updateProgress(
                                        taskID: progressData.taskID!,
                                        note: controllerNote.text,
                                        progress: controllerProgress.text.isEmpty?null:double.parse(
                                            controllerProgress.text),
                                        dateTo: dateTo,
                                        dateFrom:dateFrom,
                                        empID: progressData.empID!,
                                        date: DateTime.now().toString(),
                                        tPID: progressData.tPID!,
                                      );
                                    } else {
                                      BlocProvider.of<ProgressCubit>(context)
                                          .addNewProgress(
                                        taskID: widget.idTask,
                                        note: controllerNote.text,
                                        dateFrom: dateFrom,
                                        dateTo: dateTo,
                                        progress: controllerProgress.text.isEmpty?null:double.parse(
                                            controllerProgress.text),
                                      );
                                    }

                                    setState(() {
                                      show = false;
                                      isEdit = false;
                                      controllerNote.text="";
                                      controllerProgress.text="";
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: CustomButton(
                                  text: S.of(context).cancel,
                                  color: Colors.red,
                                  noGradient: true,
                                  onTap: () {
                                    setState(() {
                                      show = false;
                                      isEdit = false;
                                      controllerNote.text="";
                                      controllerProgress.text="";
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  if(show==false)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .4,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text("Note: "),
                                    Text(listProgress[index].note??""),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Progress: "),
                                    Text(listProgress[index].progress==null?"":listProgress[index].progress.toString()),
                                  ],
                                ),

                                Row(
                                  children: [
                                    const Text("Start Time: "),
                                    Text(listProgress[index].dateFrom==null?"":DateFormat('yyyy/MM/dd   hh:mm a').format(DateTime.parse(listProgress[index].dateFrom.toString()).toLocal())),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("End Time: "),
                                    Text(listProgress[index].dateTo==null?"":DateFormat('yyyy/MM/dd   hh:mm a').format(DateTime.parse(listProgress[index].dateTo.toString()).toLocal())),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            show = true;
                                            isEdit = true;
                                            controllerNote.text = listProgress[index].note==null?"":listProgress[index].note!;
                                            controllerProgress.text = listProgress[index].progress==null?"":listProgress[index].progress!.toString();
                                            dateFrom = listProgress[index].dateFrom==null?"":listProgress[index].dateFrom!.toString();
                                            dateTo = listProgress[index].dateTo==null?"":listProgress[index].dateTo!.toString();
                                            selectedDateTimeFrom = listProgress[index].dateFrom==null?null:DateTime.parse(listProgress[index].dateFrom!.toString());
                                            selectedDateTimeTo = listProgress[index].dateTo==null?null:DateTime.parse(listProgress[index].dateTo!.toString());

                                            progressData = listProgress[index];
                                          });
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        )),
                                    const SizedBox(width: 12),
                                    InkWell(
                                        onTap: () {
                                          BlocProvider.of<ProgressCubit>(
                                              context)
                                              .deleteProgress(
                                            progressID:
                                            listProgress[index].tPID!,
                                          );
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: listProgress.length,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  Widget buildDateWidget(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.textStyle14.copyWith(color: Colors.grey),
          ),
          InkWell(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  final DateTime fullDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  setState(() {

                    if(title=="Start Time"){
                      dateFrom = fullDateTime.toIso8601String();
                      selectedDateTimeFrom = fullDateTime;
                    }else if(title=="End Time"){
                      dateTo = fullDateTime.toIso8601String();
                      selectedDateTimeTo = fullDateTime;
                    }

                  });
                }
              }
            },
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.blueDark),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: Text(
                title=="Start Time"?selectedDateTimeFrom == null
                    ? ""
                    : DateFormat('yyyy/MM/dd   hh:mm a').format(selectedDateTimeFrom!):selectedDateTimeTo == null
              ? ""
                  : DateFormat('yyyy/MM/dd   hh:mm a').format(selectedDateTimeTo!),
                style: AppStyles.textStyle14.copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextAndNumberWidget(
      {required TextInputType keyboardType, required String title,
        required TextEditingController controller}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppStyles.textStyle14.copyWith(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(
          height: keyboardType == TextInputType.number ? 40 : null,
          child: TextFormField(
            controller: controller,
            minLines: 1,
            maxLines: 5,
            keyboardType: keyboardType,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.grey,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.blueDark,
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.blueDark,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
