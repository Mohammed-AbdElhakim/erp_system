import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_loading_widget.dart';

class ItemGridView extends StatefulWidget {
  final Pages page;

  const ItemGridView({
    super.key,
    required this.page,
  });

  @override
  State<ItemGridView> createState() => _ItemGridViewState();
}

class _ItemGridViewState extends State<ItemGridView> {
  String? lang;
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

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
                  margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: CachedNetworkImage(
                    // width: 85,
                    // height: 70,
                    // fit: BoxFit.fill,
                    imageUrl: "http://${widget.page.icon}",
                    placeholder: (context, url) => const CustomLoadingWidget(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 35,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: AutoSizeText(
                      lang == AppStrings.enLangKey
                          ? widget.page.nameEn
                          : widget.page.nameAr,
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
      onTap: () {
        GoRouter.of(context).push(AppRouter.kScreenView, extra: widget.page);
      },
    );
  }
}

/*CachedNetworkImage(
                          // width: 85,
                          // height: 70,
                          // fit: BoxFit.fill,
                          imageUrl: widget.icon,
                          placeholder: (context, url) =>
                              const CustomLoadingWidget(),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 35,
                          ),
                        )*/
