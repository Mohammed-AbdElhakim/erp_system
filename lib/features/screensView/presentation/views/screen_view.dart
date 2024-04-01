import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/core/widgets/custom_app_bar.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/screensView/presentation/manager/getScreen/get_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_container.dart';

class ScreenView extends StatefulWidget {
  const ScreenView({super.key, required this.pageData});

  final Pages pageData;

  @override
  State<ScreenView> createState() => _ScreenViewState();
}

class _ScreenViewState extends State<ScreenView> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          CustomContainer(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                lang == AppStrings.enLangKey
                    ? widget.pageData.nameEn
                    : widget.pageData.nameAr,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: AppStyles.textStyle26,
              ),
            ),
          ),
          getWidgetBody(widget.pageData.navigationKey),
        ],
      ),
    );
  }

  getWidgetBody(String navigationKey) {
    switch (navigationKey) {
      case "":
        return;
      default:
        return BlocBuilder<GetScreenCubit, GetScreenState>(
          builder: (context, state) {
            if (state is GetScreenSuccess) {
              return const Text("MOHAMED");
            } else if (state is GetScreenFailure) {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            } else {
              return const CustomLoadingWidget();
            }
          },
        );
    }
  }
}
