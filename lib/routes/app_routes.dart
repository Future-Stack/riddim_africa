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
import 'package:riddimafrica/features/authentication/presentation/screens/verify_otp_screen.dart';
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
import 'package:riddimafrica/features/roles/user/features/settings/presentation/screens/delete_account_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_id_verification_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_business_type_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_payment_method_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_document_form_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_id_photo_upload_screen.dart';
import 'package:riddimafrica/features/authentication/presentation/screens/seller_business_details_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_products/bindings/seller_products_binding.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_products/presentation/screens/seller_products_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_products/presentation/screens/submit_product_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_products/presentation/screens/seller_live_product_detail_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_products/presentation/screens/seller_review_tracking_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_products/presentation/screens/seller_rejected_product_detail_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_products/presentation/screens/seller_admin_chat_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/bindings/seller_orders_binding.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/presentation/screens/seller_orders_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/presentation/screens/seller_new_order_alert_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/presentation/screens/seller_order_shipment_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/presentation/screens/seller_order_tracking_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/presentation/screens/seller_order_completed_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/presentation/screens/seller_order_cancelled_detail_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_orders/data/models/seller_order_model.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_revenue/bindings/seller_revenue_binding.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_revenue/presentation/screens/seller_revenue_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_revenue/presentation/screens/seller_revenue_transactions_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_revenue/presentation/screens/seller_request_payment_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_revenue/presentation/screens/seller_payment_details_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_revenue/presentation/screens/seller_payout_detail_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_revenue/data/models/seller_revenue_model.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/bindings/seller_profile_binding.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_profile_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_edit_profile_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_verification_badge_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_documents_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_document_detail_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_review_ratings_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_profile_payment_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_support_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_live_chat_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_settings_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_notification_settings_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_change_password_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_refund_policy_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_community_guidelines_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_privacy_policy_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_cookie_notice_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/presentation/screens/seller_delete_account_screen.dart';
import 'package:riddimafrica/features/roles/seller/features/seller_profile/data/models/seller_document_model.dart';


import 'package:riddimafrica/features/roles/artist/features/artist_products/bindings/artist_products_binding.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_products/presentation/screens/artist_products_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_products/presentation/screens/submit_product_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_products/presentation/screens/artist_live_product_detail_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_products/presentation/screens/artist_review_tracking_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_products/presentation/screens/artist_rejected_product_detail_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_products/presentation/screens/artist_admin_chat_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_orders/bindings/artist_orders_binding.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_orders/presentation/screens/artist_orders_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_orders/presentation/screens/artist_new_order_alert_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_orders/presentation/screens/artist_order_shipment_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_orders/presentation/screens/artist_order_tracking_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_orders/presentation/screens/artist_order_completed_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_orders/presentation/screens/artist_order_cancelled_detail_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_orders/data/models/artist_order_model.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_revenue/bindings/artist_revenue_binding.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_revenue/presentation/screens/artist_revenue_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_revenue/presentation/screens/artist_revenue_transactions_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_revenue/presentation/screens/artist_request_payment_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_revenue/presentation/screens/artist_payment_details_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_revenue/presentation/screens/artist_payout_detail_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_revenue/data/models/artist_revenue_model.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/bindings/artist_profile_binding.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_profile_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_edit_profile_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_verification_badge_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_documents_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_document_detail_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_review_ratings_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_profile_payment_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_support_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_live_chat_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_settings_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_notification_settings_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_change_password_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_refund_policy_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_community_guidelines_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_privacy_policy_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_cookie_notice_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/presentation/screens/artist_delete_account_screen.dart';
import 'package:riddimafrica/features/roles/artist/features/artist_profile/data/models/artist_document_model.dart';

class AppRoute {
  static const String welcomescreen = "/welcomeScreen";
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/onboardingScreen";
  static const String loginScreen = "/loginScreen";
  static const String signupScreen = "/signupScreen";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String forgotPasswordOtpScreen = "/forgotPasswordOtpScreen";
  static const String verifyOtpScreen = "/verifyOtpScreen";
  static const String createNewPasswordScreen = "/createNewPasswordScreen";

  //bottom navs
  static const String userbottomNav = "/userbottomNav";
  static const String artistbottomNav = "/artistbottomNav";
  static const String sellerbottomNav = "/sellerbottomNav";

