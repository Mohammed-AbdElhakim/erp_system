import 'dart:async';

import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/features/dashboard/presentation/widgets/build_scrolling_bar.dart';
import 'package:flutter/material.dart';

import '../../data/models/numbers_sections_model.dart';
import 'build_number_card.dart';
import 'build_section_title.dart';

class CustomNumbersSections extends StatefulWidget {
  const CustomNumbersSections({super.key, required this.numbersSectionsModel});
  final NumbersSectionsModel numbersSectionsModel;

  @override
  State<CustomNumbersSections> createState() => _CustomNumbersSectionsState();
}

class _CustomNumbersSectionsState extends State<CustomNumbersSections> {
  final ScrollController controller = ScrollController();
  String? lang;
  bool isPlay = true;
  Timer? _scrollTimer;
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _autoScroll(controller, true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildSectionTitle(
                title: lang == AppStrings.enLangKey
                    ? widget.numbersSectionsModel.nameEn!
                    : widget.numbersSectionsModel.nameAr!),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 15),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    if (isPlay == true) {
                      stopScrolling();
                    }
                    isPlay = !isPlay;
                    _autoScroll(controller, isPlay);
                  });
                },
                icon: Icon(
                  isPlay ? Icons.stop_circle : Icons.play_circle,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        BuildScrollingBar(
            controller: controller,
            items: List.generate(
              widget.numbersSectionsModel.numbersSectionItems!.length,
              (index) {
                NumbersSectionItems numberItem =
                    widget.numbersSectionsModel.numbersSectionItems![index];
                return BuildNumberCard(
                  title: lang == AppStrings.enLangKey
                      ? numberItem.nameEn!
                      : numberItem.nameAr!,
                  value: numberItem.number!,
                  icon: numberItem.icon!,
                );
              },
            ),
            height: 120)
      ],
    );
  }

  void _autoScroll(ScrollController controller, bool isPlay) {
    if (!isPlay) {
      _scrollTimer?.cancel();
      _scrollTimer = null;
      return;
    }

    _scrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
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

  void stopScrolling() {
    _scrollTimer?.cancel();
    _scrollTimer = null;
  }
}
