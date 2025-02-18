import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../core/models/menu_model/pages.dart';
import '../../../../../core/utils/api_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../data/models/screen_model.dart';
import '../../manager/addEdit/add_edit_cubit.dart';

typedef OnTapBtn<T> = void Function(T value);

class BuildAlertAddInDropdown extends StatefulWidget {
  const BuildAlertAddInDropdown({
    super.key,
    required this.columnList,
    required this.pageData,
    required this.onTapBtn,
  });
  final List<ColumnList> columnList;
  final Pages pageData;
  final OnTapBtn<bool> onTapBtn;

  @override
  State<BuildAlertAddInDropdown> createState() =>
      _BuildAlertAddInDropdownState();
}

class _BuildAlertAddInDropdownState extends State<BuildAlertAddInDropdown> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  bool isShow = false;
  late List<String> myListCategory;
  List<AllDropdownModel> myAllDropdownModelList = [];

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    myListCategory = getCategory(widget.columnList);
    getDropdownList(widget.pageData.pageId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return myAllDropdownModelList.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
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
                                        show: true)
                                    .isNotEmpty)
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                          // color: AppColors.grey.withOpacity(.4),
                                          color: AppColors.grey.withAlpha(102),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        categoryName,
                                        style: AppStyles.textStyle18
                                            .copyWith(color: Colors.black),
                                      )),
                                ...getMyWidgetList(
                                    columnList: widget.columnList,
                                    categoryName: categoryName,
                                    show: true),
                                Visibility(
                                  visible: isShow,
                                  child: Column(
                                    children: getMyWidgetList(
                                        columnList: widget.columnList,
                                        categoryName: categoryName,
                                        show: false),
                                  ),
                                ),
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
                        BlocConsumer<AddEditCubit, AddEditState>(
                          listener: (context, state) {
                            if (state is AddEditSuccess) {
                              widget.columnList.clear();
                              widget.onTapBtn(true);
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  List<Widget> getMyWidgetList({
    required List<ColumnList> columnList,
    required String categoryName,
    required bool show,
  }) {
    List<Widget> list = [];
    for (var item in columnList) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      //text
      if (item.insertType == "text" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
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
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
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
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
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
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
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
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
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
                  closedHeaderPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: CustomDropdownDecoration(
                      headerStyle:
                          AppStyles.textStyle16.copyWith(color: Colors.black),
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
                  items: myListDrop!.isEmpty
                      ? [""]
                      : List.generate(myListDrop.length,
                          (index) => myListDrop![index].text ?? ''),
                  onChanged: (value) {
                    ItemDrop ii = myListDrop!
                        .firstWhere((element) => element.text == value);
                    newRowData.addAll({item.searchName!.toString(): ii.id});
                  },
                ),
                /*SizedBox(
                  // height: 40,
                  child: BlocProvider(
                    create: (context) =>
                        GetDropdownListCubit(getIt.get<ScreenRepoImpl>())
                          ..getDropdownList(
                            droModel: item.droModel ?? "",
                            droValue: item.droValue ?? "",
                            droText: item.droText ?? "",
                            droCondition: item.droCondition ?? "",
                            droCompany: item.droCompany ?? "",
                          ),
                    child:
                        BlocBuilder<GetDropdownListCubit, GetDropdownListState>(
                      builder: (context, state) {
                        if (state is GetDropdownListSuccess) {
                          List<ListDropdownModel> dropListData = [];
                          dropListData.addAll(state.dropdownModel.list!);
                          return CustomDropdown<String>.search(
                            hintText: '',
                            decoration: CustomDropdownDecoration(
                                headerStyle: AppStyles.textStyle16
                                    .copyWith(color: Colors.black),
                                closedFillColor: Colors.transparent,
                                closedBorder:
                                    Border.all(color: AppColors.blueDark)),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return S.of(context).field_is_required;
                              } else {
                                return null;
                              }
                            },
                            items: dropListData.isEmpty
                                ? [""]
                                : List.generate(dropListData.length,
                                    (index) => dropListData[index].text ?? ''),
                            onChanged: (value) {
                              newRowData
                                  .addAll({item.searchName!.toString(): value});
                            },
                          );
                        } else {
                          return const InitDropdown();
                        }
                      },
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        );
      }
      //checkbox
      if (item.insertType == "checkbox" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
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

  List<String> getCategory(List<ColumnList> columnList) {
    List<String> category = [];
    for (var item in columnList) {
      category.add(item.categoryName!);
    }
    List<String> categoryList = category.toSet().toList();
    return categoryList;
  }

  void getDropdownList(int pageId) async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ??
              "";
      String token =
          await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
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