  // Artist Products & Submission flow
  static const String artistProducts = "/artistProducts";
  static const String artistSubmitProduct = "/artistSubmitProduct";
  static const String artistLiveProductDetail = "/artistLiveProductDetail";
  static const String artistReviewTracking = "/artistReviewTracking";
  static const String artistRejectedProductDetail = "/artistRejectedProductDetail";
  static const String artistAdminChat = "/artistAdminChat";

  // Artist Orders flow
  static const String artistOrders = "/artistOrders";
  static const String artistNewOrderAlert = "/artistNewOrderAlert";
  static const String artistOrderShipment = "/artistOrderShipment";
  static const String artistOrderTracking = "/artistOrderTracking";
  static const String artistOrderCompleted = "/artistOrderCompleted";
  static const String artistOrderCancelledDetail = "/artistOrderCancelledDetail";

  // Artist Revenue flow
  static const String artistRevenue = "/artistRevenue";
  static const String artistRevenueTransactions = "/artistRevenueTransactions";
  static const String artistRequestPayment = "/artistRequestPayment";
  static const String artistPaymentDetails = "/artistPaymentDetails";
  static const String artistPayoutDetail = "/artistPayoutDetail";

  // Artist Profile & Settings flow
  static const String artistProfileRole = "/artistProfileRole";
  static const String artistEditProfile = "/artistEditProfile";
  static const String artistVerificationBadge = "/artistVerificationBadge";
  static const String artistDocuments = "/artistDocuments";
  static const String artistDocumentDetail = "/artistDocumentDetail";
  static const String artistReviewRatings = "/artistReviewRatings";
  static const String artistProfilePayment = "/artistProfilePayment";
  static const String artistSupport = "/artistSupport";
  static const String artistLiveChat = "/artistLiveChat";
  static const String artistSettings = "/artistSettings";
  static const String artistNotificationSettings = "/artistNotificationSettings";
  static const String artistChangePassword = "/artistChangePassword";
  static const String artistRefundPolicy = "/artistRefundPolicy";
  static const String artistCommunityGuidelines = "/artistCommunityGuidelines";
  static const String artistPrivacyPolicy = "/artistPrivacyPolicy";
  static const String artistCookieNotice = "/artistCookieNotice";
  static const String artistDeleteAccount = "/artistDeleteAccount";


  // Seller registration flow (new multi-step)
  static const String sellerIdVerificationScreen = "/sellerIdVerificationScreen";
  static const String sellerBusinessTypeScreen = "/sellerBusinessTypeScreen";
  static const String sellerPaymentMethodScreen = "/sellerPaymentMethodScreen";
  static const String sellerDocumentFormScreen = "/sellerDocumentFormScreen";
  static const String sellerIdPhotoUploadScreen = "/sellerIdPhotoUploadScreen";
  static const String sellerBusinessDetailsScreen = "/sellerBusinessDetailsScreen";

  // Seller Products & Submission flow
  static const String sellerProducts = "/sellerProducts";
  static const String sellerSubmitProduct = "/sellerSubmitProduct";
  static const String sellerLiveProductDetail = "/sellerLiveProductDetail";
  static const String sellerReviewTracking = "/sellerReviewTracking";
  static const String sellerRejectedProductDetail = "/sellerRejectedProductDetail";
  static const String sellerAdminChat = "/sellerAdminChat";

  // Seller Orders flow
  static const String sellerOrders = "/sellerOrders";
  static const String sellerNewOrderAlert = "/sellerNewOrderAlert";
  static const String sellerOrderShipment = "/sellerOrderShipment";
  static const String sellerOrderTracking = "/sellerOrderTracking";
  static const String sellerOrderCompleted = "/sellerOrderCompleted";
  static const String sellerOrderCancelledDetail = "/sellerOrderCancelledDetail";

  // Seller Revenue flow
  static const String sellerRevenue = "/sellerRevenue";
  static const String sellerRevenueTransactions = "/sellerRevenueTransactions";
  static const String sellerRequestPayment = "/sellerRequestPayment";
  static const String sellerPaymentDetails = "/sellerPaymentDetails";
  static const String sellerPayoutDetail = "/sellerPayoutDetail";

