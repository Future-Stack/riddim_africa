import 'package:get/get.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/welcome_screen.dart';
import 'package:riddimafrica/features/onboarding/bindings/onboarding_binding.dart';
import 'package:riddimafrica/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:riddimafrica/features/authentication/bindings/auth_binding.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/UI/artist_bottom_nav.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/UI/seller_bottom_nav.dart';
import 'package:riddimafrica/features/roles/user/features/home/presentation/screens/home_screen.dart';
import 'package:riddimafrica/features/roles/user/features/home/bindings/home_binding.dart';
import 'package:riddimafrica/features/splash/bindings/splash_binding.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/UI/user_bottom_nav.dart';
import 'package:riddimafrica/features/splash/presentation/ui/splash_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/login_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/profile_setup_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/forgot_password_otp_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/create_new_password_screen.dart';

class AppRoute {
  static const String welcomescreen = "/welcomeScreen";
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/onboardingScreen";
  static const String loginScreen = "/loginScreen";
  static const String signupScreen = "/signupScreen";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String forgotPasswordOtpScreen = "/forgotPasswordOtpScreen";
  static const String createNewPasswordScreen = "/createNewPasswordScreen";

  //bottom navs
  static const String userbottomNav = "/userbottomNav";
  static const String artistbottomNav = "/artistbottomNav";
  static const String sellerbottomNav = "/sellerbottomNav";

  static const String internetlost = "/internetlost";
  static const String communityScreen = "/communityScreen";

  static String getwelcomescreen() => welcomescreen;
  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getUserBottomNavScreen() => userbottomNav;
  static String getArtistBottomNavScreen() => artistbottomNav;
  static String getSellerBottomNavScreen() => sellerbottomNav;

  //USER
  static String getUserhomescreen() => userhomescreen;

  //USER

  static const String userhomescreen = "/userhomescreen";

  static List<GetPage> routes = [
    GetPage(
      name: welcomescreen,
      page: () => const WelcomeScreen(),
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
    GetPage(
      name: userbottomNav,
      page: () => const UserBottomNav(),
      binding: HomeBinding(),
    ),
    GetPage(name: artistbottomNav, page: () => const ArtistBottomNav()),
    GetPage(name: sellerbottomNav, page: () => const SellerBottomNav()),
    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: signupScreen,
      page: () => const ProfileSetupScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: forgotPasswordOtpScreen,
      page: () => const ForgotPasswordOtpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: createNewPasswordScreen,
      page: () => const CreateNewPasswordScreen(),
      binding: AuthBinding(),
    ),

    //USER
    GetPage(
      name: userhomescreen,
      page: () => const UserHomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
