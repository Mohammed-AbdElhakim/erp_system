import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:erp_system/features/cashier/presentation/widgets/cashier_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../core/widgets/custom_date_picker_field.dart';
import '../../../../core/widgets/custom_time_picker_field.dart';
import '../../../cashier/data/models/all_dropdown_model.dart';
import '../../data/models/item_list_setup_model.dart';
import '../../data/models/tap_model.dart';
import '../views/cashier_view.dart';

typedef OnTapAdd<T> = void Function(T data);

class SalesFastAlertDialogAddWidget extends StatefulWidget {
  const SalesFastAlertDialogAddWidget({
    super.key,
    required this.listColumn,
    required this.onTapAdd,
    // required this.proName,
    this.proId,
    required this.tapData,
    this.dataOld,
  });

  final List<ItemListSetupModel> listColumn;
  final OnTapAdd<Map<String, dynamic>> onTapAdd;

  // final String? proName;
  final int? proId;
  final ListTaps tapData;
  final Map<String, dynamic>? dataOld;

  @override
  State<SalesFastAlertDialogAddWidget> createState() => _SalesFastAlertDialogAddWidgetState();
}

class _SalesFastAlertDialogAddWidgetState extends State<SalesFastAlertDialogAddWidget> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  late int customerCategoryID;

  Map<String, String> selectedDates = {};
  Map<String, String> selectedTimes = {};
  Map<String, String?> selectedDropdownValues = {};
  Map<String, dynamic> initialValues = {};
  Map<String, TextEditingController> controllersNumber = {};

  @override
  void initState() {
    customerCategoryID = CashierViewBody.listCustomerAccount.firstWhere(
          (element) => element['CustomerAccountID'] == CashierViewBody.userId,
          orElse: () => {"CategoryID": -1},
        )['CategoryID'] ??
        -1;

    if (widget.dataOld != null) {
      initialValues = Map<String, dynamic>.from(widget.dataOld!);

      for (var entry in initialValues.entries) {
        // إذا كان حقل رقم، ضيفه في الكنترولر
        controllersNumber[entry.key] = TextEditingController(
          text: entry.value?.toString() ?? '',
        );
      }

      // تعبئة القيم المختارة للدروب داون
      for (var item in widget.listColumn) {
        if (item.insertType == 'dropdown' && item.columnName != null) {
          selectedDropdownValues[item.columnName!] =
              widget.dataOld![item.searchName]?.toString() ?? widget.dataOld![item.columnName]?.toString();
        }
      }
    } else {
      saveProIfo();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                    ...buildWidgetsFromList(widget.listColumn, widget.tapData),
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
                    textStyle: AppStyles.textStyle16.copyWith(color: Colors.grey),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  CustomButton(
                    text: widget.dataOld == null ? S.of(context).btn_add : S.of(context).btn_edit,
                    width: 80,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();

                        Map<String, dynamic> finalRowData = {};
                        if (widget.dataOld != null) {
                          // في حالة التعديل: نجمع القديم مع الجديد وندي الجديد الأولوية
                          finalRowData = Map<String, dynamic>.from(widget.dataOld!);
                          finalRowData.addAll(newRowData);
                        } else {
                          finalRowData = {...newRowData};
                        }

                        widget.onTapAdd(finalRowData);
                        Navigator.pop(context);
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

  void saveProIfo() {
    // int proID = CashierViewBody.listProduct.firstWhere((element) => element['ProName'] == widget.proName)['ProID'];

    getPrice(widget.proId!);

    initialValues.putIfAbsent('ProductID', () => widget.proId.toString());
    initialValues.putIfAbsent('Qty', () => "1");

    controllersNumber.putIfAbsent('Qty', () {
      return TextEditingController(
        text: initialValues['Qty']?.toString() ?? '',
      );
    });

    newRowData['ProductID'] = widget.proId;

    // getPrice(widget.proId!);

    // initialValues['ProductID'] = widget.proId.toString();
    // initialValues['Qty'] = "1";
    // controllersNumber['Qty'] = TextEditingController(
    //   text: initialValues['Qty']?.toString() ?? '',
    // );

    // newRowData.addAll({"ProductID": widget.proId});
  }

  void getPrice(int proID) {
    double productPrice = CashierViewBody.listProductPrices.firstWhere(
          (element) => element['ProductID'] == proID && element['CustomerCategoryID'] == customerCategoryID,
          orElse: () => {},
        )['Price'] ??
        0.0;

    if (productPrice != 0.0) {
      initialValues['PriceCurrancy'] = productPrice.toString();
    } else {
      double price = CashierViewBody.listProduct.firstWhere(
            (element) => element["ProID"] == proID,
            orElse: () => {},
          )['ProPrice'] ??
          -1;

      if (price != -1) {
        initialValues['PriceCurrancy'] = price.toString();
      } else {
        initialValues['PriceCurrancy'] = "";
      }
    }
    controllersNumber['PriceCurrancy'] = TextEditingController(
      text: initialValues['PriceCurrancy']?.toString() ?? '',
    );
  }

  List<Widget> buildWidgetsFromList(List<ItemListSetupModel> list, ListTaps tapData) {
    List<Widget> widgets = [];

    for (var item in list) {
      if (item.insertVisable != true || item.columnName == null) continue;

      String title = lang == AppStrings.arLangKey ? item.arColumnLabel ?? '' : item.enColumnLabel ?? '';
      bool isRequired = item.isRquired ?? false;
      String columnName = item.columnName!;
      Widget? widget;

      switch (item.insertType) {
        case 'text':
          String? initialValue = initialValues[columnName]?.toString();
          widget = Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleWithStar(title, isRequired),
                CustomTextFormField(
                  hintText: '',
                  initialValue: initialValue,
                  isValidator: isRequired,
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    if ((newValue?.isNotEmpty ?? false)) {
                      setState(() {
                        newRowData[columnName] = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
          );
          break;

        case 'number':
          if (!controllersNumber.containsKey(columnName)) {
            controllersNumber[columnName] = TextEditingController(
              text: initialValues[columnName]?.toString() ?? '',
            );
          }
          // String? initialValue = initialValues[columnName]?.toString();
          widget = Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleWithStar(title, isRequired),
                CustomTextFormField(
                  hintText: '',
                  // initialValue: initialValue,
                  controller: controllersNumber[columnName],
                  isValidator: isRequired,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    if ((newValue?.isNotEmpty ?? false)) {
                      setState(() {
                        newRowData[columnName] = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
          );
          break;

        case 'dropdown':
          List<ListDrop> listDrop = [];
          List<ItemDrop> myListDrop = [];

          for (var ii in CashierView.myAllDropdownModelList) {
            if (ii.listName == tapData.listName) {
              listDrop = ii.list ?? [];
            }
          }

          for (var ii in listDrop) {
            if (ii.columnName == item.columnName && ii.nameAr == item.arColumnLabel) {
              myListDrop = ii.list!;
            }
          }
          String? selectedDropdownId = selectedDropdownValues[item.columnName] ?? initialValues[columnName]?.toString();
          String? selectedDropdownValue =
              myListDrop.firstWhere((element) => element.id == selectedDropdownId, orElse: () => ItemDrop()).text;

          widget = Padding(
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
                    if (isRequired)
                      const Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 10,
                      )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown<String>.search(
                        hintText: '',
                        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: CustomDropdownDecoration(
                          headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                          closedFillColor: Colors.transparent,
                          closedBorder: Border.all(color: AppColors.blueDark),
                        ),
                        validator: isRequired
                            ? (value) {
                                if (value?.isEmpty ?? true) {
                                  return S.of(context).field_is_required;
                                } else {
                                  return null;
                                }
                              }
                            : null,
                        items: myListDrop.map((e) => e.text ?? '').toList(),
                        initialItem: selectedDropdownValue,
                        onChanged: (value) {
                          if (value != null && value.isNotEmpty) {
                            setState(() {
                              ItemDrop? ii = myListDrop.firstWhere((element) => element.text == value, orElse: () => ItemDrop());
                              selectedDropdownValues[item.columnName!] = ii.id;
                              if (item.columnName == "ProductID") {
                                getPrice(int.parse(ii.id!));
                              }
                              newRowData[item.searchName!.toString()] = ii.id;
                            });
                          }
                        },
                      ),
                    ),
                    if (selectedDropdownValue != null && selectedDropdownValue.isNotEmpty)
                      InkWell(
                        child: const Padding(
                          padding: EdgeInsetsDirectional.only(start: 8),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedDropdownValues[item.columnName!] = null;
                            newRowData.remove(item.searchName!.toString());
                          });
                        },
                      )
                  ],
                )
              ],
            ),
          );
          break;

        case 'date':
          widget = CustomDatePickerField(
            title: title,
            isRequired: isRequired,
            initialDateString: selectedDates[columnName] ?? initialValues[columnName]?.toString(),
            onDateSelected: (selectedDate) {
              if (selectedDate != null) {
                setState(() {
                  selectedDates[columnName] = selectedDate.toIso8601String();
                  newRowData[columnName] = selectedDate.toString();
                });
              }
            },
            onClear: () {
              setState(() {
                selectedDates.remove(columnName);
                newRowData.remove(columnName);
              });
            },
          );
          break;

        case 'checkbox':
          bool checkboxValue = initialValues[columnName] == true;
          widget = StatefulBuilder(
            builder: (context, csetState) {
              return CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: checkboxValue,
                controlAffinity: ListTileControlAffinity.leading,
                title: _buildTitleWithStar(title, isRequired),
                onChanged: (newValue) {
                  csetState(() {
                    checkboxValue = newValue ?? false;
                    newRowData[columnName] = checkboxValue;
                  });
                },
              );
            },
          );
          break;

        case 'time':
          String time = selectedTimes[columnName] ?? initialValues[columnName]?.toString() ?? '';
          widget = CustomTimePickerField(
            title: title,
            itemIsRequired: isRequired,
            initialTimeString: time,
            onTimeSelected: (timeSelect) {
              if (timeSelect != null) {
                setState(() {
                  selectedTimes[columnName] = timeSelect;
                  newRowData[columnName] = timeSelect;
                });
              }
            },
            onClear: () {
              setState(() {
                selectedTimes.remove(columnName);
                newRowData.remove(columnName);
              });
            },
          );
          break;

        default:
          widget = Text('نوع غير مدعوم: ${item.insertType}');
      }

      widgets.add(widget);
    }

    return widgets;
  }

  Widget _buildTitleWithStar(String title, bool isRequired) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyles.textStyle14.copyWith(color: Colors.grey),
        ),
        if (isRequired)
          const Icon(
            Icons.star,
            color: Colors.red,
            size: 10,
          )
      ],
    );
  }
}
