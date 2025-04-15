import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:erp_system/core/widgets/custom_button.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/tasks/data/models/get_employees_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/employees_model.dart';
import '../../data/repositories/task_repo_impl.dart';
import '../manager/Employees/employees_cubit.dart';

class EmployeesWidget extends StatefulWidget {
  const EmployeesWidget({super.key, required this.idTask});
  final String idTask;

  @override
  State<EmployeesWidget> createState() => _EmployeesWidgetState();
}

class _EmployeesWidgetState extends State<EmployeesWidget> {
  late EmployeesModel employeesModel;
  List<GetEmployeesModel> listEmployees = [];
  String idEmployee = "";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeesCubit(getIt.get<TaskRepoImpl>())
        ..getEmployeesTaskListAndGetEmployees(idTask: widget.idTask),
      child: BlocConsumer<EmployeesCubit, EmployeesState>(
        listener: (context, state) {
          if (state is EmployeesSuccess) {
            employeesModel = state.employees;
          }
          if (state is GetEmployeesSuccess) {
            listEmployees = state.employeesList;
          }
          if (state is AddEmployeesSuccess) {
            BlocProvider.of<EmployeesCubit>(context)
                .getEmployeesList(idTask: widget.idTask);
          }
          if (state is DeleteEmployeesSuccess) {
            BlocProvider.of<EmployeesCubit>(context)
                .getEmployeesList(idTask: widget.idTask);
          }
        },
        builder: (context, state) {
          if (state is EmployeesFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else if (state is EmployeesLoading) {
            return const CustomLoadingWidget();
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        S.of(context).employees,
                        style:
                            AppStyles.textStyle14.copyWith(color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () async {
                          BlocProvider.of<EmployeesCubit>(context)
                              .getEmployees();
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.green,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  CustomDropdown<String>.search(
                    hintText: '',
                    closedHeaderPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: CustomDropdownDecoration(
                        headerStyle:
                            AppStyles.textStyle16.copyWith(color: Colors.black),
                        closedFillColor: Colors.transparent,
                        closedBorder: Border.all(color: AppColors.blueDark)),
                    // validator: (value) {
                    //   if (value?.isEmpty ?? true) {
                    //     return S.of(context).field_is_required;
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    items: employeesModel.dynamicList!.isEmpty
                        ? [""]
                        : List.generate(
                            employeesModel.dynamicList!.length,
                            (index) =>
                                employeesModel
                                    .dynamicList![index].employeeNameA ??
                                ''),
                    onChanged: (value) {
                      EmployeeItemData ii = employeesModel.dynamicList!
                          .firstWhere(
                              (element) => element.employeeNameA == value);

                      setState(() {
                        idEmployee = ii.employeeID.toString();
                      });
                    },
                  ),
                  CustomButton(
                    text: S.of(context).btn_add,
                    width: 70,
                    onTap: () {
                      BlocProvider.of<EmployeesCubit>(context)
                          .addNewEmployees(
                              idTask: widget.idTask, idEmployee: idEmployee);
                    },
                  ),
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .4,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              listEmployees[index].employee!.employeeNameA!),
                          trailing: listEmployees[index].isMain == true
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    BlocProvider.of<EmployeesCubit>(context)
                                        .deleteEmployees(
                                            idTask: widget.idTask,
                                            idEmployee: listEmployees[index]
                                                .employee!.employeeID!
                                                .toString())
                                        ;
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: listEmployees.length,
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
}
