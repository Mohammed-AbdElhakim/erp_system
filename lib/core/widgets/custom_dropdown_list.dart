import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

typedef TapRefresh = void Function();
typedef ListChanged<T> = void Function(List<T> selectedList);
typedef Changed<T> = void Function(T? value);

class CustomDropdownList<T> extends StatefulWidget {
  const CustomDropdownList({
    super.key,
    this.title,
    this.isRequired = false,
    this.isShowRefresh = false,
    this.onTapRefresh,
    this.isMultiSelect = false,
    this.initialDropValue,
    this.initialDropValueList,
    required this.listData,
    this.onListChanged,
    this.onChanged,
  });

  final String? title;
  final bool? isRequired;
  final bool? isShowRefresh;
  final TapRefresh? onTapRefresh;
  final bool? isMultiSelect;
  final List<T>? initialDropValueList;
  final T? initialDropValue;
  final List<T> listData;
  final ListChanged<T>? onListChanged;
  final Changed<T>? onChanged;

  @override
  State<CustomDropdownList<T>> createState() => _CustomDropdownListState<T>();
}

class _CustomDropdownListState<T> extends State<CustomDropdownList<T>> {
  late final SingleSelectController<T>? _controller;

  @override
  void initState() {
    _controller = SingleSelectController<T>(widget.initialDropValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Row(
              children: [
                Text(
                  widget.title!,
                  style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                ),
                if (widget.isRequired == true)
                  const Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 10,
                  ),
                const SizedBox(
                  width: 12,
                ),
                if (widget.isShowRefresh == true)
                  InkWell(
                    onTap: () {
                      if (widget.onTapRefresh != null) widget.onTapRefresh!();
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
                child: widget.isMultiSelect == false
                    ? CustomDropdown<T>.search(
                        hintText: '',
                        // initialItem: widget.initialDropValue,
                        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: CustomDropdownDecoration(
                          headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                          closedFillColor: Colors.transparent,
                          closedBorder: Border.all(color: AppColors.blueDark),
                        ),
                        controller: _controller,
                        items: widget.listData,
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
                                    if (_controller != null) {
                                      _controller.clear();
                                    }
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: AppColors.blueLight,
                                  ))
                            ],
                          );
                        },
                        hintBuilder: (context, hint, enabled) {
                          if (widget.listData.isEmpty) {
                            return Row(
                              children: [
                                const Spacer(),
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    color: AppColors.blueLight,
                                    strokeWidth: 1.2,
                                  ),
                                )
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                        onChanged: (value) {
                          if (widget.onChanged != null) widget.onChanged!(value);
                        },
                      )
                    : CustomDropdown<T>.multiSelectSearch(
                        hintText: '',
                        initialItems: widget.initialDropValueList,
                        onListChanged: (valueList) {
                          if (widget.onListChanged != null) widget.onListChanged!(valueList);
                        },
                        hintBuilder: (context, hint, enabled) {
                          if (widget.listData.isEmpty) {
                            return Row(
                              children: [
                                const Spacer(),
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    color: AppColors.blueLight,
                                    strokeWidth: 1.2,
                                  ),
                                )
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                        closedHeaderPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: CustomDropdownDecoration(
                          headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                          closedFillColor: Colors.transparent,
                          closedBorder: Border.all(color: AppColors.blueDark),
                        ),
                        items: widget.listData,
                      ),
              );
            },
          )
        ],
      ),
    );
  }
}
