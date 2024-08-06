import 'package:erp_system/features/screenTable/presentation/manager/addEditExpenses/add_edit_expenses_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/helper/SharedPreferences/pref.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_router.dart';
import 'core/utils/app_strings.dart';
import 'core/utils/service_locator.dart';
import 'features/screenTable/data/repositories/screen_repo_impl.dart';
import 'features/screenTable/presentation/manager/addEdit/add_edit_cubit.dart';
import 'features/screenTable/presentation/manager/delete/delete_cubit.dart';
import 'features/screenTable/presentation/manager/getAllDropdownList/get_all_dropdown_list_cubit.dart';
import 'features/screenTable/presentation/manager/getPageDetailsTable/get_page_details_table_cubit.dart';
import 'features/screenTable/presentation/manager/getPermissions/get_permissions_cubit.dart';
import 'features/screenTable/presentation/manager/getTable/get_table_cubit.dart';
import 'features/trialBalance/data/repositories/trial_balance_repo_impl.dart';
import 'features/trialBalance/presentation/manager/trialBalance/trial_balance_cubit.dart';
import 'generated/l10n.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColors.blueDark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(ListDropdownModelAdapter());
  // await Hive.openBox<ListDropdownModel>(AppStrings.listDropdownBox);
  setupServiceLocator();
  runApp(const ERPSystem());
}

class ERPSystem extends StatefulWidget {
  const ERPSystem({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _ERPSystemState? state = context.findAncestorStateOfType<_ERPSystemState>();
    state?.setLocale(locale);
  }

  @override
  State<ERPSystem> createState() => _ERPSystemState();
}

class _ERPSystemState extends State<ERPSystem> {
  Locale _locale = const Locale(AppStrings.arLangKey);

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetTableCubit(
            getIt.get<ScreenRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => TrialBalanceCubit(
            getIt.get<TrialBalanceRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => GetPermissionsCubit(
            getIt.get<ScreenRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) => AddEditCubit(getIt.get<ScreenRepoImpl>()),
        ),
        BlocProvider(
          create: (context) =>
              AddEditExpensesCubit(getIt.get<ScreenRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => DeleteCubit(getIt.get<ScreenRepoImpl>()),
        ),
        BlocProvider(
          create: (context) =>
              GetAllDropdownListCubit(getIt.get<ScreenRepoImpl>()),
        ),
        BlocProvider(
          create: (context) =>
              GetPageDetailsTableCubit(getIt.get<ScreenRepoImpl>()),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appTitle,
        theme: ThemeData(
            fontFamily: AppStrings.appFontFamily,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.blueDark,
            ),
            useMaterial3: true),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        locale: _locale,
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
  }

  Future<void> getLocale() async {
    String language = await Pref.getStringFromPref(key: AppStrings.langKey) ??
        AppStrings.arLangKey;
    setState(() {
      _locale = Locale(language);
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
}
