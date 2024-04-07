import 'package:erp_system/core/utils/app_strings.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/screen_table_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../data/repositories/table_repo_impl.dart';
import '../manager/getTable/get_table_cubit.dart';
import '../widgets/custom_floating_action_button.dart';

class ScreenTable extends StatefulWidget {
  const ScreenTable({super.key, required this.pageData});
  final Pages pageData;

  @override
  State<ScreenTable> createState() => _ScreenTableState();
}

class _ScreenTableState extends State<ScreenTable> {
  String? lang;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetTableCubit(
        getIt.get<TableRepoImpl>(),
      )..getTable(widget.pageData),
      child: Scaffold(
        appBar: const CustomAppBar(),
        floatingActionButton: const CustomFloatingActionButton(),
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
            const ScreenTableBody(),
          ],
        ),
      ),
    );
  }
}
/*Directionality(
          textDirection: TextDirection.rtl,
          child: SpeedDialMenuButton(
            mainMenuFloatingActionButton: MainMenuFloatingActionButton(
                child: Icon(
                  Icons.menu,
                  color: AppColors.white,
                ),
                backgroundColor: AppColors.blueLight,
                closeMenuBackgroundColor:AppColors.blueLight ,
                closeMenuChild: Icon(
                  Icons.close,
                  color: AppColors.white,
                ),
                onPressed: () {}),
            isMainFABMini: true,
            floatingActionButtonWidgetChildren: [
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {},
                backgroundColor: AppColors.blue,
                child: Icon(
                  Icons.search,
                  color: AppColors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {},
                backgroundColor: AppColors.orange,
                child: Icon(
                  Icons.refresh,
                  color: AppColors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: "btn3",
                backgroundColor: AppColors.blueLight,
                onPressed: () {},
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: "btn4",
                onPressed: () {},
                backgroundColor: AppColors.blueGreyDark,
                child: Icon(
                  Icons.edit_note,
                  color: AppColors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: "btn5",
                onPressed: () {},
                backgroundColor: AppColors.red,
                child: Icon(
                  Icons.delete,
                  color: AppColors.white,
                ),
              )
            ],
            isSpeedDialFABsMini: false,
            mainFABPosX: lang == AppStrings.arLangKey ? 40 : 0,
          ),
        )*/
/*SpeedDial(
          backgroundColor: AppColors.blueLight,
          overlayOpacity: 0.5,
          child: Icon(
            Icons.settings,
            color: AppColors.white,
          ),
          activeIcon: Icons.close,
          iconTheme: IconThemeData(color: AppColors.white),
          buttonSize: Size(58, 58),
          curve: Curves.easeIn,
          children: [
            SpeedDialChild(
                elevation: 0,
                backgroundColor: AppColors.blue,
                shape: CircleBorder(),
                child: Icon(
                  Icons.search,
                  color: AppColors.white,
                ),
                onTap: () {
                  print(1);
                }),
            SpeedDialChild(
                elevation: 0,
                backgroundColor: AppColors.orange,
                shape: CircleBorder(),
                child: Icon(
                  Icons.refresh,
                  color: AppColors.white,
                ),
                onTap: () {}),
            SpeedDialChild(
                elevation: 0,
                backgroundColor: AppColors.blueLight,
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
                onTap: () {}),
            SpeedDialChild(
                elevation: 0,
                backgroundColor: AppColors.blueGreyDark,
                shape: CircleBorder(),
                child: Icon(
                  Icons.edit_note,
                  color: AppColors.white,
                ),
                onTap: () {}),
            SpeedDialChild(
                elevation: 0,
                backgroundColor: AppColors.red,
                shape: CircleBorder(),
                child: Icon(
                  Icons.delete,
                  color: AppColors.white,
                ),
                onTap: () {}),
          ],
        )*/
