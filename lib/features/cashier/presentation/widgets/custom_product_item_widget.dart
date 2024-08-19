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
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: AppColors.blueGreyLight,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              productItem.proPrice == null
                  ? "Free"
                  : "${productItem.proPrice} E.G",
              style: AppStyles.textStyle12.copyWith(color: AppColors.blueLight),
            ),
            Image.asset(
              "assets/images/logo.png",
              height: 55,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                productItem.proName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.textStyle12
                    .copyWith(color: AppColors.blueGreyDark),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // GoRouter.of(context).push(AppRouter.kScreenView, extra: widget.page);
      },
    );
  }
}
