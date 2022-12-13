// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_manager/models/auth_status.dart';

class SafeKeys {
  SafeKeys._();

  static const String languageCode = 'languageCode';
  static const String english = 'en';
  static const String arabic = 'ar';

  static const String themeKey = 'themeKey';
  static const String isFirstRun = 'is_first_run';

  static const String token = 'elcom_token';
  static const String tokenExpireDate = 'elcom_token_expire';

  static const String onBoarding = 'elcom_onboarding';
}

class Safe {
  final SharedPreferences _storage;
  Safe({
    required SharedPreferences storage,
  }) : _storage = storage;

  // Localization
  Future<Locale> setLocal(String languageCode) async {
    await _storage.setString(SafeKeys.languageCode, languageCode);
    return _locale(languageCode);
  }

  Locale getLocal() {
    final languageCode =
        _storage.getString(SafeKeys.languageCode) ?? SafeKeys.english;
    return _locale(languageCode);
  }

  Locale _locale(String languageCode) {
    switch (languageCode) {
      case SafeKeys.english:
        return const Locale(SafeKeys.english, '');
      case SafeKeys.arabic:
        return const Locale(SafeKeys.arabic, '');
      default:
        return const Locale(SafeKeys.english, '');
    }
  }

  // Themeing
  Future<String> setThemeMode(String mode) async {
    await _storage.setString(SafeKeys.themeKey, mode);
    return mode;
  }

  ThemeMode getThemeMode() {
    final string = _storage.getString(SafeKeys.themeKey);
    if (string == null) {
      return ThemeMode.system;
    }
    if (string == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.light;
    }
  }

  bool get isFirstRun => _storage.getBool(SafeKeys.isFirstRun) ?? true;
  Future updateFirstRun() async {
    await _storage.setBool(SafeKeys.isFirstRun, false);
  }

  bool getOnBoardingStatus() {
    return _storage.getBool(SafeKeys.onBoarding) ?? false;
  }

  Future endOnBoardingStatus() async {
    await _storage.setBool(
        SafeKeys.onBoarding, true); //.getBool(SafeKeys.onBoarding) ?? false;
  }

  bool isAuthorized() {
    final token = _storage.getString(SafeKeys.token);
    return token != null;
  }

  AuthStatus getAuthStatus() {
    if (isAuthorized()) {
      return AuthStatus.home;
    } else {
      return AuthStatus.login;
    }
  }
}
