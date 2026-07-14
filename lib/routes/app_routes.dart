import 'package:get/get.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/login_screen.dart';
import 'package:riddimafrica/features/onboarding/bindings/onboarding_binding.dart';
import 'package:riddimafrica/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:riddimafrica/features/authentication/bindings/auth_binding.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/UI/artist_bottom_nav.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/UI/seller_bottom_nav.dart';
import 'package:riddimafrica/features/splash/bindings/splash_binding.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/UI/user_bottom_nav.dart';
import 'package:riddimafrica/features/splash/presentation/ui/splash_screen.dart';

class AppRoute {
  static const String loginScreen = "/loginScreen";
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/onboardingScreen";

  //bottom navs
  static const String userbottomNav = "/userbottomNav";
  static const String artistbottomNav = "/artistbottomNav";
  static const String sellerbottomNav = "/sellerbottomNav";

  static const String internetlost = "/internetlost";
  static const String communityScreen = "/communityScreen";

  static String getLoginScreen() => loginScreen;
  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getUserBottomNavScreen() => userbottomNav;
  static String getArtistBottomNavScreen() => artistbottomNav;
  static String getSellerBottomNavScreen() => sellerbottomNav;

  static List<GetPage> routes = [
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(name: userbottomNav, page: () => const UserBottomNav()),
    GetPage(name: artistbottomNav, page: () => const ArtistBottomNav()),
    GetPage(name: sellerbottomNav, page: () => const SellerBottomNav()),
  ];
}
