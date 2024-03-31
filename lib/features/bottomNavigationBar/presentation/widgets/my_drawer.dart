import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/helper/ModalBottomSheet/build_show_modal_bottom_sheet.dart';
import '../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loaging_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../../home/data/models/menu_model/list_module.dart';
import '../../../home/presentation/manager/getMenu/get_menu_cubit.dart';
import 'custom_drawer_header.dart';
import 'custom_drawer_item.dart';
import 'drawer_body.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? lang;
  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMenuCubit, GetMenuState>(
      builder: (context, state) {
        if (state is GetMenuSuccess) {
          List<ListModule> listMenu = state.menu.list;

          return Drawer(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomDrawerHeader(userName: 'Mohamed'),
                  DrawerBody(
                    list: listMenu,
                  ),
                  CustomDrawerItem(
                    text: S.of(context).change_language,
                    onTap: () {
                      changeLanguage(context);
                    },
                  ),
                  CustomDrawerItem(
                    text: S.of(context).log_out,
                    onTap: () {
                      Pref.saveBoolToPref(
                          key: AppStrings.isLoginKey, value: false);
                      GoRouter.of(context)
                          .pushReplacement(AppRouter.kLoginView);
                    },
                  ),
                ],
              ),
            ),
          );
        } else if (state is GetMenuFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }

  void changeLanguage(BuildContext context) {
    buildShowModalBottomSheet(
      context: context,
      textButton1: lang == AppStrings.enLangKey
          ? S.of(context).arabic
          : S.of(context).english,
      textButton2: lang == AppStrings.enLangKey
          ? S.of(context).english
          : S.of(context).arabic,
      onTapButton1: () {
        if (lang == AppStrings.enLangKey) {
          setLang(context: context, langCode: AppStrings.arLangKey);
        } else {
          setLang(context: context, langCode: AppStrings.enLangKey);
        }
        Navigator.pop(context);
        Navigator.pop(context);
      },
      onTapButton2: () {
        if (lang == AppStrings.enLangKey) {
          setLang(context: context, langCode: AppStrings.enLangKey);
        } else {
          setLang(context: context, langCode: AppStrings.arLangKey);
        }
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  void setLang({required BuildContext context, required String langCode}) {
    ERPSystem.setLocale(context, Locale(langCode));
    Pref.saveStringToPref(key: AppStrings.langKey, value: langCode);
  }
}
