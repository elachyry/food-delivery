import 'package:flutter/material.dart';

import '../controllers/language_controller.dart';
import '../models/language.dart';
import '../utils/constants/language_constants.dart';

class LanguageItem extends StatelessWidget {
  final Language language;
  final LocalizationController localizationController;
  final int index;

  const LanguageItem({
    super.key,
    required this.language,
    required this.localizationController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        localizationController.setLanguage(
          Locale(AppConstants.languages[index].languageCode,
              AppConstants.languages[index].countryCode),
        );
        localizationController.setSelectedIndex(index);
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: localizationController.selectedIndex == index
              ? Theme.of(context).primaryColorLight
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200] as Color,
                blurRadius: 5,
                spreadRadius: 1),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 80,
                    margin: const EdgeInsets.all(9),
                    child: Image.asset(
                      'assets/images/languages_flags/${language.imageUrl}',
                      width: 80,
                    ),
                  ),
                  Text(
                    language.languageName,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: language.languageName == 'العربية'
                          ? 'Almarai'
                          : 'VarelaRound',
                    ),
                  ),
                ],
              ),
            ),
            // localizationController.selectedIndex == index
            //     ? Positioned(
            //         top: 0,
            //         right: 0,
            //         left: 0,
            //         bottom: 50,
            //         child: Icon(
            //           Icons.check_circle,
            //           color: Theme.of(context).primaryColor,
            //           size: 30,
            //         ),
            //       )
            //     : const SizedBox()
          ],
        ),
      ),
    );
  }
}
