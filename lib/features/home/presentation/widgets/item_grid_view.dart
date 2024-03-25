import 'package:auto_size_text/auto_size_text.dart';
import 'package:erp_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ItemGridView extends StatefulWidget {
  final String icon;
  final String title;
  final Function onTap;

  ItemGridView({required this.icon, required this.title, required this.onTap});

  @override
  State<ItemGridView> createState() => _ItemGridViewState();
}

class _ItemGridViewState extends State<ItemGridView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          // border: Border.all(width: 1.5, color: Colors.black38),
//                   color: Color(0xffF1B606),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.blueGreyLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Image.asset(
                    "assets/icons/${widget.icon}.png",
                    width: 85,
                    height: 70,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: AutoSizeText(
                      widget.title,
                      textAlign: TextAlign.center,
                      maxFontSize: 12,
                      minFontSize: 8,
                      style: TextStyle(color: AppColors.blueGreyDark),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () => widget.onTap(),
    );
  }
}
