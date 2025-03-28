import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../data/models/dropdown_model/all_dropdown_model.dart';
import '../manager/getAllDropdownList/get_all_dropdown_list_cubit.dart';
import '../manager/getPermissions/get_permissions_cubit.dart';
import '../manager/getTable/get_table_cubit.dart';
import '../widgets/custom_floating_action_button.dart';
import '../widgets/screen_table_body.dart';

class ScreenTable extends StatefulWidget {
  const ScreenTable({super.key, required this.pageData});

  final Pages pageData;

  static List<dynamic> rowData = [];
  static List<String> listCategory = [];
  static List<AllDropdownModel> myAllDropdownModelList = [];
  static bool isSearch = false;
  static late String orderBy;
  static late bool isDesc;
  static late int numberPage;
  static late int dropdownValue;
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
  void initState() {
    BlocProvider.of<GetTableCubit>(context).getTable(
        pageId: widget.pageData.pageId,
        employee: false,
        isdesc: widget.pageData.isDesc,
        limit: 10,
        offset: 0,
        orderby: widget.pageData.orderBy,
        statment: "",
        selectcolumns: '',
        departmentName: widget.pageData.departmentName,
        isDepartment: widget.pageData.isDepartment,
        authorizationID: widget.pageData.authorizationID,
        viewEmployeeColumn: widget.pageData.viewEmployeeColumn,
        dropdownValueOfLimit: 10,
        numberOfPage: 1);
    BlocProvider.of<GetPermissionsCubit>(context)
        .getPagePermissions(widget.pageData.pageId.toString());
    BlocProvider.of<GetAllDropdownListCubit>(context)
        .getAllDropdownList(pageId: widget.pageData.pageId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        appBar: CustomAppBar(
          isPortrait: isOrientationPortrait(context),
          title: lang == AppStrings.enLangKey
              ? widget.pageData.nameEn
              : widget.pageData.nameAr,
        ),
        floatingActionButton: CustomFloatingActionButton(
          pageData: widget.pageData,
        ),
        body: Column(
          children: [
            isOrientationPortrait(context)
                ? CustomContainer(
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
                  )
                : const SizedBox(
                    height: 25,
                  ),
            ScreenTableBody(
              pageData: widget.pageData,
            ),
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