  // Seller Profile & Settings flow
  static const String sellerProfile = "/sellerProfile";
  static const String sellerEditProfile = "/sellerEditProfile";
  static const String sellerVerificationBadge = "/sellerVerificationBadge";
  static const String sellerDocuments = "/sellerDocuments";
  static const String sellerDocumentDetail = "/sellerDocumentDetail";
  static const String sellerReviewRatings = "/sellerReviewRatings";
  static const String sellerProfilePayment = "/sellerProfilePayment";
  static const String sellerSupport = "/sellerSupport";
  static const String sellerLiveChat = "/sellerLiveChat";
  static const String sellerSettings = "/sellerSettings";
  static const String sellerNotificationSettings = "/sellerNotificationSettings";
  static const String sellerChangePassword = "/sellerChangePassword";
  static const String sellerRefundPolicy = "/sellerRefundPolicy";
  static const String sellerCommunityGuidelines = "/sellerCommunityGuidelines";
  static const String sellerPrivacyPolicy = "/sellerPrivacyPolicy";
  static const String sellerCookieNotice = "/sellerCookieNotice";
  static const String sellerDeleteAccount = "/sellerDeleteAccount";

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
  static const String deleteAccount = "/deleteAccount";

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
      name: verifyOtpScreen,
      page: () => const VerifyOtpScreen(),
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


    // Artist Products & Submission flow
    GetPage(
      name: artistProducts,
      page: () => const ArtistProductsScreen(),
      binding: ArtistProductsBinding(),
    ),
    GetPage(
      name: artistSubmitProduct,
      page: () => const ArtistSubmitProductScreen(),
      binding: ArtistProductsBinding(),
    ),
    GetPage(
      name: artistLiveProductDetail,
      page: () => const ArtistLiveProductDetailScreen(),
      binding: ArtistProductsBinding(),
    ),
    GetPage(
      name: artistReviewTracking,
      page: () => const ArtistReviewTrackingScreen(),
      binding: ArtistProductsBinding(),
    ),
    GetPage(
      name: artistRejectedProductDetail,
      page: () => const ArtistRejectedProductDetailScreen(),
      binding: ArtistProductsBinding(),
    ),
    GetPage(
      name: artistAdminChat,
      page: () => const ArtistAdminChatScreen(),
      binding: ArtistProductsBinding(),
    ),

    // Artist Orders flow
    GetPage(
      name: artistOrders,
      page: () => const ArtistOrdersScreen(),
      binding: ArtistOrdersBinding(),
    ),
    GetPage(
      name: artistNewOrderAlert,
      page: () {
        final order = Get.arguments as ArtistOrderModel? ??
            ArtistOrderModel.getInitialOrders().first;
        return ArtistNewOrderAlertScreen(order: order);
      },
      binding: ArtistOrdersBinding(),
    ),
    GetPage(
      name: artistOrderShipment,
      page: () {
        final order = Get.arguments as ArtistOrderModel? ??
            ArtistOrderModel.getInitialOrders().first;
        return ArtistOrderShipmentScreen(order: order);
      },
      binding: ArtistOrdersBinding(),
    ),
    GetPage(
      name: artistOrderTracking,
      page: () {
        final order = Get.arguments as ArtistOrderModel? ??
            ArtistOrderModel.getInitialOrders().first;
        return ArtistOrderTrackingScreen(order: order);
      },
      binding: ArtistOrdersBinding(),
    ),
    GetPage(
      name: artistOrderCompleted,
      page: () {
        final order = Get.arguments as ArtistOrderModel? ??
            ArtistOrderModel.getInitialOrders().firstWhere(
              (o) => o.status == ArtistOrderStatus.delivered,
              orElse: () => ArtistOrderModel.getInitialOrders().first,
            );
        return ArtistOrderCompletedScreen(order: order);
      },
      binding: ArtistOrdersBinding(),
    ),
    GetPage(
      name: artistOrderCancelledDetail,
      page: () {
        final order = Get.arguments as ArtistOrderModel? ??
            ArtistOrderModel.getInitialOrders().firstWhere(
              (o) => o.status == ArtistOrderStatus.cancelled,
              orElse: () => ArtistOrderModel.getInitialOrders().first,
            );
        return ArtistOrderCancelledDetailScreen(order: order);
      },
      binding: ArtistOrdersBinding(),
    ),

