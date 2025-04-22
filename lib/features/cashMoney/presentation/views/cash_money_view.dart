import 'package:flutter/material.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_container.dart';
import '../widgets/cash_money_view_body.dart';

class CashMoneyView extends StatefulWidget {
  const CashMoneyView({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<CashMoneyView> createState() => _CashMoneyViewState();
}

class _CashMoneyViewState extends State<CashMoneyView> {
  String? lang;
  final ScrollController scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = isOrientationPortrait(context);
    return ChangeStatusBarColor(
      child: Scaffold(
        appBar: CustomAppBar(
          isPortrait: isPortrait,
          title: lang == AppStrings.enLangKey ? widget.pageData.nameEn : widget.pageData.nameAr,
        ),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              isPortrait
                  ? CustomContainer(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          lang == AppStrings.enLangKey ? widget.pageData.nameEn : widget.pageData.nameAr,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle26,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 25,
                    ),
              CashMoneyViewBody(
                scrollController: scrollController,
                pageData: widget.pageData,
              )
            ],
          ),
        ),
      ),
    );
  }
}
