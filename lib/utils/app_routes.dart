import 'package:get/get.dart';
import 'package:multi_languges/screens/dashboard/tab_screen.dart';
import 'package:multi_languges/screens/orders/orders_screen.dart';

import '../screens/auth/phone_number_screen.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/filter/filter_screen.dart';
import '../screens/location/location_screen.dart';
import '../screens/meal_details/meal_details_screen.dart';
import '../screens/restaurant_details/restaurant_details_screen.dart';
import '../screens/restaurant_listing/restaurant_listing_screen.dart';
import '../screens/auth/forgot_password/forgot_password_email_screen.dart';
import '../screens/dashboard/dashbord_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/on_boarding_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/language_selection_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/otp_phone_number_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRoutes {
  static const String _initialScreen = '/';
  static const String _splashScreen = '/spash';
  static const String _selectLanguageScreen = '/select-language';
  static const String _welecomeScreen = '/welcome';
  static const String _onBoardingScreen = '/on-boarding';
  static const String _signinScreen = '/signin';
  static const String _signupScreen = '/signup';
  static const String _restPasswordEmailScreen = '/restPassword-email';
  static const String _restPasswordPhoneNumberScreen =
      '/restPassword-phoneNumber';
  static const String _forgotPasswordOtpEmailScreen =
      '/forgot-password-email-otp';
  static const String _otpPhoneNumberScreen = '/otp-phoneNumber';
  static const String _dashboardScreen = '/dashboard';
  static const String _phoneNumberScreen = '/phone-number';
  static const String _profileScreen = '/profile';
  static const String _editProfileScreen = '/edit-profile';
  static const String _forgotPasswordOtpPhoneScreen =
      '/forgot-password-phone-otp';

  static const String _cartScreen = '/cart';
  static const String _checkoutScreen = '/checkout';
  static const String _locationScreen = '/location';
  static const String _filterScreen = '/filter';
  static const String _restaurantListingScreen = '/restaurant-listing';
  static const String _restaurantDetailsScreen = '/restaurant-details';
  static const String _tabsScreen = '/tabs';
  static const String _mealDetailsScreen = '/meal-details';

  static const String _ordersScreen = '/orders';

  static String get initialRoute => _initialScreen;
  static String get splashScreenRoute => _splashScreen;
  static String get selectLanguageScreenRoute => _selectLanguageScreen;
  static String get welecomeScreenRoute => _welecomeScreen;
  static String get onBoardingScreenRoute => _onBoardingScreen;
  static String get signinScreenRoute => _signinScreen;
  static String get signupScreenRoute => _signupScreen;
  static String get restPasswordEmailScreenRoute => _restPasswordEmailScreen;
  static String get restPasswordPhoneNumberScreenRoute =>
      _restPasswordPhoneNumberScreen;
  static String get otpEmailScreenRoute => _forgotPasswordOtpEmailScreen;
  static String get otpPhoneNumberScreenRoute => _otpPhoneNumberScreen;
  static String get dashboardScreenRoute => _dashboardScreen;
  static String get phoneNumberScreenRoute => _phoneNumberScreen;
  static String get profileScreenRoute => _profileScreen;
  static String get editProfileScreenRoute => _editProfileScreen;
  static String get forgotPasswordOtpPhoneScreenRoute =>
      _forgotPasswordOtpPhoneScreen;

  static String get cartScreenRoute => _cartScreen;
  static String get checkoutScreenRoute => _checkoutScreen;
  static String get locationScreenRoute => _locationScreen;
  static String get filterScreenRoute => _filterScreen;
  static String get restaurantListingScreenRoute => _restaurantListingScreen;
  static String get restaurantDetailsScreenRoute => _restaurantDetailsScreen;
  static String get tabsScreenRoute => _tabsScreen;
  static String get mealDetailsScreenRoute => _mealDetailsScreen;

  static String get ordersScreenRoute => _ordersScreen;

  static List<GetPage> routes = [
    GetPage(
      name: _splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _welecomeScreen,
      page: () => const WelcomScreen(),
    ),
    GetPage(
      name: _selectLanguageScreen,
      page: () => LanguageSelectionScreen(firstTime: true),
    ),
    GetPage(
      name: _onBoardingScreen,
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: _signinScreen,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: _signupScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: _restPasswordEmailScreen,
      page: () => ForgotPasswordEmailScreen(),
    ),
    // GetPage(
    //   name: _restPasswordPhoneNumberScreen,
    //   page: () => ForgotPasswordPhoneNumberScreen(),
    // ),
    // GetPage(
    //   name: _forgotPasswordOtpEmailScreen,
    //   page: () => const ForgotPasswordOtpEmailScreen(),
    // ),
    // GetPage(
    //   name: _forgotPasswordOtpPhoneScreen,
    //   page: () => ForgotPasswordOtpPhoneScreen(),
    // ),
    GetPage(
      name: otpPhoneNumberScreenRoute,
      page: () => const OtpPhoneNumberScreen(),
    ),
    GetPage(
      name: _dashboardScreen,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: _phoneNumberScreen,
      page: () => PhoneNumberScreen(),
    ),
    GetPage(
      name: _profileScreen,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: _editProfileScreen,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: _cartScreen,
      page: () => CartScreen(),
    ),
    GetPage(
      name: _filterScreen,
      page: () => const FilterScreen(),
    ),
    GetPage(
      name: _locationScreen,
      page: () => const LocationScreen(),
    ),
    // GetPage(
    //   name: _checkoutScreen,
    //   page: () => const CheckoutScreen(total: 0),
    // ),
    GetPage(
      name: _restaurantDetailsScreen,
      page: () => const RestaurantDetailsScreen(restaurant: null),
    ),
    GetPage(
      name: _restaurantListingScreen,
      page: () => RestaurantListingScreen(
        restaurants: const [],
      ),
    ),
    GetPage(
      name: _tabsScreen,
      page: () => TabScreen(),
    ),
    GetPage(
      name: _ordersScreen,
      page: () => const OrdersScreen(),
    ),
    GetPage(
      name: _mealDetailsScreen,
      page: () => const MealDetailsScreen(
        menuItem: null,
        restaurant: null,
      ),
    ),
  ];
}
