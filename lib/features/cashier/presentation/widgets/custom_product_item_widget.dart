import 'package:auto_size_text/auto_size_text.dart';
import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';

class CustomProductItemWidget extends StatelessWidget {
  const CustomProductItemWidget({super.key, required this.productItem});
  final ProductItem productItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
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
                    margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: AutoSizeText(
                        productItem.proName!,
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
          Container(
            width: 80,
            height: 30,
            decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(20),
                    topEnd: Radius.circular(20))),
            child: Center(
              child: Text(
                productItem.proPrice == null
                    ? "Free"
                    : "${productItem.proPrice} E.G",
                style:
                    AppStyles.textStyle14.copyWith(color: AppColors.blueLight),
              ),
            ),
          )
        ],
      ),
      onTap: () {
        // GoRouter.of(context).push(AppRouter.kScreenView, extra: widget.page);
      },
    );
  }
}
