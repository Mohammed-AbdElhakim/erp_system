import 'package:erp_system/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/models/tabs_model.dart';
import 'custom_tap_widget.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({super.key, required this.selectTab, required this.onTap, required this.listTabs});

  final int selectTab;
  final void Function(int index) onTap;
  final List<PageDetail> listTabs;

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
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
            widget.listTabs.length,
            (index) {
              return CustomTapWidget(
                title:
                    lang == AppStrings.arLangKey ? widget.listTabs[index].displayArabic! : widget.listTabs[index].displayEnglish!,
                color: index == widget.selectTab ? Colors.white : Colors.transparent,
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
