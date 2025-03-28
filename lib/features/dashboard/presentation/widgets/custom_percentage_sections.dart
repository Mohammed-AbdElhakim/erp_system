import 'dart:async';

import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/features/dashboard/presentation/widgets/build_scrolling_bar.dart';
import 'package:flutter/material.dart';

import '../../data/models/percentage_sections_model.dart';
import 'build_percentage_card.dart';
import 'build_section_title.dart';

class CustomPercentageSections extends StatefulWidget {
  const CustomPercentageSections(
      {super.key, required this.percentageSectionsModel});
  final PercentageSectionsModel percentageSectionsModel;

  @override
  State<CustomPercentageSections> createState() =>
      _CustomPercentageSectionsState();
}

class _CustomPercentageSectionsState extends State<CustomPercentageSections> {
  List<Color> colorPalette = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
    Colors.brown,
    Colors.cyan,
    Colors.indigo,
  ];
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
                    ? widget.percentageSectionsModel.nameEn!
                    : widget.percentageSectionsModel.nameAr!),
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
              widget.percentageSectionsModel.percentageSectionItems!.length,
              (index) {
                PercentageSectionItems percentageItem = widget
                    .percentageSectionsModel.percentageSectionItems![index];
                return BuildPercentageCard(
                  title: lang == AppStrings.enLangKey
                      ? percentageItem.nameEn!
                      : percentageItem.nameAr!,
                  // color: getColor(index,widget.percentageSectionsModel.percentageSectionItems!.length*5),
                  color: colorPalette[index % colorPalette.length],
                  value: percentageItem.number! / percentageItem.totalNumber!,
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

  // getColor(int index, int i) {
  //   // عدد الألوان المطلوبة
  //   int colorCount = i;
  //
  //   // قائمة لتخزين الألوان الفريدة
  //   List<Color> uniqueColors = [];
  //
  //   // مولّد عشوائي
  //   Random random = Random();
  //
  //   // توليد ألوان عشوائية بدون تكرار
  //   while (uniqueColors.length < colorCount) {
  //     Color color = Color.fromARGB(
  //       255,
  //       random.nextInt(256),
  //       random.nextInt(256),
  //       random.nextInt(256),
  //     );
  //
  //     if (!uniqueColors.contains(color)) {
  //       uniqueColors.add(color);
  //     }
  //   }
  //
  //   // طباعة الألوان
  //   return uniqueColors[index];
  // }
}
