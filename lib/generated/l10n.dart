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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `beatbetter`
  String get title {
    return Intl.message('beatbetter', name: 'title', desc: '', args: []);
  }

  /// `Flutter app for self-improvement and motivation`
  String get description {
    return Intl.message(
      'Flutter app for self-improvement and motivation',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get auth_sign_in_title {
    return Intl.message(
      'Welcome',
      name: 'auth_sign_in_title',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get auth_sign_in_email_label {
    return Intl.message(
      'Email',
      name: 'auth_sign_in_email_label',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get auth_sign_in_password_label {
    return Intl.message(
      'Password',
      name: 'auth_sign_in_password_label',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get auth_sign_in_button {
    return Intl.message(
      'Login',
      name: 'auth_sign_in_button',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get auth_sign_in_forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'auth_sign_in_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get auth_sign_in_dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'auth_sign_in_dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Or sign in with`
  String get auth_sign_in_social {
    return Intl.message(
      'Or sign in with',
      name: 'auth_sign_in_social',
      desc: '',
      args: [],
    );
  }

  /// `Create one.`
  String get auth_sign_int_create_account {
    return Intl.message(
      'Create one.',
      name: 'auth_sign_int_create_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get auth_sign_up_button {
    return Intl.message(
      'Sign Up',
      name: 'auth_sign_up_button',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get auth_sign_up_title {
    return Intl.message(
      'Create an account',
      name: 'auth_sign_up_title',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get auth_sign_up_email_label {
    return Intl.message(
      'Email',
      name: 'auth_sign_up_email_label',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get auth_sign_up_password_label {
    return Intl.message(
      'Password',
      name: 'auth_sign_up_password_label',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get auth_sign_up_password_confirm_label {
    return Intl.message(
      'Confirm Password',
      name: 'auth_sign_up_password_confirm_label',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get auth_sign_up_submit_button {
    return Intl.message(
      'Sign Up',
      name: 'auth_sign_up_submit_button',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get auth_sign_up_already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'auth_sign_up_already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get auth_sign_up_login {
    return Intl.message(
      'Log In',
      name: 'auth_sign_up_login',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
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
