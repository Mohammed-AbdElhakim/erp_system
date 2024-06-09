import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/screenTable/data/models/item_list_setup_model.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getListSetups/get_list_setups_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/dropdown_model/all_dropdown_model.dart';
import 'custom_table_add.dart';
import 'table_group.dart';

class AddViewBody extends StatefulWidget {
  const AddViewBody({super.key, required this.pageData, required this.listKey});
  final Pages pageData;
  final List<dynamic> listKey;

  @override
  State<AddViewBody> createState() => _AddViewBodyState();
}

class _AddViewBodyState extends State<AddViewBody> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  bool isShow = false;
  late List<AllDropdownModel> myAllDropdownModelList;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myAllDropdownModelList = TableGroup.myAllDropdownModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetListSetupsCubit, GetListSetupsState>(
      builder: (context, state) {
        if (state is GetListSetupsSuccess) {
          List<ItemListSetupModel> listSetup = state.listSetupModel;
          List<ItemListSetupModel> listColumn = [];
          List<dynamic> listKey = [];
          List<String> category = [];
          List<String> listHeader = [];
          for (var item in state.listSetupModel) {
            category.add(item.categoryTitle!);
            if (item.insertVisable == true &&
                item.cvisable == true &&
                item.visible == true &&
                item.isGeneral != true) {
              listColumn.add(item);
              listKey.add(item.columnName);
              listHeader.add(lang == AppStrings.enLangKey
                  ? item.enColumnLabel!
                  : item.arColumnLabel!);
            }
          }
          List<String> categoryList = category.toSet().toList();
          return Padding(
            padding: const EdgeInsets.all(12.0),
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
                          ...List.generate(categoryList.length, (index) {
                            String categoryName = categoryList[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                        color: AppColors.grey.withOpacity(.4),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      categoryName,
                                      style: AppStyles.textStyle18
                                          .copyWith(color: Colors.black),
                                    )),
                                ...getMyWidgetList(
                                  listData: listSetup,
                                  categoryName: categoryName,
                                  // show: true
                                ),
                              ],
                            );
                          }),
                          CustomTableAdd(
                            listKey: listKey,
                            listHeader: listHeader,
                            listColumn: listColumn,
                            allDropdownModelList:
                                TableGroup.myAllDropdownModelList,
                          ),
                          // TextButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       isShow = !isShow;
                          //     });
                          //   },
                          //   child: Text(!isShow
                          //       ? S.of(context).show_more
                          //       : S.of(context).show_less),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomButton(
                          text: S.of(context).cancel,
                          width: 80,
                          noGradient: true,
                          color: Colors.transparent,
                          noShadow: true,
                          textStyle: AppStyles.textStyle16
                              .copyWith(color: Colors.grey),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        /* BlocConsumer<AddEditCubit, AddEditState>(
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
                          text: S.of(context).btn_add,
                          width: 80,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              BlocProvider.of<AddEditCubit>(context).add(
                                  controllerName:
                                  widget.pageData.controllerName,
                                  body: newRowData);
                            }
                          },
                        );
                      }
                    },
                  ),*/
                        CustomButton(
                          text: S.of(context).btn_add,
                          width: 80,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
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
        } else if (state is GetListSetupsFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }

  List<Widget> getMyWidgetList({
    required List<ItemListSetupModel> listData,
    required String categoryName,
    // required bool show,
  }) {
    List<Widget> list = [];

    for (var item in listData) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      bool condition = widget.pageData.editSrc == AppStrings.addOrEditExcel
          ? item.insertVisable == true &&
              item.cvisable == true &&
              item.visible == true &&
              item.isGeneral == true
          : item.insertVisable == true &&
              item.cvisable == true &&
              item.visible == true;
      //text
      if (item.insertType == "text" &&
          item.categoryTitle == categoryName &&
          condition) {
        list.add(
          Padding(
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
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    if (newValue!.isNotEmpty) {
                      setState(() {
                        newRowData
                            .addAll({item.columnName!.toString(): newValue});
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }
      //number
      if (item.insertType == "number" &&
          item.categoryTitle == categoryName &&
          condition) {
        list.add(
          Padding(
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
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    if (newValue!.isNotEmpty) {
                      setState(() {
                        newRowData
                            .addAll({item.columnName!.toString(): newValue});
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }
      //Date
      if (item.insertType == "date" &&
          item.categoryTitle == categoryName &&
          condition) {
        String date = '';
        list.add(
          Padding(
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
                            date =
                                DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                          });

                          dsetState(() {
                            newRowData.addAll({
                              item.columnName!.toString(): dateTime.toString()
                            });
                          });
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.blueDark)),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            date,
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.black),
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }

      //dropdown
      if (item.insertType == "dropdown" &&
          item.categoryTitle == categoryName &&
          condition) {
        List<ListDrop>? listDrop = [];
        List<ItemDrop>? myListDrop = [];

        for (var ii in myAllDropdownModelList) {
          if (ii.listName == widget.pageData.listName) {
            listDrop = ii.list;
          }
        }
        for (var ii in listDrop!) {
          if (ii.columnName == item.columnName) {
            myListDrop = ii.list;
          }
        }
        list.add(
          Padding(
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
                CustomDropdown<String>.search(
                  hintText: '',
                  decoration: CustomDropdownDecoration(
                      headerStyle:
                          AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark)),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return S.of(context).field_is_required;
                    } else {
                      return null;
                    }
                  },
                  items: myListDrop!.isEmpty
                      ? [""]
                      : List.generate(myListDrop.length,
                          (index) => myListDrop![index].text ?? ''),
                  onChanged: (value) {
                    newRowData.addAll({item.searchName!.toString(): value});
                  },
                ),
              ],
            ),
          ),
        );
      }
      //checkbox
      if (item.insertType == "checkbox" &&
          item.categoryTitle == categoryName &&
          condition) {
        bool checkboxValue = false;
        list.add(
          StatefulBuilder(
            builder: (context, csetState) {
              return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checkboxValue,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      Text(
                        title,
                        style:
                            AppStyles.textStyle14.copyWith(color: Colors.black),
                      ),
                      if (item.isRquired == true)
                        const Icon(
                          Icons.star,
                          color: Colors.red,
                          size: 10,
                        )
                    ],
                  ),
                  onChanged: (newValue) {
                    csetState(() {
                      checkboxValue = !checkboxValue;
                    });
                    csetState(() {
                      newRowData
                          .addAll({item.columnName!.toString(): checkboxValue});
                    });
                  });
            },
          ),
        );
      }
    }
    return list;
  }
}
