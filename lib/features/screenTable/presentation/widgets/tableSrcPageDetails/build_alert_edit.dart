import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../core/models/menu_model/pages.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_date_picker_field.dart';
import '../../../../../core/widgets/custom_error_massage.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../core/widgets/custom_time_picker_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/widgets/home_view_body.dart';
import '../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../data/models/permission_model.dart';
import '../../../data/models/screen_model.dart';
import '../../../data/repositories/screen_repo_impl.dart';
import '../../manager/addEdit/add_edit_cubit.dart';
import '../../manager/getById/get_by_id_cubit.dart';
import '../../manager/getTable/get_table_cubit.dart';
import '../../views/screen_table.dart';
import 'build_alert_add_in_dropdown.dart';

class BuildAlertEdit extends StatefulWidget {
  const BuildAlertEdit({super.key, required this.columnList, required this.pageData});

  final List<ColumnList> columnList;
  final Pages pageData;

  @override
  State<BuildAlertEdit> createState() => _BuildAlertEditState();
}

class _BuildAlertEditState extends State<BuildAlertEdit> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  Map<String, String?> selectedDropdownValues = {};

  Map<String, String> selectedTimes = {};
  bool isShow = false;
  late List<String> myListCategory;
  late List<AllDropdownModel> myAllDropdownModelList;
  late String id;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();

    super.didChangeDependencies();
  }

  @override
  void initState() {
    myListCategory = ScreenTable.listCategory;
    myAllDropdownModelList = ScreenTable.myAllDropdownModelList;
    // id = widget.pageData.tableSrc == AppStrings.tableGroup
    //     ? ScreenTable.rowData[0].toString()
    //     // : ScreenTable.rowData[0][primary].toString();
    //     : ScreenTable.rowData[0][widget.pageData.primary].toString();
    id = ScreenTable.rowData[0].toString();
    super.initState();
  }

  // @override
  // void dispose() {
  //   for (var controller in _controllers.values) {
  //     controller.dispose();
  //   }
  //   _controllers.clear();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetByIdCubit(getIt.get<ScreenRepoImpl>())
        ..getById(id: id, controllerName: widget.pageData.controllerName),
      child: BlocBuilder<GetByIdCubit, GetByIdState>(
        builder: (context, state) {
          if (state is GetByIdSuccess) {
            Map<String, dynamic> id = state.valueGetById;
            newRowData = id;
            return SizedBox(
              height: MediaQuery.of(context).size.height * .75,
              child: Form(
                key: formKey,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...List.generate(myListCategory.length, (index) {
                              String categoryName = myListCategory[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (getMyWidgetList(
                                          columnList: widget.columnList,
                                          categoryName: categoryName,
                                          show: true,
                                          rowData: state.valueGetById)
                                      .isNotEmpty)
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                            // color: AppColors.grey.withOpacity(.4),
                                            color: AppColors.grey.withAlpha(102),
                                            borderRadius: BorderRadius.circular(15)),
                                        child: Text(
                                          categoryName,
                                          style: AppStyles.textStyle18
                                              .copyWith(color: Colors.black),
                                        )),
                                  ...getMyWidgetList(
                                      columnList: widget.columnList,
                                      categoryName: categoryName,
                                      show: true,
                                      rowData: state.valueGetById),
                                  if (isShow == true)
                                    ...getMyWidgetList(
                                        columnList: widget.columnList,
                                        categoryName: categoryName,
                                        show: false,
                                        rowData: state.valueGetById),
                                ],
                              );
                            }),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isShow = !isShow;
                                });
                              },
                              child: Text(!isShow
                                  ? S.of(context).show_more
                                  : S.of(context).show_less),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      // bottom: -25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                            text: S.of(context).cancel,
                            width: 80,
                            noGradient: true,
                            color: Colors.transparent,
                            noShadow: true,
                            textStyle: AppStyles.textStyle16.copyWith(color: Colors.grey),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          BlocConsumer<AddEditCubit, AddEditState>(
                            listener: (context, state) {
                              if (state is AddEditSuccess) {
                                BlocProvider.of<GetTableCubit>(context).getTable(
                                    pageId: widget.pageData.pageId,
                                    employee: false,
                                    isdesc: widget.pageData.isDesc,
                                    limit: 10,
                                    offset: 0,
                                    orderby: widget.pageData.orderBy,
                                    statment: '',
                                    selectcolumns: '',
                                    departmentName: widget.pageData.departmentName,
                                    isDepartment: widget.pageData.isDepartment,
                                    authorizationID: widget.pageData.authorizationID,
                                    viewEmployeeColumn:
                                        widget.pageData.viewEmployeeColumn,
                                    numberOfPage: 1,
                                    dropdownValueOfLimit: 10);
                                widget.columnList.clear();
                                Navigator.pop(context);
                              } else if (state is AddEditFailure) {
                                CustomAlertDialog.alertWithButton(
                                    context: context,
                                    type: AlertType.error,
                                    title: S.of(context).error,
                                    desc: state.errorMassage);
                              }
                            },
                            builder: (context, state) {
                              if (state is AddEditLoading) {
                                return const CustomLoadingWidget();
                              } else {
                                return CustomButton(
                                  text: S.of(context).btn_edit,
                                  width: 80,
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();

                                      BlocProvider.of<AddEditCubit>(context).edit(
                                          controllerName: widget.pageData.controllerName,
                                          body: newRowData);
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GetByIdFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }

  getMyWidgetList({
    required List<ColumnList> columnList,
    required Map<String, dynamic> rowData,
    required String categoryName,
    required bool show,
  }) {
    // List<Widget> listWidgets = [];
    List<Widget> list = [];
    for (var item in columnList) {
      String title =
          lang == AppStrings.arLangKey ? item.arColumnLabel! : item.enColumnLabel!;
      //text
      if (item.insertType == "text" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        TextEditingController controller = TextEditingController(
            text: rowData[item.columnName].toString() == "null"
                ? ''
                : rowData[item.columnName]);
        list.add(Padding(
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
                  if (item.isRquired! == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              CustomTextFormField(
                hintText: '',
                controller: controller,
                isValidator: item.isRquired!,
                keyboardType: TextInputType.text,
                // onSaved: (newValue) {
                //   if (newValue!.isNotEmpty) {
                //     setState(() {
                //       rowData[item.columnName!.toString()] = controller.text;
                //       newRowData = rowData;
                //     });
                //   }
                // },
                onChanged: (value) {
                  rowData[item.columnName!] = value;
                  newRowData = rowData;
                },
                onSaved: (newValue) {
                  if (newValue!.isNotEmpty) {
                    rowData[item.columnName!] = controller.text;
                    newRowData = rowData;
                  }
                },
              )
            ],
          ),
        ));
      }
      //number
      if (item.insertType == "number" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        TextEditingController controller = TextEditingController(
            text: rowData[item.columnName].toString() == "null"
                ? ''
                : rowData[item.columnName].toString());

        list.add(Padding(
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
                  if (item.isRquired! == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              CustomTextFormField(
                hintText: '',
                keyboardType: TextInputType.number,
                isValidator: item.isRquired!,
                controller: controller,
                // onSaved: (newValue) {
                //   if (newValue!.isNotEmpty) {
                //     setState(() {
                //       rowData[item.columnName!.toString()] = controller.text;
                //       newRowData = rowData;
                //     });
                //   }
                // },
                onChanged: (value) {
                  rowData[item.columnName!] = value;
                  newRowData = rowData;
                },
                onSaved: (newValue) {
                  if (newValue!.isNotEmpty) {
                    rowData[item.columnName!] = controller.text;
                    newRowData = rowData;
                  }
                },
              ),
            ],
          ),
        ));
      }
      /*//Date
      if (item.insertType == "date" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        String date;
        if (rowData[item.columnName] != null) {
          date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.parse(rowData[item.columnName].toString()).toLocal());
        } else {
          // date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.now());
          date = '';
        }

        list.add(Padding(
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
                  if (item.isRquired == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              StatefulBuilder(
                builder: (context, dsetState) {
                  return InkWell(
                    onTap: () async {
                      DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1980),
                        lastDate: DateTime(2100),
                      );
                      if (dateTime != null) {
                        dsetState(() {
                          date = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                          // dateFrom = dateTime.toString();
                        });

                        dsetState(() {
                          rowData[item.columnName!.toString()] = dateTime.toString();
                          newRowData = rowData;
                        });
                      }
                    },
                    child: Container(
                        height: 40,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.blueDark)),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          date,
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle14.copyWith(color: Colors.black),
                        )),
                  );
                },
              )
            ],
          ),
        ));
      }*/
      //Date
      if (item.insertType == "date" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        // String date = '';
        // if (rowData[item.columnName] != null) {
        //   try {
        //     date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.parse(rowData[item.columnName].toString()).toLocal());
        //   } catch (_) {
        //     date = '';
        //   }
        // }

        list.add(
          CustomDatePickerField(
            title: title,
            isRequired: item.isRquired ?? false,
            initialDateString: rowData[item.columnName]?.toString(),
            onDateSelected: (selectedDate) {
              if (selectedDate != null) {
                setState(() {
                  rowData[item.columnName!] = selectedDate.toIso8601String();
                  newRowData = rowData;
                });
              }
            },
            onClear: () {
              setState(() {
                rowData.remove(item.columnName);
                newRowData = rowData;
              });
            },
          ),

          /*Padding(
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
                    if (item.isRquired == true)
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 10,
                      )
                  ],
                ),
                InkWell(
                  onTap: () async {
                    DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate:
                          rowData[item.columnName] != null ? DateTime.parse(rowData[item.columnName].toString()) : DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2100),
                    );

                    if (dateTime != null) {
                      String formattedDate = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                      setState(() {
                        rowData[item.columnName!] = dateTime.toIso8601String();
                        newRowData = rowData;
                      });
                    }
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.blueDark),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date.isNotEmpty ? date : "",
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle14.copyWith(
                            color: date.isNotEmpty ? Colors.black : Colors.grey,
                          ),
                        ),
                        if (date.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                rowData.remove(item.columnName);
                                newRowData = rowData;
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.blue,
                              size: 18,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),*/
        );
      }

      /*//Date
      if (item.insertType == "date" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        String date;
        if (rowData[item.columnName] != null) {
          date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.parse(rowData[item.columnName].toString()).toLocal());
        } else {
          date = '';
        }

        list.add(Padding(
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
                  if (item.isRquired == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              StatefulBuilder(
                builder: (context, dsetState) {
                  return InkWell(
                    onTap: () async {
                      DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: rowData[item.columnName] != null
                            ? DateTime.parse(rowData[item.columnName].toString())
                            : DateTime.now(),
                        firstDate: DateTime(1980),
                        lastDate: DateTime(2100),
                      );
                      if (dateTime != null) {
                        String formattedDate = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                        dsetState(() {
                          date = formattedDate;
                        });

                        setState(() {
                          rowData[item.columnName!] = dateTime.toIso8601String();
                          newRowData = rowData;
                        });
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.blueDark),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        date,
                        textAlign: TextAlign.center,
                        style: AppStyles.textStyle14.copyWith(color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
      }*/

      /*  //dropdown
      if (item.insertType == "dropdown" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        List<ListDrop>? listDrop = [];
        List<ItemDrop> myListDrop = [];

        for (var ii in myAllDropdownModelList) {
          if (ii.listName == widget.pageData.listName) {
            listDrop = ii.list;
          }
        }
        for (var ii in listDrop!) {
          if (ii.columnName == item.columnName) {
            myListDrop = ii.list ?? [];
          }
        }
        String? dropValue;
        for (var i in myListDrop!) {
          if (i.id.toString() == rowData[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == rowData[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == rowData[item.columnName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == rowData[item.columnName].toString()) {
            dropValue = i.text ?? '';
          }
        }
        Pages? dropPage = getDropPage(item.pageId);
        // if (!_controllers.containsKey(item.columnName)) {
        //   _controllers[item.columnName!] = SingleSelectController<String>(dropValue);
        // }
        // final controller = _controllers[item.columnName]!;

        final dropdownItems = myListDrop!.isEmpty ? [""] : myListDrop.map((e) => e.text ?? '').toList();
        // if (controller.value != null && !dropdownItems.contains(controller.value)) {
        //   controller.clear();
        // }
        list.add(Padding(
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
                  if (item.isRquired == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    ),
                  const SizedBox(
                    width: 12,
                  ),
                  if (dropPage != null)
                    InkWell(
                      onTap: () async {
                        bool canAdd = await getPermissions(item.pageId);
                        if (canAdd == true) {
                          getColumnListAndAdd(dropPage);
                        } else {
                          CustomAlertDialog.alertWithButton(
                              context: context,
                              type: AlertType.error,
                              title: S.of(context).error,
                              desc: S.of(context).massage_no_permission);
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                  const SizedBox(
                    width: 5,
                  ),
                  // if (dropPage != null)
                  InkWell(
                    onTap: () async {
                      getDropdownList(widget.pageData.pageId);
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                ],
              ),
              StatefulBuilder(
                builder: (context, dsetState) => CustomDropdown<String>.search(
                  hintText: '',
                  // initialItem: dropValue,
                  closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: CustomDropdownDecoration(
                      headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark)),
                  validator: item.isRquired == true
                      ? (value) {
                          if (value?.isEmpty ?? true) {
                            return S.of(context).field_is_required;
                          } else {
                            return null;
                          }
                        }
                      : null,
                  // controller: controller,
                  headerBuilder: (context, selectedItem, enabled) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectedItem.toString(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              dsetState(() {
                                controller.clear(); // هنا بتمنع الخطأ
                                newRowData.remove(item.searchName!.toString());
                              });
                            },
                            child: Icon(
                              Icons.clear,
                              size: 20,
                              color: AppColors.blueLight,
                            ))
                      ],
                    );
                  },
                  items: dropdownItems,
                  // items: myListDrop.isEmpty ? [''] : List.generate(myListDrop.length, (index) => myListDrop![index].text ?? ''),
                  // onChanged: (value) {
                  //   // newRowData.addAll({item.searchName!.toString(): value});
                  //   // newRowData[item.searchName!.toString()] = value;
                  //   // final selectedItem = myListDrop.firstWhere(
                  //   //   (element) => element.text == value,
                  //   //   orElse: () => ItemDrop(id: "0", text: ''),
                  //   // );
                  //   // newRowData[item.searchName!.toString()] = int.parse(selectedItem.id!);
                  //   ItemDrop ii = myListDrop!.firstWhere((element) => element.text == value);
                  //   newRowData.addAll({item.searchName!.toString(): ii.id});
                  // },
                  onChanged: (value) {
                    ItemDrop selected = myListDrop.firstWhere((element) => element.text == value);
                    rowData[item.searchName!] = selected.id;
                    newRowData = rowData;
                  },
                ),
              ),
            ],
          ),
        ));
      }*/

      if (item.insertType == "dropdown" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        List<ListDrop>? listDrop = [];
        List<ItemDrop> myListDrop = [];

        for (var ii in myAllDropdownModelList) {
          if (ii.listName == widget.pageData.listName) {
            listDrop = ii.list;
          }
        }
        for (var ii in listDrop!) {
          if (ii.columnName == item.columnName && ii.nameAr == item.arColumnLabel) {
            myListDrop = ii.list ?? [];
          }
        }

        // جلب القيمة المختارة حاليا
        String? selectedDropdownValue;
        for (var i in myListDrop) {
          if (i.id.toString() == rowData[item.searchName].toString() ||
              i.id.toString() == rowData[item.columnName].toString()) {
            selectedDropdownValue = i.text ?? '';
          }
        }

        Pages? dropPage = getDropPage(item.pageId);

        final dropdownItems =
            myListDrop.isEmpty ? [""] : myListDrop.map((e) => e.text ?? '').toList();

        list.add(Padding(
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
                  if (item.isRquired == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    ),
                  const SizedBox(width: 12),
                  if (dropPage != null)
                    InkWell(
                      onTap: () async {
                        bool canAdd = await getPermissions(item.pageId);
                        if (canAdd) {
                          getColumnListAndAdd(dropPage);
                        } else {
                          CustomAlertDialog.alertWithButton(
                            context: context,
                            type: AlertType.error,
                            title: S.of(context).error,
                            desc: S.of(context).massage_no_permission,
                          );
                        }
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      getDropdownList(widget.pageData.pageId);
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown<String>.search(
                      hintText: '',
                      closedHeaderPadding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: CustomDropdownDecoration(
                        headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                        closedFillColor: Colors.transparent,
                        closedBorder: Border.all(color: AppColors.blueDark),
                      ),
                      validator: item.isRquired == true
                          ? (value) {
                              if (value?.isEmpty ?? true) {
                                return S.of(context).field_is_required;
                              } else {
                                return null;
                              }
                            }
                          : null,
                      items: dropdownItems,
                      initialItem: selectedDropdownValue,
                      onChanged: (value) {
                        if (value != null && value.isNotEmpty) {
                          setState(() {
                            ItemDrop selectedItem =
                                myListDrop.firstWhere((element) => element.text == value);
                            rowData[item.searchName!] = selectedItem.id;
                            newRowData = rowData;
                          });
                        }
                      },
                    ),
                  ),
                  if (selectedDropdownValue != null && selectedDropdownValue.isNotEmpty)
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDropdownValue = null;
                          rowData.remove(item.searchName);
                          newRowData = rowData;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8),
                        child: Icon(
                          Icons.clear,
                          size: 20,
                          color: AppColors.blueLight,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ));
      }

      //checkbox
      if (item.insertType == "checkbox" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        bool checkboxValue = rowData[item.columnName] ?? false;

        list.add(StatefulBuilder(
          builder: (context, csetState) {
            return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: checkboxValue,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  title,
                  style: AppStyles.textStyle14.copyWith(color: Colors.black),
                ),
                onChanged: (newValue) {
                  csetState(() {
                    checkboxValue = !checkboxValue;
                  });
                  csetState(() {
                    rowData[item.columnName!.toString()] = checkboxValue;
                    newRowData = rowData;
                  });
                });
          },
        ));
      }

      //time
      if (item.insertType == "time" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        String timeText = '';
        if (rowData[item.columnName] != null) {
          try {
            timeText = rowData[item.columnName];
          } catch (_) {
            timeText = '';
          }
        }

        list.add(
          CustomTimePickerField(
            title: title,
            itemIsRequired: item.isRquired ?? false,
            initialTimeString: timeText,
            onTimeSelected: (timeSelect) {
              if (timeSelect != null) {
                setState(() {
                  rowData[item.columnName!] = timeSelect;
                  newRowData[item.columnName!.toString()] = timeSelect;
                });
              }
            },
            onClear: () {
              setState(() {
                rowData.remove(item.columnName);
                newRowData.remove(item.columnName);
              });
            },
          ),
        );
      }
    }

    return list;
  }

  void getColumnListAndAdd(Pages page) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await ApiService(Dio()).post(
        endPoint: "home/getGeneralTable",
        data: {
          "pageId": page.pageId,
          "employee": false,
          "isdesc": page.isDesc,
          "limit": 10,
          "offset": 0,
          "orderby": page.orderBy,
          "statment": '',
          "selectcolumns": '',
          "IsDepartment": page.isDepartment,
          "DepartmentName": page.departmentName,
          "AuthorizationID": page.authorizationID,
          "ViewEmployeeColumn": page.viewEmployeeColumn
        },
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      ScreenModel screenModel = ScreenModel.fromJson(data);

      List<ColumnList>? columnList = screenModel.columnList;
      CustomAlertDialog.alertWithCustomContent(
        context: context,
        title: S.of(context).btn_add,
        isOverlayTapDismiss: false,
        isCloseButton: false,
        content: BuildAlertAddInDropdown(
          columnList: columnList!,
          pageData: page,
          onTapBtn: (val) {
            getDropdownList(widget.pageData.pageId);
          },
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Pages? getDropPage(int? pageId) {
    for (var page in HomeViewBody.pagesList) {
      if (page.pageId == pageId) {
        return page;
      }
    }
    return null;
  }

  Future<bool> getPermissions(int? pageId) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> data = await ApiService(Dio()).get(
        endPoint: "home/GetPagePermissions?pageId=$pageId",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      PermissionModel permissionModel = PermissionModel.fromJson(data);
      return permissionModel.showNew;
    } catch (e) {
      return false;
    }
  }

  void getDropdownList(int pageId) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> data = await ApiService(Dio()).get(
        endPoint: "home/GetPageDropDown?pageId=$pageId",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      List<AllDropdownModel> dataList = [];
      for (var i in data) {
        dataList.add(AllDropdownModel.fromJson(i));
      }

      setState(() {
        myAllDropdownModelList = dataList;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
