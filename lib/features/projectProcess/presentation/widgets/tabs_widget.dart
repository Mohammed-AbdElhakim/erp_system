import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import 'custom_tap_widget.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({super.key, required this.selectTab, required this.onTap});
  final int selectTab;
  final void Function(int index) onTap;

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  List<String> listTabAr = [
    "كشف حساب",
    "مستخلص تفصيلي",
    "مستخلص إجمالي",
    "المصاريف",
  ];
  List<String> listTabEn = [
    "Account Sheet",
    "Detailed Extraction",
    "Total Extraction",
    "Expenses",
  ];
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: AppColors.blueLight.withOpacity(.3),
      color: AppColors.blueLight.withAlpha(77),
      width: double.infinity,
      child: Wrap(
        children: [
          const SizedBox(
            width: 10,
          ),
          ...List.generate(
            lang == AppStrings.arLangKey ? listTabAr.length : listTabEn.length,
            (index) {
              return CustomTapWidget(
                title: lang == AppStrings.arLangKey
                    ? listTabAr[index]
                    : listTabEn[index],
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
