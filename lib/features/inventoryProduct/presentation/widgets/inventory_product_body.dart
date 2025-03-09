import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/api_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_date.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/dropdown_model.dart';
import '../../data/models/inventory_product_body_model.dart';
import '../../data/models/inventory_product_model.dart';
import '../manager/inventoryProduct/inventory_product_cubit.dart';
import 'inventory_product_table.dart';

class InventoryProductBody extends StatefulWidget {
  const InventoryProductBody({super.key});

  @override
  State<InventoryProductBody> createState() => _InventoryProductBodyState();
}

class _InventoryProductBodyState extends State<InventoryProductBody> {
  String dateFrom = "", dateTo = "";
  int storePram = 0;
  List<DropdownItem> dropdownItems = [];
  @override
  void initState() {
    fetchDropdownItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8, right: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).date_from),
                        CustomDate(
                          onSelect: (date) {
                            setState(() {
                              dateFrom = date;
                            });
                            if (dateTo.isNotEmpty) {
                              BlocProvider.of<InventoryProductCubit>(context)
                                  .getInventoryProduct(
                                inventoryProductBody: InventoryProductBodyModel(
                                    datefrom: dateFrom, dateto: dateTo, pram: storePram),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).date_to),
                        CustomDate(
                          onSelect: (date) {
                            setState(() {
                              dateTo = date;
                            });
                            if (dateFrom.isNotEmpty) {
                              BlocProvider.of<InventoryProductCubit>(context)
                                  .getInventoryProduct(
                                inventoryProductBody: InventoryProductBodyModel(
                                  datefrom: dateFrom,
                                  dateto: dateTo,
                                  pram: storePram,
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("المخزن"),
                  StatefulBuilder(
                    builder: (context, dropSetState) {
                      return SizedBox(
                        height: 40,
                        child: CustomDropdown<DropdownItem>.search(
                          hintText: '',
                          closedHeaderPadding:
                              const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: CustomDropdownDecoration(
                            headerStyle:
                                AppStyles.textStyle16.copyWith(color: Colors.black),
                            closedFillColor: Colors.transparent,
                            closedBorder: Border.all(color: AppColors.blueDark),
                          ),
                          items: dropdownItems,
                          onChanged: (selectValue) {
                            dropSetState(() {
                              storePram = int.parse(selectValue!.value!);
                              if (dateTo.isNotEmpty && dateFrom.isNotEmpty) {
                                BlocProvider.of<InventoryProductCubit>(context)
                                    .getInventoryProduct(
                                  inventoryProductBody: InventoryProductBodyModel(
                                      datefrom: dateFrom,
                                      dateto: dateTo,
                                      pram: storePram),
                                );
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<InventoryProductCubit, InventoryProductState>(
          builder: (context, state) {
            if (state is InventoryProductSuccess) {
              List<InventoryProductModel> inventoryProductList =
                  state.inventoryProductModel;
              return InventoryProductTable(
                inventoryProductList: inventoryProductList,
                // selectionItemsShow: selectionItems,
              );
            } else if (state is InventoryProductFailure) {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            } else if (state is InventoryProductLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CustomLoadingWidget(),
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  void fetchDropdownItems() async {
    try {
      String companyKey =
          await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      Map<String, dynamic> dropdownData = await ApiService(Dio()).get(
        endPoint:
            "home/getDropDown?DroModel=storeView&DroValue=SID&DroText=SName&DroCondition=&DroCompany=",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );
      setState(() {
        dropdownItems =
            DropdownModel.fromJson(dropdownData).list!; // عدّل المفتاح حسب API
      });
    } catch (e) {
      log('Error fetching data: $e');
    }
  }
}
