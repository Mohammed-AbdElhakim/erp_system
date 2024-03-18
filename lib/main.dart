import 'package:erp_system/core/helper/SharedPreferences/pref.dart';
import 'package:erp_system/core/utils/app_router.dart';
import 'package:erp_system/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() {
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
  Locale _locale = Locale(AppStrings.enLang);

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: false,
      ),
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
    );
  }

  Future<void> getLocale() async {
    String language =
        await Pref.getStringFromPref(key: AppStrings.lang) ?? AppStrings.enLang;
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
