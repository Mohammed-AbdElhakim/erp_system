import 'package:erp_system/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';
import '../../data/models/product_model.dart';
import 'custom_product_item_widget.dart';

class CustomSearch extends SearchDelegate {
  final List<ProductItem> productList;

  CustomSearch({required this.productList});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ProductItem> machQuery = [];
    for (var item in productList) {
      if (item.proName != null) {
        if (item.proName!.contains(query)) {
          machQuery.add(item);
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Center(
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 5.0,
            spacing: 5,
            children: machQuery
                .map(
                  (e) => CustomProductItemWidget(
                    productItem: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductItem> machQuery = [];
    for (var item in productList) {
      if (item.proName != null) {
        if (item.proName!.contains(query)) {
          machQuery.add(item);
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Center(
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 5.0,
            spacing: 5,
            children: machQuery
                .map(
                  (e) => CustomProductItemWidget(
                    productItem: e,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryAccent, // لون الخلفية
        iconTheme: IconThemeData(color: Colors.white), // لون الأيقونات
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppStyles.textStyle14.copyWith(color: AppColors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        fillColor: AppColors.blueGreyLight,
        constraints: const BoxConstraints(
          minHeight: 40.0, // ارتفاع الـ TextField الأدنى
          maxHeight: 40.0, // ارتفاع الـ TextField الأقصى
        ),
        filled: true, // لون النص الافتراضي (Hint)
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.blueDark,
            )), // إخفاء الحدود
      ),
    );
  }
}
