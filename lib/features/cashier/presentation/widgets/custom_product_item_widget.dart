import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../data/models/item_list_setup_model.dart';
import '../../data/models/product_model.dart';
import 'sales_fast_alert_dialog_add_widget.dart';

class CustomProductItemWidget extends StatefulWidget {
  const CustomProductItemWidget(
      {super.key,
      required this.productItem,
      required this.listColumn,
      required this.onTapAdd});
  final ProductItem productItem;
  final List<ItemListSetupModel> listColumn;
  final void Function(Map<String, dynamic>) onTapAdd;

  @override
  State<CustomProductItemWidget> createState() =>
      _CustomProductItemWidgetState();
}

class _CustomProductItemWidgetState extends State<CustomProductItemWidget> {
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
              widget.productItem.proPrice == null
                  ? "0.0 E.G"
                  : "${widget.productItem.proPrice} E.G",
              style: AppStyles.textStyle12.copyWith(color: AppColors.blueLight),
            ),
            Image.asset(
              "assets/images/logo.png",
              height: 55,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                widget.productItem.proName!,
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
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SalesFastAlertDialogAddWidget(
                listColumn: widget.listColumn,
                proName: widget.productItem.proName,
                proId: widget.productItem.proID,
                onTapAdd: (data) {
                  // tableListInAddView.add(data);
                  widget.onTapAdd(data);
                },
              ),
            );
          },
        );
      },
    );
  }
}