    // Artist Revenue flow
    GetPage(
      name: artistRevenue,
      page: () => const ArtistRevenueScreen(),
      binding: ArtistRevenueBinding(),
    ),
    GetPage(
      name: artistRevenueTransactions,
      page: () => const ArtistRevenueTransactionsScreen(),
      binding: ArtistRevenueBinding(),
    ),
    GetPage(
      name: artistRequestPayment,
      page: () => const ArtistRequestPaymentScreen(),
      binding: ArtistRevenueBinding(),
    ),
    GetPage(
      name: artistPaymentDetails,
      page: () {
        final tx = Get.arguments as ArtistTransactionModel? ??
            ArtistTransactionModel.getInitialTransactions().firstWhere(
              (t) => t.status == ArtistTransactionStatus.settled,
              orElse: () => ArtistTransactionModel.getInitialTransactions().first,
            );
        return ArtistPaymentDetailsScreen(transaction: tx);
      },
      binding: ArtistRevenueBinding(),
    ),
    GetPage(
      name: artistPayoutDetail,
      page: () {
        final tx = Get.arguments as ArtistTransactionModel? ??
            ArtistTransactionModel.getInitialTransactions().firstWhere(
              (t) => t.status == ArtistTransactionStatus.inProgress,
              orElse: () => ArtistTransactionModel.getInitialTransactions().first,
            );
        return ArtistPayoutDetailScreen(transaction: tx);
      },
      binding: ArtistRevenueBinding(),
    ),

    // Artist Profile & Settings flow
    GetPage(
      name: artistProfileRole,
      page: () => const ArtistProfileScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistEditProfile,
      page: () => const ArtistEditProfileScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistVerificationBadge,
      page: () => const ArtistVerificationBadgeScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistDocuments,
      page: () => const ArtistDocumentsScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistDocumentDetail,
      page: () {
        final doc = Get.arguments as ArtistDocumentModel? ??
            ArtistDocumentModel.mockDocuments.first;
        return ArtistDocumentDetailScreen(document: doc);
      },
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistReviewRatings,
      page: () => const ArtistReviewRatingsScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistProfilePayment,
      page: () => const ArtistProfilePaymentScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistSupport,
      page: () => const ArtistSupportScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistLiveChat,
      page: () => const ArtistLiveChatScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistSettings,
      page: () => const ArtistSettingsScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistNotificationSettings,
      page: () => const ArtistNotificationSettingsScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistChangePassword,
      page: () => const ArtistChangePasswordScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistRefundPolicy,
      page: () => const ArtistRefundPolicyScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistCommunityGuidelines,
      page: () => const ArtistCommunityGuidelinesScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistPrivacyPolicy,
      page: () => const ArtistPrivacyPolicyScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistCookieNotice,
      page: () => const ArtistCookieNoticeScreen(),
      binding: ArtistProfileBinding(),
    ),
    GetPage(
      name: artistDeleteAccount,
      page: () => const ArtistDeleteAccountScreen(),
      binding: ArtistProfileBinding(),
    ),

    // Seller Products & Submission flow
    GetPage(
      name: sellerProducts,
      page: () => const SellerProductsScreen(),
      binding: SellerProductsBinding(),
    ),
    GetPage(
      name: sellerSubmitProduct,
      page: () => const SellerSubmitProductScreen(),
      binding: SellerProductsBinding(),
    ),
    GetPage(
      name: sellerLiveProductDetail,
      page: () => const SellerLiveProductDetailScreen(),
      binding: SellerProductsBinding(),
    ),
    GetPage(
      name: sellerReviewTracking,
      page: () => const SellerReviewTrackingScreen(),
      binding: SellerProductsBinding(),
    ),
    GetPage(
      name: sellerRejectedProductDetail,
      page: () => const SellerRejectedProductDetailScreen(),
      binding: SellerProductsBinding(),
    ),
    GetPage(
      name: sellerAdminChat,
      page: () => const SellerAdminChatScreen(),
      binding: SellerProductsBinding(),
    ),

