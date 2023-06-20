import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/language_controller.dart';
import 'package:food_delivery_express/models/language.dart';
import 'package:food_delivery_express/utils/constants/language_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(
    () => LocalizationController(
      sharedPreferences: Get.find(),
    ),
  );

  Map<String, Map<String, String>> _languages = Map();
  for (Language language in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/languages/${language.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};

    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });

    _languages['${language.languageCode}_${language.countryCode}'] = json;
  }
  return _languages;
}
