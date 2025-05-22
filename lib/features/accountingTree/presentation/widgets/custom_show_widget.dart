import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:erp_system/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/account_view_model.dart';
import '../../data/models/all_dropdown_model.dart';
import '../../data/models/header_account_tree_model.dart';
import '../views/accounting_tree_view.dart';

class CustomShowWidget extends StatefulWidget {
  const CustomShowWidget({super.key, this.item, required this.type, this.data});

  final AccountTreeModel? item;
  final String type;
  final void Function(Map<String, dynamic> newItem)? data;

  @override
  State<CustomShowWidget> createState() => _CustomShowWidgetState();
}

class _CustomShowWidgetState extends State<CustomShowWidget> {
  late Map<String, dynamic> editedValues;
  late bool isEditable;
  late List<AllDropdownModel> myAllDropdownModelList;
  List<HeaderAccountTreeModel> fields = [];

  @override
  void initState() {
    super.initState();
    myAllDropdownModelList = AccountingTreeView.dataListDropdown;

    if (widget.item != null) {
      switch (widget.type) {
        case "show":
          editedValues = Map<String, dynamic>.from(widget.item!.toJson());
          for (var i in AccountingTreeView.dataListHeader) {
            if (i.visible == true && i.cvisable == true) {
              fields.add(i);
            }
          }
          isEditable = false;
          break;
        case "edit":
          editedValues = Map<String, dynamic>.from(widget.item!.toJson());
          for (var i in AccountingTreeView.dataListHeader) {
            if (i.insertDefult == true && i.insertVisable == true) {
              fields.add(i);
            }
          }
          isEditable = true;
          break;
        case "add":
          editedValues = {};
          editedValues['AcParent'] = widget.item!.acId;
          editedValues['Sheet'] = widget.item!.sheet;
          editedValues['CreditORDepit'] = widget.item!.creditOrDepit;

          for (var i in AccountingTreeView.dataListHeader) {
            if (i.insertDefult == true && i.insertVisable == true) {
              fields.add(i);
            }
          }
          isEditable = true;
          break;
      }
    } else {
      editedValues = {};

      for (var i in AccountingTreeView.dataListHeader) {
        if (i.insertDefult == true && i.insertVisable == true) {
          fields.add(i);
        }
      }
      isEditable = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedFields = groupByCategory(fields);
    // print('===============$editedValues================');
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .7,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groupedFields.entries.map((entry) {
                  final categoryTitle = entry.key;
                  final fieldsInCategory = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...fieldsInCategory.map((field) {
                          final columnName = field.columnName ?? '';
                          final value = editedValues[columnName] ?? '';

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: buildInputField(
                              field: field,
                              value: value,
                              isEditable: isEditable,
                              onChanged: (col, val) {
                                setState(() {
                                  editedValues[col] = val;
                                });
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Row(
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
              if (widget.type != "show")
                CustomButton(
                  text: widget.type == "add"
                      ? S.of(context).btn_add
                      : widget.type == "edit"
                          ? S.of(context).btn_edit
                          : "",
                  width: 80,
                  onTap: () {
                    widget.data?.call(editedValues);
                    // Navigator.pop(context);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, List<HeaderAccountTreeModel>> groupByCategory(List<HeaderAccountTreeModel> fields) {
    final Map<String, List<HeaderAccountTreeModel>> grouped = {};

    for (final field in fields) {
      final category = field.categoryTitle ?? "بدون تصنيف";
      grouped.putIfAbsent(category, () => []).add(field);
    }

    // رتّب حسب categorySort
    final sortedMapEntries = grouped.entries.toList()
      ..sort((a, b) {
        final aSort = a.value.first.categorySort ?? 0;
        final bSort = b.value.first.categorySort ?? 0;
        return aSort.compareTo(bSort);
      });

    // رجّعهم كـ Map مرتب (LinkedHashMap يحافظ على الترتيب)
    return Map.fromEntries(sortedMapEntries);
  }

  Widget buildInputField({
    required HeaderAccountTreeModel field,
    required dynamic value,
    required bool isEditable,
    required void Function(String columnName, dynamic newValue) onChanged,
  }) {
    final type = field.insertType?.toLowerCase() ?? 'text';
    final label = field.arColumnLabel ?? field.columnName ?? '';

    switch (type) {
      case 'text':
      case 'number':
        return buildTextAndNumberWidget(isEditable, value, type, label, onChanged, field);

      case 'checkbox':
        return buildCheckBoxWidget(label, value, isEditable, onChanged, field);

      case 'dropdown':
        return buildDropdownWidget(label, value, isEditable, onChanged, field);

      default:
        return buildTextAndNumberWidget(isEditable, value, type, label, onChanged, field);
    }
  }

  Widget buildDropdownWidget(String label, value, bool isEditable, void Function(String columnName, dynamic newValue) onChanged,
      HeaderAccountTreeModel field) {
    List<ListDrop>? listDrop = myAllDropdownModelList
        .firstWhere(
          (element) => element.listName == "AccountView",
        )
        .list;
    List<ItemDrop>? myListDrop = [];

    for (var ii in listDrop!) {
      if (ii.columnName == field.columnName && ii.nameAr == field.arColumnLabel) {
        myListDrop = ii.list;
      }
    }
    ItemDrop? dropValue;
    for (var i in myListDrop!) {
      if (i.id.toString() == value.toString()) {
        dropValue = i;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: AppStyles.textStyle14.copyWith(color: Colors.grey),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () async {
                  getDropdownList(AccountingTreeView.pageId);
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
            builder: (context, dropSetState) {
              return SizedBox(
                height: 40,
                child: CustomDropdown<ItemDrop>.search(
                  hintText: '',
                  enabled: isEditable,
                  initialItem: dropValue,
                  closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: CustomDropdownDecoration(
                    headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                    closedFillColor: Colors.transparent,
                    closedBorder: Border.all(color: AppColors.blueDark),
                  ),
                  items: myListDrop!.isEmpty ? [] : myListDrop,
                  onChanged: isEditable ? (val) => onChanged(field.columnName!, val!.id) : null,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildTextAndNumberWidget(bool isEditable, value, String type, String label,
      void Function(String columnName, dynamic newValue) onChanged, HeaderAccountTreeModel field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyles.textStyle14.copyWith(color: Colors.grey),
          ),
          CustomTextFormField(
            hintText: '',
            keyboardType: type == 'number' ? TextInputType.number : TextInputType.text,
            onChanged: (val) => onChanged(field.columnName!, val),
            enabled: isEditable,
            initialValue: value?.toString() ?? '',
          ),
        ],
      ),
    );
  }

  Widget buildCheckBoxWidget(String label, value, bool isEditable, void Function(String columnName, dynamic newValue) onChanged,
      HeaderAccountTreeModel field) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      value: value == true,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        label,
        style: AppStyles.textStyle14.copyWith(color: isEditable ? Colors.black : Colors.grey),
      ),
      onChanged: isEditable ? (val) => onChanged(field.columnName!, val) : null,
    );
  }

  void getDropdownList(int pageId) async {
    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
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
