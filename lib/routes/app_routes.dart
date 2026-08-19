import 'package:get/get.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_home/bindings/artist_home_binding.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_home/bindings/seller_home_binding.dart';

import 'package:riddimafrica/features/authentication/presentation/screens/welcome_screen.dart';
import 'package:riddimafrica/features/onboarding/bindings/onboarding_binding.dart';
import 'package:riddimafrica/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:riddimafrica/features/authentication/bindings/auth_binding.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/UI/artist_bottom_nav.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/UI/seller_bottom_nav.dart';
import 'package:riddimafrica/features/roles/user/features/home/presentation/screens/home_screen.dart';
import 'package:riddimafrica/features/roles/user/features/home/presentation/screens/global_search.dart';
import 'package:riddimafrica/features/roles/user/features/home/bindings/home_binding.dart';
import 'package:riddimafrica/features/splash/bindings/splash_binding.dart';
import 'package:riddimafrica/features/bottom_nav/presentation/UI/user_bottom_nav.dart';
import 'package:riddimafrica/features/splash/presentation/ui/splash_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/login_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/profile_setup_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/forgot_password_otp_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/create_new_password_screen.dart';
import 'package:riddimafrica/features/roles/user/features/market/binding/market_binding.dart';
import 'package:riddimafrica/features/roles/user/features/market/presentation/screens/product_detail_screen.dart';
import 'package:riddimafrica/features/roles/user/features/market/presentation/screens/cart_screen.dart';
import 'package:riddimafrica/features/roles/user/features/market/presentation/screens/checkout_screen.dart';
import 'package:riddimafrica/features/roles/user/features/market/presentation/screens/artist_profile.dart';
import 'package:riddimafrica/features/roles/user/features/orders/bindings/order_binding.dart';
import 'package:riddimafrica/features/roles/user/features/orders/presentation/screens/order_list_screen.dart';
import 'package:riddimafrica/features/roles/user/features/orders/presentation/screens/order_detail_screen.dart';
import 'package:riddimafrica/features/roles/user/features/orders/presentation/screens/order_confirmed_screen.dart';
import 'package:riddimafrica/features/roles/user/features/orders/presentation/screens/order_review_screen.dart';
import 'package:riddimafrica/features/notification/bindings/notification_binding.dart';
import 'package:riddimafrica/features/notification/presentation/screens/notification_screen.dart';
import 'package:riddimafrica/features/roles/user/features/profile/binding/profile_binding.dart';
import 'package:riddimafrica/features/roles/user/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:riddimafrica/features/roles/user/features/profile/presentation/screens/wishlist_screen.dart';
import 'package:riddimafrica/features/roles/user/features/settings/binding/settings_binding.dart';
import 'package:riddimafrica/features/roles/user/features/settings/presentation/screens/settings_screen.dart';
import 'package:riddimafrica/features/roles/user/features/settings/presentation/screens/change_password_screen.dart';
import 'package:riddimafrica/features/roles/user/features/settings/presentation/screens/faq_screen.dart';
import 'package:riddimafrica/features/roles/user/features/settings/presentation/screens/privacy_policy_screen.dart';
import 'package:riddimafrica/features/roles/user/features/settings/presentation/screens/refund_policy_screen.dart';
import 'package:riddimafrica/features/roles/user/features/settings/presentation/screens/cookie_notice_screen.dart';
import 'package:riddimafrica/features/roles/user/features/settings/presentation/screens/community_guidelines_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_id_verification_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_business_type_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_payment_method_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_document_form_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_id_photo_upload_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_business_details_screen.dart';

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

  // Seller registration flow (new multi-step)
  static const String sellerIdVerificationScreen = "/sellerIdVerificationScreen";
  static const String sellerBusinessTypeScreen = "/sellerBusinessTypeScreen";
  static const String sellerPaymentMethodScreen = "/sellerPaymentMethodScreen";
  static const String sellerDocumentFormScreen = "/sellerDocumentFormScreen";
  static const String sellerIdPhotoUploadScreen = "/sellerIdPhotoUploadScreen";
  static const String sellerBusinessDetailsScreen = "/sellerBusinessDetailsScreen";

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
  static const String globalSearch = "/globalSearch";
  static const String marketProductDetail = "/marketProductDetail";
  static const String marketCart = "/marketCart";
  static const String marketCheckout = "/marketCheckout";
  static const String artistProfile = "/artistProfile";
  static const String notifications = "/notifications";

  // PROFILE & SETTINGS
  static const String editProfile = "/editProfile";
  static const String wishlist = "/wishlist";
  static const String settings = "/settings";
  static const String changePassword = "/changePassword";
  static const String faq = "/faq";
  static const String privacyPolicy = "/privacyPolicy";
  static const String refundPolicy = "/refundPolicy";
  static const String cookieNotice = "/cookieNotice";
  static const String communityGuidelines = "/communityGuidelines";

  //ORDERS
  static const String orderList = "/orderList";
  static const String orderDetail = "/orderDetail";
  static const String orderConfirmed = "/orderConfirmed";
  static const String orderReview = "/orderReview";

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
    GetPage(
      name: artistbottomNav,
      page: () => const ArtistBottomNav(),
      binding: ArtistHomeBinding(),
    ),
    GetPage(
      name: sellerbottomNav,
      page: () => const SellerBottomNav(),
      binding: SellerHomeBinding(),
    ),
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
    // Seller registration flow (full multi-step)
    GetPage(
      name: sellerIdVerificationScreen,
      page: () => const SellerIdVerificationScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: sellerBusinessTypeScreen,
      page: () => const SellerBusinessTypeScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: sellerPaymentMethodScreen,
      page: () => const SellerPaymentMethodScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: sellerDocumentFormScreen,
      page: () => const SellerDocumentFormScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: sellerIdPhotoUploadScreen,
      page: () {
        int docType = 0;
        bool isDocument = false;
        if (Get.arguments is Map) {
          docType = Get.arguments['docType'] ?? 0;
          isDocument = Get.arguments['isDocument'] ?? false;
        } else if (Get.arguments is int) {
          final int step = Get.arguments as int;
          if (step == 0) {
            docType = 0;
            isDocument = false;
          } else if (step == 1) {
            docType = 1;
            isDocument = false;
          } else {
            docType = 1;
            isDocument = true;
          }
        }
        return SellerIdPhotoUploadScreen(
          docType: docType,
          isDocumentUpload: isDocument,
        );
      },
      binding: AuthBinding(),
    ),
    GetPage(
      name: sellerBusinessDetailsScreen,
      page: () => const SellerBusinessDetailsScreen(),
      binding: AuthBinding(),
    ),

    //USER
    GetPage(
      name: userhomescreen,
      page: () => const UserHomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: globalSearch,
      page: () => const GlobalSearchScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: marketProductDetail,
      page: () => const ProductDetailScreen(),
      binding: MarketBinding(),
    ),
    GetPage(
      name: marketCart,
      page: () => const CartScreen(),
      binding: MarketBinding(),
    ),
    GetPage(
      name: marketCheckout,
      page: () => const CheckoutScreen(),
      binding: MarketBinding(),
    ),
    GetPage(
      name: artistProfile,
      page: () => const ArtistProfileScreen(),
      binding: MarketBinding(),
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),

    //ORDERS
    GetPage(
      name: orderList,
      page: () => const OrderListScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: orderDetail,
      page: () => const OrderDetailScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: orderConfirmed,
      page: () => const OrderConfirmedScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: orderReview,
      page: () => const OrderReviewScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: wishlist,
      page: () => const WishlistScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: faq,
      page: () => const FaqScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: privacyPolicy,
      page: () => const PrivacyPolicyScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: refundPolicy,
      page: () => const RefundPolicyScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: cookieNotice,
      page: () => const CookieNoticeScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: communityGuidelines,
      page: () => const CommunityGuidelinesScreen(),
      binding: SettingsBinding(),
    ),
  ];
}
