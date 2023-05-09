import '../../models/language.dart';

class AppConstants {
  static const Country_Code = 'Country_Code';
  static const Language_code = 'Language_code';

  static List<Language> languages = [
    Language(
      imageUrl: 'en.png',
      countryCode: 'US',
      languageCode: 'en',
      languageName: 'English',
    ),
    Language(
      imageUrl: 'fr.png',
      countryCode: 'FR',
      languageCode: 'fr',
      languageName: 'French',
    ),
    Language(
      imageUrl: 'ar.png',
      countryCode: 'AR',
      languageCode: 'ar',
      languageName: 'العربية',
    ),
    Language(
      imageUrl: 'es.png',
      countryCode: 'ES',
      languageCode: 'es',
      languageName: 'Spanish',
    ),
  ];
}
