import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../data/models/fast_screen_model.dart';

class ItemHome extends StatelessWidget {
  const ItemHome({
    super.key,
    required this.item1,
    required this.item2,
    required this.i,
  });

  final FastScreenModel item1;
  final FastScreenModel item2;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(2, (index) {
          FastScreenModel items = index.isEven ? item1 : item2;
          return Expanded(
            flex: i.isOdd
                ? index == 0
                    ? 4
                    : 2
                : 4,
            child: Container(
              color: Color(items.colorBackground),
              margin: EdgeInsets.all(1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/${items.image}.png",
                      width: 85,
                      height: 70,
                    ),
                  ),
                  Container(
                    height: 35,
                    alignment: Alignment.center,
                    color: Color(items.colorBackground),
                    child: AutoSizeText(items.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