    // Seller Orders flow
    GetPage(
      name: sellerOrders,
      page: () => const SellerOrdersScreen(),
      binding: SellerOrdersBinding(),
    ),
    GetPage(
      name: sellerNewOrderAlert,
      page: () {
        final order = Get.arguments as SellerOrderModel? ??
            SellerOrderModel.getInitialOrders().first;
        return SellerNewOrderAlertScreen(order: order);
      },
      binding: SellerOrdersBinding(),
    ),
    GetPage(
      name: sellerOrderShipment,
      page: () {
        final order = Get.arguments as SellerOrderModel? ??
            SellerOrderModel.getInitialOrders().first;
        return SellerOrderShipmentScreen(order: order);
      },
      binding: SellerOrdersBinding(),
    ),
    GetPage(
      name: sellerOrderTracking,
      page: () {
        final order = Get.arguments as SellerOrderModel? ??
            SellerOrderModel.getInitialOrders().first;
        return SellerOrderTrackingScreen(order: order);
      },
      binding: SellerOrdersBinding(),
    ),
    GetPage(
      name: sellerOrderCompleted,
      page: () {
        final order = Get.arguments as SellerOrderModel? ??
            SellerOrderModel.getInitialOrders().firstWhere(
              (o) => o.status == SellerOrderStatus.delivered,
              orElse: () => SellerOrderModel.getInitialOrders().first,
            );
        return SellerOrderCompletedScreen(order: order);
      },
      binding: SellerOrdersBinding(),
    ),
    GetPage(
      name: sellerOrderCancelledDetail,
      page: () {
        final order = Get.arguments as SellerOrderModel? ??
            SellerOrderModel.getInitialOrders().firstWhere(
              (o) => o.status == SellerOrderStatus.cancelled,
              orElse: () => SellerOrderModel.getInitialOrders().first,
            );
        return SellerOrderCancelledDetailScreen(order: order);
      },
      binding: SellerOrdersBinding(),
    ),

    // Seller Revenue flow
    GetPage(
      name: sellerRevenue,
      page: () => const SellerRevenueScreen(),
      binding: SellerRevenueBinding(),
    ),
    GetPage(
      name: sellerRevenueTransactions,
      page: () => const SellerRevenueTransactionsScreen(),
      binding: SellerRevenueBinding(),
    ),
    GetPage(
      name: sellerRequestPayment,
      page: () => const SellerRequestPaymentScreen(),
      binding: SellerRevenueBinding(),
    ),
    GetPage(
      name: sellerPaymentDetails,
      page: () {
        final tx = Get.arguments as SellerTransactionModel? ??
            SellerTransactionModel.getInitialTransactions().firstWhere(
              (t) => t.status == SellerTransactionStatus.settled,
              orElse: () => SellerTransactionModel.getInitialTransactions().first,
            );
        return SellerPaymentDetailsScreen(transaction: tx);
      },
      binding: SellerRevenueBinding(),
    ),
    GetPage(
      name: sellerPayoutDetail,
      page: () {
        final tx = Get.arguments as SellerTransactionModel? ??
            SellerTransactionModel.getInitialTransactions().firstWhere(
              (t) => t.status == SellerTransactionStatus.inProgress,
              orElse: () => SellerTransactionModel.getInitialTransactions().first,
            );
        return SellerPayoutDetailScreen(transaction: tx);
      },
      binding: SellerRevenueBinding(),
    ),

    // Seller Profile & Settings flow
    GetPage(
      name: sellerProfile,
      page: () => const SellerProfileScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerEditProfile,
      page: () => const SellerEditProfileScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerVerificationBadge,
      page: () => const SellerVerificationBadgeScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerDocuments,
      page: () => const SellerDocumentsScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerDocumentDetail,
      page: () {
        final doc = Get.arguments as SellerDocumentModel? ??
            SellerDocumentModel.mockDocuments.first;
        return SellerDocumentDetailScreen(document: doc);
      },
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerReviewRatings,
      page: () => const SellerReviewRatingsScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerProfilePayment,
      page: () => const SellerProfilePaymentScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerSupport,
      page: () => const SellerSupportScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerLiveChat,
      page: () => const SellerLiveChatScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerSettings,
      page: () => const SellerSettingsScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerNotificationSettings,
      page: () => const SellerNotificationSettingsScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerChangePassword,
      page: () => const SellerChangePasswordScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerRefundPolicy,
      page: () => const SellerRefundPolicyScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerCommunityGuidelines,
      page: () => const SellerCommunityGuidelinesScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerPrivacyPolicy,
      page: () => const SellerPrivacyPolicyScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerCookieNotice,
      page: () => const SellerCookieNoticeScreen(),
      binding: SellerProfileBinding(),
    ),
    GetPage(
      name: sellerDeleteAccount,
      page: () => const SellerDeleteAccountScreen(),
      binding: SellerProfileBinding(),
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
      page: () => const MarketArtistProfileScreen(),
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
    GetPage(
      name: deleteAccount,
      page: () => const DeleteAccountScreen(),
      binding: SettingsBinding(),
    ),
  ];
}
