import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/methods.dart';
import 'custom_tap_widget.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({super.key, required this.selectTab, required this.onTap});
  final int selectTab;
  final void Function(int index) onTap;

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  List<String> listTab = [
    "كشف حساب",
    "مشتريات تفصيلي",
    "دفعات المورد",
    "مستخلص تفصيلي",
    "مستخلص إجمالي",
    "كشف حساب تفصيلى",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWithOpacity(color: AppColors.blueLight, opacity: .3),
      width: double.infinity,
      child: Wrap(
        children: [
          const SizedBox(
            width: 10,
          ),
          ...List.generate(
            listTab.length,
            (index) {
              return CustomTapWidget(
                title: listTab[index],
                color: index == widget.selectTab
                    ? Colors.white
                    : Colors.transparent,
                onTap: () {
                  widget.onTap(index);
                },
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
