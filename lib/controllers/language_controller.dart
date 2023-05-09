import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/language.dart';
import '../utils/constants/language_constants.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({
    required this.sharedPreferences,
  }) {
    loadCurrentLanguages();
  }

  Locale _locale = Locale(
    AppConstants.languages[0].languageCode,
    AppConstants.languages[0].countryCode,
  );

  int _selectedIndex = 0;

  List<Language> _languages = [];

  int get selectedIndex {
    return _selectedIndex;
  }

  Locale get locale {
    return _locale;
  }

  List<Language> get languages {
    return _languages;
  }

  void loadCurrentLanguages() async {
    _locale = Locale(
      sharedPreferences.getString(AppConstants.Language_code) ??
          AppConstants.languages[0].languageCode,
      sharedPreferences.getString(AppConstants.Country_Code) ??
          AppConstants.languages[0].countryCode,
    );

    for (int i = 0; i < AppConstants.languages.length; i++) {
      if (AppConstants.languages[i].languageCode == _locale.languageCode) {
        _selectedIndex = i;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(
        AppConstants.Language_code, locale.languageCode);
    sharedPreferences.setString(AppConstants.Country_Code, locale.countryCode!);
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    update();
  }
}
