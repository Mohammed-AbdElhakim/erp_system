import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

typedef TapRefresh = void Function();
typedef ListChanged<T> = void Function(List<T> selectedList);
typedef Changed<T> = void Function(T value);

class CustomDropdownList<T> extends StatelessWidget {
  const CustomDropdownList({
    super.key,
    required this.title,
    this.isRequired = false,
    required this.onTapRefresh,
    this.isMultiSelect = false,
    this.initialDropValue,
    this.initialDropValueList,
    required this.listData,
    this.onListChanged,
    this.onChanged,
  });

  final String title;
  final bool? isRequired;
  final TapRefresh onTapRefresh;
  final bool? isMultiSelect;
  final List<T>? initialDropValueList;
  final T? initialDropValue;
  final List<T> listData;
  final ListChanged<T>? onListChanged;
  final Changed<T>? onChanged;

  @override
  Widget build(BuildContext context) {
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
              if (isRequired == true)
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10,
                ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  onTapRefresh();
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
                child: isMultiSelect == false
                    ? CustomDropdown<T>.search(
                        hintText: '',
                        initialItem: initialDropValue,
                        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: CustomDropdownDecoration(
                          headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                          closedFillColor: Colors.transparent,
                          closedBorder: Border.all(color: AppColors.blueDark),
                        ),
                        items: listData,
                        onChanged: (value) {
                          onChanged!(value as T);
                        },
                      )
                    : CustomDropdown<T>.multiSelectSearch(
                        hintText: '',
                        initialItems: initialDropValueList,
                        onListChanged: (valueList) {
                          onListChanged!(valueList);
                        },
                        // initialItem: dropValue,
                        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: CustomDropdownDecoration(
                          headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                          closedFillColor: Colors.transparent,
                          closedBorder: Border.all(color: AppColors.blueDark),
                        ),
                        items: listData,
                      ),
              );
            },
          )
        ],
      ),
    );
  }
}
