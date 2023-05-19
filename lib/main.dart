import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:multi_languges/blocs/cart/cart_bloc.dart';
import 'package:multi_languges/blocs/coupon/coupon_bloc.dart';
import 'package:multi_languges/blocs/filters/filters_bloc.dart';
import 'package:multi_languges/blocs/place/place_bloc.dart';
import 'package:multi_languges/repositories/coupon/coupon_repository.dart';
import 'controllers/cart_controller.dart';
import 'firebase_options.dart';

import './blocs/autocomplete/autocomplete_bloc.dart';
import './blocs/geolocation/geolocation_bloc.dart';
import './repositories/geolocation/geolocation_repository.dart';
import './repositories/place/place_repository.dart';
import './controllers/auth/auth_controller.dart';
import './utils/constants/language_constants.dart';
import './controllers/language_controller.dart';
import './utils/messages.dart';
import './utils/dep.dart' as dep;
import '../utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
    Get.put(CartController());
  });
  final Map<String, Map<String, String>> languages = await dep.init();

  runApp(MyApp(
    languages: languages,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;

  const MyApp({super.key, required this.languages});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (controller) {
      return bloc.MultiRepositoryProvider(
        providers: [
          bloc.RepositoryProvider<GeolocationRepository>(
            create: (context) => GeolocationRepository(),
          ),
          bloc.RepositoryProvider<PlaceRepository>(
            create: (context) => PlaceRepository(),
          ),
        ],
        child: bloc.MultiBlocProvider(
          providers: [
            bloc.BlocProvider(
              create: (context) => GeolocationBloc(
                  geolocationRepository: context.read<GeolocationRepository>())
                ..add(LoadGeolocation()),
            ),
            bloc.BlocProvider(
              create: (context) => AutocompleteBloc(
                  placeRepository: context.read<PlaceRepository>())
                ..add(const LoadAutocomplete()),
            ),
            bloc.BlocProvider(
              create: (context) => PlaceBloc(
                placeRepository: context.read<PlaceRepository>(),
              ),
            ),
            bloc.BlocProvider(
              create: (context) => FiltersBloc()..add(FilterLoad()),
            ),
            bloc.BlocProvider(
              create: (context) => CouponBloc(couponRepo: CouponRepository())
                ..add(LoadCoupons()),
            ),
            bloc.BlocProvider(
              create: (context) => CartBloc(
                  couponBloc: bloc.BlocProvider.of<CouponBloc>(context))
                ..add(StartCart()),
            ),
          ],
          child: GetMaterialApp(
            title: 'Food Express',
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: const MaterialColor(
                0xFFEC121D,
                <int, Color>{
                  50: Color(0x1AEC121D),
                  100: Color(0x33EC121D),
                  200: Color(0x4DEC121D),
                  300: Color(0x66EC121D),
                  400: Color(0x80EC121D),
                  500: Color(0xFFEC121D),
                  600: Color(0x99EC121D),
                  700: Color(0xB3EC121D),
                  800: Color(0xCCEC121D),
                  900: Color(0xE6EC121D),
                },
              ),
              // accentColor: Colors.yellow.shade700,
              fontFamily:
                  controller.selectedIndex == 2 ? 'Almarai' : 'VarelaRound',
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            themeMode: ThemeMode.light,
            locale: controller.locale,
            defaultTransition: Transition.native,
            transitionDuration: const Duration(milliseconds: 500),
            translations: Messages(languages: languages),
            initialRoute: AppRoutes.splashScreenRoute,
            fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode),
            getPages: AppRoutes.routes,
            // home: const SplashScreen(),
          ),
        ),
      );
    });
  }
}
