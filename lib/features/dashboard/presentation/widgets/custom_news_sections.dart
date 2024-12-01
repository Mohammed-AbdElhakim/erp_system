import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../data/models/news_sections_model.dart';
import 'build_news_card.dart';
import 'build_scrolling_bar.dart';
import 'build_section_title.dart';

class CustomNewsSections extends StatefulWidget {
  const CustomNewsSections({super.key, required this.newsSectionsModel});
  final NewsSectionsModel newsSectionsModel;

  @override
  State<CustomNewsSections> createState() => _CustomNewsSectionsState();
}

class _CustomNewsSectionsState extends State<CustomNewsSections> {
  final ScrollController controller = ScrollController();
  String? lang;
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _autoScroll(controller);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildSectionTitle(
            title: lang == AppStrings.enLangKey
                ? widget.newsSectionsModel.nameEn!
                : widget.newsSectionsModel.nameAr!),
        BuildScrollingBar(
            controller: controller,
            items: List.generate(
              widget.newsSectionsModel.newsSectionItems!.length,
                  (index) {
                NewsSectionItems newsItem = widget
                    .newsSectionsModel.newsSectionItems![index];
                return BuildNewsCard(
                 newsText: newsItem.newsText!,
                  time: newsItem.date!,
                );
              },
            ),
            height: 80)
      ],
    );
  }

  void _autoScroll(ScrollController controller) {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (controller.hasClients) {
        final maxScroll = controller.position.maxScrollExtent;
        final currentScroll = controller.offset;
        if (currentScroll < maxScroll) {
          controller.animateTo(
            currentScroll + 100,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          controller.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }
}
