import 'package:erp_system/core/widgets/custom_button.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/tasks/data/models/all_time_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/repositories/task_repo_impl.dart';
import '../manager/TimeTask/time_task_cubit.dart';

class TimeTaskWidget extends StatefulWidget {
  const TimeTaskWidget({super.key, required this.idTask});
  final String idTask;


  @override
  State<TimeTaskWidget> createState() => _TimeTaskWidgetState();
}

class _TimeTaskWidgetState extends State<TimeTaskWidget> {

  List<AllTimeModel> listTimeTask = [];
  String dateOfRequest=DateTime.now().toString();
  String descriptionTask="";
  String date =  DateFormat("yyyy-MM-dd", 'en').format(DateTime.now());
  bool show =false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimeTaskCubit(getIt.get<TaskRepoImpl>())
        ..getTimeTaskList(idTask: widget.idTask),
      child: BlocConsumer<TimeTaskCubit, TimeTaskState>(
        listener: (context, state) {
          if (state is AllTimeTaskSuccess) {
            listTimeTask = state.allTimeModelList;
          }
          if (state is AddTimeTaskSuccess) {
            BlocProvider.of<TimeTaskCubit>(context)
                .getTimeTaskList(idTask: widget.idTask);
          }
          if (state is DeleteTimeTaskSuccess) {
            BlocProvider.of<TimeTaskCubit>(context)
                .getTimeTaskList(idTask: widget.idTask);
          }
        },
        builder: (context, state) {
          if (state is TimeTaskFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else if (state is TimeTaskLoading) {
            return const CustomLoadingWidget();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Visibility(
                    visible:show,
                  replacement:  CustomButton(
                    text: S.of(context).request_of_extend,
                    onTap: () {
                      setState(() {
                        show=true;
                      });
                    },
                  ),child: Column(children: [
                    buildDateWidget(S.of(context).date_of_request),
                    buildTextWidget(S.of(context).description_task),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomButton(
                              text: S.of(context).save,
                              onTap: () {
                                BlocProvider.of<TimeTaskCubit>(context)
                                    .addNewTimeTask(taskID: int.parse(widget.idTask)
                                ,
                                description:descriptionTask ,
                                requestedDate: dateOfRequest,
                                tTLID: 0);
                                setState(() {
                                  show=false;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomButton(
                              text: S.of(context).cancel,
                              color: Colors.red,
                              noGradient: true,
                              onTap: () {
                                setState(() {
                                  show=false;
                                });
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],),),


                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .4,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                           Text("${S.of(context).employee_name}: "),
                                          Text(listTimeTask[index].emp!,style: const TextStyle(fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                           Text("${S.of(context).date_of_request}: "),
                                          Text(DateFormat('MMM d, y').format(DateTime.parse(listTimeTask[index].requestedDate!)),style: const TextStyle(fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      Text(listTimeTask[index].description!,),


                                    ],
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      BlocProvider.of<TimeTaskCubit>(context)
                                          .deleteTimeTask(
                                        idTime: listTimeTask[index].tTLID.toString(),)
                                      ;
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: listTimeTask.length,
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
  Widget buildTextWidget(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppStyles.textStyle14.copyWith(color: Colors.grey),
              ),

            ],
          ),
          CustomTextFormField(
            hintText: '',
            isValidator: false,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                descriptionTask=value;
              });
            },
          ),
        ],
      ),
    );
  }
  Widget buildDateWidget(String title) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: AppStyles.textStyle14.copyWith(color: Colors.grey),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime(2100),
              );
              if (dateTime != null) {
                setState(() {
                  date = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                  dateOfRequest=dateTime.toString();
                });
              }
            },
            child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.blueDark)),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Text(
                  date,
                  textAlign: TextAlign.center,
                  style:
                  AppStyles.textStyle14.copyWith(color: Colors.black),
                )),
          ),
        ],
      ),
    );
  }
}
