// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Host`
  String get host_view {
    return Intl.message(
      'Host',
      name: 'host_view',
      desc: '',
      args: [],
    );
  }

  /// `WELCOME !`
  String get welcome {
    return Intl.message(
      'WELCOME !',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `LOG IN`
  String get login {
    return Intl.message(
      'LOG IN',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic Pro`
  String get dynamic_pro {
    return Intl.message(
      'Dynamic Pro',
      name: 'dynamic_pro',
      desc: '',
      args: [],
    );
  }

  /// `Username or Email`
  String get username_or_email {
    return Intl.message(
      'Username or Email',
      name: 'username_or_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Change Host`
  String get change_host {
    return Intl.message(
      'Change Host',
      name: 'change_host',
      desc: '',
      args: [],
    );
  }

  /// `Once you click OK, your current host and company ID will be permanently deleted.`
  String get change_host_description {
    return Intl.message(
      'Once you click OK, your current host and company ID will be permanently deleted.',
      name: 'change_host_description',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Company Identifier`
  String get company_identifier {
    return Intl.message(
      'Company Identifier',
      name: 'company_identifier',
      desc: '',
      args: [],
    );
  }

  /// `Hi, `
  String get hi {
    return Intl.message(
      'Hi, ',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Welcome in `
  String get welcome_in {
    return Intl.message(
      'Welcome in ',
      name: 'welcome_in',
      desc: '',
      args: [],
    );
  }

  /// `Search.....`
  String get search {
    return Intl.message(
      'Search.....',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `الرئيسية`
  String get home {
    return Intl.message(
      'الرئيسية',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `تقارير مبيعات العملاء`
  String get item1_1 {
    return Intl.message(
      'تقارير مبيعات العملاء',
      name: 'item1_1',
      desc: '',
      args: [],
    );
  }

  /// `تقارير مبيعات الكاشير`
  String get item1_2 {
    return Intl.message(
      'تقارير مبيعات الكاشير',
      name: 'item1_2',
      desc: '',
      args: [],
    );
  }

  /// `تقارير مبيعات المندوبيين`
  String get item1_3 {
    return Intl.message(
      'تقارير مبيعات المندوبيين',
      name: 'item1_3',
      desc: '',
      args: [],
    );
  }

  /// `تقارير أرباح مبيعات العملاء`
  String get item1_1_1 {
    return Intl.message(
      'تقارير أرباح مبيعات العملاء',
      name: 'item1_1_1',
      desc: '',
      args: [],
    );
  }

  /// `تقارير أرباح مبيعات الكاشير`
  String get item1_2_2 {
    return Intl.message(
      'تقارير أرباح مبيعات الكاشير',
      name: 'item1_2_2',
      desc: '',
      args: [],
    );
  }

  /// `تقارير أرباح مبيعات المندوبيين`
  String get item1_3_3 {
    return Intl.message(
      'تقارير أرباح مبيعات المندوبيين',
      name: 'item1_3_3',
      desc: '',
      args: [],
    );
  }

  /// `تقارير المشتريات فى فترة`
  String get item2 {
    return Intl.message(
      'تقارير المشتريات فى فترة',
      name: 'item2',
      desc: '',
      args: [],
    );
  }

  /// `تقرير كشف حساب للمورد`
  String get item3 {
    return Intl.message(
      'تقرير كشف حساب للمورد',
      name: 'item3',
      desc: '',
      args: [],
    );
  }

  /// `تقرير كشف حساب للعميل`
  String get item4 {
    return Intl.message(
      'تقرير كشف حساب للعميل',
      name: 'item4',
      desc: '',
      args: [],
    );
  }

  /// `المبالغ المسددة من مواردين`
  String get item5 {
    return Intl.message(
      'المبالغ المسددة من مواردين',
      name: 'item5',
      desc: '',
      args: [],
    );
  }

  /// `المبالغ المسددة من العملاء`
  String get item6 {
    return Intl.message(
      'المبالغ المسددة من العملاء',
      name: 'item6',
      desc: '',
      args: [],
    );
  }

  /// `المبالغ المتبقية للمواردين`
  String get item7 {
    return Intl.message(
      'المبالغ المتبقية للمواردين',
      name: 'item7',
      desc: '',
      args: [],
    );
  }

  /// `المبالغ المتبقية على العملاء`
  String get item8 {
    return Intl.message(
      'المبالغ المتبقية على العملاء',
      name: 'item8',
      desc: '',
      args: [],
    );
  }

  /// `المنتاجات`
  String get item9 {
    return Intl.message(
      'المنتاجات',
      name: 'item9',
      desc: '',
      args: [],
    );
  }

  /// `المصروفات`
  String get deserved {
    return Intl.message(
      'المصروفات',
      name: 'deserved',
      desc: '',
      args: [],
    );
  }

  /// `المخازن`
  String get stores {
    return Intl.message(
      'المخازن',
      name: 'stores',
      desc: '',
      args: [],
    );
  }

  /// `الحساب الحالى`
  String get nowCounter {
    return Intl.message(
      'الحساب الحالى',
      name: 'nowCounter',
      desc: '',
      args: [],
    );
  }

  /// `تقرير انتهاء الصلاحية`
  String get expire {
    return Intl.message(
      'تقرير انتهاء الصلاحية',
      name: 'expire',
      desc: '',
      args: [],
    );
  }

  /// `المنتجات التى وصلت الى الحد الادنى`
  String get rangeOrder {
    return Intl.message(
      'المنتجات التى وصلت الى الحد الادنى',
      name: 'rangeOrder',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى ايداع الخزنة فى فترة`
  String get stockInsert {
    return Intl.message(
      'اجمالى ايداع الخزنة فى فترة',
      name: 'stockInsert',
      desc: '',
      args: [],
    );
  }

  /// `سحب المبالغ`
  String get stockPull {
    return Intl.message(
      'سحب المبالغ',
      name: 'stockPull',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى تحويل الرصيد بين الخزنات`
  String get stockTransFire {
    return Intl.message(
      'اجمالى تحويل الرصيد بين الخزنات',
      name: 'stockTransFire',
      desc: '',
      args: [],
    );
  }

  /// `حساب البنك الحالى  `
  String get bankNowCounter {
    return Intl.message(
      'حساب البنك الحالى  ',
      name: 'bankNowCounter',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى ايداع البنك فى فترة`
  String get bankInsert {
    return Intl.message(
      'اجمالى ايداع البنك فى فترة',
      name: 'bankInsert',
      desc: '',
      args: [],
    );
  }

  /// `سحب المبالغ فى البنك`
  String get bankPull {
    return Intl.message(
      'سحب المبالغ فى البنك',
      name: 'bankPull',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى تحويل الرصيد بين البنوك`
  String get bankTransFire {
    return Intl.message(
      'اجمالى تحويل الرصيد بين البنوك',
      name: 'bankTransFire',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى الصرف والقبض فى فترة`
  String get sarfAndKapd {
    return Intl.message(
      'اجمالى الصرف والقبض فى فترة',
      name: 'sarfAndKapd',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى صافى الايرادات والخسارة فى فترة`
  String get eradAndKhosara {
    return Intl.message(
      'اجمالى صافى الايرادات والخسارة فى فترة',
      name: 'eradAndKhosara',
      desc: '',
      args: [],
    );
  }

  /// `الحضور والانصراف`
  String get attendAndGo {
    return Intl.message(
      'الحضور والانصراف',
      name: 'attendAndGo',
      desc: '',
      args: [],
    );
  }

  /// `العلاوات التشجيعية`
  String get employeeIncentives {
    return Intl.message(
      'العلاوات التشجيعية',
      name: 'employeeIncentives',
      desc: '',
      args: [],
    );
  }

  /// `الجزاءات والخصومات`
  String get employeeSanctions {
    return Intl.message(
      'الجزاءات والخصومات',
      name: 'employeeSanctions',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى المسحوبات للموظفين`
  String get employeeBorrowItem {
    return Intl.message(
      'اجمالى المسحوبات للموظفين',
      name: 'employeeBorrowItem',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى السلفيات فى فترة`
  String get employeeBorrowMoney {
    return Intl.message(
      'اجمالى السلفيات فى فترة',
      name: 'employeeBorrowMoney',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى صرف المرتبات فى فترة`
  String get employeeSalary {
    return Intl.message(
      'اجمالى صرف المرتبات فى فترة',
      name: 'employeeSalary',
      desc: '',
      args: [],
    );
  }

  /// `تقارير المرتجعات مبيعات - مشتريات`
  String get returnsDetails {
    return Intl.message(
      'تقارير المرتجعات مبيعات - مشتريات',
      name: 'returnsDetails',
      desc: '',
      args: [],
    );
  }

  /// `أوامرالشغل`
  String get runCommand {
    return Intl.message(
      'أوامرالشغل',
      name: 'runCommand',
      desc: '',
      args: [],
    );
  }

  /// `اجمالى المنتجات المخرجة فى فترة`
  String get productsOutStore {
    return Intl.message(
      'اجمالى المنتجات المخرجة فى فترة',
      name: 'productsOutStore',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
