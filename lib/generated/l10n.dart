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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Host`
  String get host_view {
    return Intl.message('Host', name: 'host_view', desc: '', args: []);
  }

  /// `WELCOME !`
  String get welcome {
    return Intl.message('WELCOME !', name: 'welcome', desc: '', args: []);
  }

  /// `LOG IN`
  String get login {
    return Intl.message('LOG IN', name: 'login', desc: '', args: []);
  }

  /// `Dynamic Pro`
  String get dynamic_pro {
    return Intl.message('Dynamic Pro', name: 'dynamic_pro', desc: '', args: []);
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
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Change Host`
  String get change_host {
    return Intl.message('Change Host', name: 'change_host', desc: '', args: []);
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
    return Intl.message('Ok', name: 'ok', desc: '', args: []);
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
    return Intl.message('Hi, ', name: 'hi', desc: '', args: []);
  }

  /// `Welcome in `
  String get welcome_in {
    return Intl.message('Welcome in ', name: 'welcome_in', desc: '', args: []);
  }

  /// `Search.....`
  String get search {
    return Intl.message('Search.....', name: 'search', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Warning`
  String get warning {
    return Intl.message('Warning', name: 'warning', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Change Language`
  String get change_language {
    return Intl.message(
      'Change Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `عربي `
  String get arabic {
    return Intl.message('عربي ', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Log Out`
  String get log_out {
    return Intl.message('Log Out', name: 'log_out', desc: '', args: []);
  }

  /// `You do not have permission yet, Wait for the admin.`
  String get massage_permission {
    return Intl.message(
      'You do not have permission yet, Wait for the admin.',
      name: 'massage_permission',
      desc: '',
      args: [],
    );
  }

  /// `You do not have permission.`
  String get massage_no_permission {
    return Intl.message(
      'You do not have permission.',
      name: 'massage_no_permission',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Not available at this location.`
  String get no_location {
    return Intl.message(
      'Not available at this location.',
      name: 'no_location',
      desc: '',
      args: [],
    );
  }

  /// `Distance: `
  String get distance {
    return Intl.message('Distance: ', name: 'distance', desc: '', args: []);
  }

  /// `Swipe To`
  String get swipe_to {
    return Intl.message('Swipe To', name: 'swipe_to', desc: '', args: []);
  }

  /// `Attend`
  String get attend {
    return Intl.message('Attend', name: 'attend', desc: '', args: []);
  }

  /// `Leave`
  String get leave {
    return Intl.message('Leave', name: 'leave', desc: '', args: []);
  }

  /// `Search`
  String get btn_search {
    return Intl.message('Search', name: 'btn_search', desc: '', args: []);
  }

  /// `Add`
  String get btn_add {
    return Intl.message('Add', name: 'btn_add', desc: '', args: []);
  }

  /// `Edit`
  String get btn_edit {
    return Intl.message('Edit', name: 'btn_edit', desc: '', args: []);
  }

  /// `Delete`
  String get btn_delete {
    return Intl.message('Delete', name: 'btn_delete', desc: '', args: []);
  }

  /// `From`
  String get from {
    return Intl.message('From', name: 'from', desc: '', args: []);
  }

  /// `TO`
  String get to {
    return Intl.message('TO', name: 'to', desc: '', args: []);
  }

  /// `Please select the item you want to edit.`
  String get massage_choose_edit {
    return Intl.message(
      'Please select the item you want to edit.',
      name: 'massage_choose_edit',
      desc: '',
      args: [],
    );
  }

  /// `Please select the item you want to delete.`
  String get massage_choose_delete {
    return Intl.message(
      'Please select the item you want to delete.',
      name: 'massage_choose_delete',
      desc: '',
      args: [],
    );
  }

  /// `Eliminate zero balances.`
  String get massage_number_zero {
    return Intl.message(
      'Eliminate zero balances.',
      name: 'massage_number_zero',
      desc: '',
      args: [],
    );
  }

  /// `Multiple choices`
  String get multiple_choices {
    return Intl.message(
      'Multiple choices',
      name: 'multiple_choices',
      desc: '',
      args: [],
    );
  }

  /// `Basic data`
  String get basic_data {
    return Intl.message('Basic data', name: 'basic_data', desc: '', args: []);
  }

  /// `Total number of entries : `
  String get Total_number_of_entries {
    return Intl.message(
      'Total number of entries : ',
      name: 'Total_number_of_entries',
      desc: '',
      args: [],
    );
  }

  /// `Field is required`
  String get field_is_required {
    return Intl.message(
      'Field is required',
      name: 'field_is_required',
      desc: '',
      args: [],
    );
  }

  /// `sure`
  String get sure {
    return Intl.message('sure', name: 'sure', desc: '', args: []);
  }

  /// `It is not possible to modify more than one item.`
  String get massage_no_edit {
    return Intl.message(
      'It is not possible to modify more than one item.',
      name: 'massage_no_edit',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to confirm the deletion of the selected item?`
  String get massage_delete {
    return Intl.message(
      'Do you want to confirm the deletion of the selected item?',
      name: 'massage_delete',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get show_more {
    return Intl.message('Show more', name: 'show_more', desc: '', args: []);
  }

  /// `Show less`
  String get show_less {
    return Intl.message('Show less', name: 'show_less', desc: '', args: []);
  }

  /// `Clean`
  String get clean {
    return Intl.message('Clean', name: 'clean', desc: '', args: []);
  }

  /// `Didn't start`
  String get to_do {
    return Intl.message('Didn\'t start', name: 'to_do', desc: '', args: []);
  }

  /// `Work has begun on it`
  String get on_progress {
    return Intl.message(
      'Work has begun on it',
      name: 'on_progress',
      desc: '',
      args: [],
    );
  }

  /// `Under revision`
  String get under_revision {
    return Intl.message(
      'Under revision',
      name: 'under_revision',
      desc: '',
      args: [],
    );
  }

  /// `Reviewed`
  String get revision {
    return Intl.message('Reviewed', name: 'revision', desc: '', args: []);
  }

  /// `Description: `
  String get description_task {
    return Intl.message(
      'Description: ',
      name: 'description_task',
      desc: '',
      args: [],
    );
  }

  /// `Task: `
  String get task {
    return Intl.message('Task: ', name: 'task', desc: '', args: []);
  }

  /// `Start Date: `
  String get start_date {
    return Intl.message('Start Date: ', name: 'start_date', desc: '', args: []);
  }

  /// `End Date: `
  String get end_date {
    return Intl.message('End Date: ', name: 'end_date', desc: '', args: []);
  }

  /// `Please select a client.`
  String get select_client {
    return Intl.message(
      'Please select a client.',
      name: 'select_client',
      desc: '',
      args: [],
    );
  }

  /// `Date From: `
  String get date_from {
    return Intl.message('Date From: ', name: 'date_from', desc: '', args: []);
  }

  /// `Date To: `
  String get date_to {
    return Intl.message('Date To: ', name: 'date_to', desc: '', args: []);
  }

  /// `Show`
  String get show {
    return Intl.message('Show', name: 'show', desc: '', args: []);
  }

  /// `Product is not available.`
  String get product_not_available {
    return Intl.message(
      'Product is not available.',
      name: 'product_not_available',
      desc: '',
      args: [],
    );
  }

  /// `Choose Project`
  String get choose_project {
    return Intl.message(
      'Choose Project',
      name: 'choose_project',
      desc: '',
      args: [],
    );
  }

  /// `Distortions`
  String get tab1 {
    return Intl.message('Distortions', name: 'tab1', desc: '', args: []);
  }

  /// `Add-ons`
  String get tab2 {
    return Intl.message('Add-ons', name: 'tab2', desc: '', args: []);
  }

  /// `Deductions`
  String get tab3 {
    return Intl.message('Deductions', name: 'tab3', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message('Statistics', name: 'statistics', desc: '', args: []);
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Advance Balance`
  String get advance_balance {
    return Intl.message(
      'Advance Balance',
      name: 'advance_balance',
      desc: '',
      args: [],
    );
  }

  /// `Vacation Balance`
  String get vacation_balance {
    return Intl.message(
      'Vacation Balance',
      name: 'vacation_balance',
      desc: '',
      args: [],
    );
  }

  /// `Attendance Days`
  String get attendance_days {
    return Intl.message(
      'Attendance Days',
      name: 'attendance_days',
      desc: '',
      args: [],
    );
  }

  /// `Salary Items`
  String get salary_items {
    return Intl.message(
      'Salary Items',
      name: 'salary_items',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
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
