import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../data/models/graph_sections_model.dart';
import 'build_graph_card.dart';
import 'build_scrolling_bar.dart';
import 'build_section_title.dart';

class CustomGraphsSections extends StatefulWidget {
  const CustomGraphsSections({super.key, required this.graphSectionsModel});
  final GraphSectionsModel graphSectionsModel;

  @override
  State<CustomGraphsSections> createState() => _CustomGraphsSectionsState();
}

class _CustomGraphsSectionsState extends State<CustomGraphsSections> {
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
                    ? widget.graphSectionsModel.nameEn!
                    : widget.graphSectionsModel.nameAr!),
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
              widget.graphSectionsModel.graphSectionItems!.length,
              (index) {
                GraphSectionItems graphItem =
                    widget.graphSectionsModel.graphSectionItems![index];
                return BuildGraphCard(
                  graphName: lang == AppStrings.enLangKey
                      ? graphItem.nameEn!
                      : graphItem.nameAr!,
                  graphValues: graphItem.graphValues!,
                );
              },
            ),
            height: 350)
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
