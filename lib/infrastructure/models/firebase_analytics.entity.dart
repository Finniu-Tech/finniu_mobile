import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics _analytics;

  FirebaseAnalyticsService(this._analytics);

  Future<void> logCustomEvent({
    required String eventName,
    required Map<String, String> parameters,
  }) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: {
        ...parameters,
        "date_now": "${DateTime.now().toLocal()}",
      },
    );
  }

  Future<void> logLogin(String loginMethod) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    await _analytics.setUserProperty(
      name: name,
      value: value,
    );
  }

  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    await _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  Future<void> setSessionTimeoutDuration(Duration duration) async {
    await _analytics.setSessionTimeoutDuration(duration);
  }

  Future<void> resetAnalyticsData() async {
    await _analytics.resetAnalyticsData();
  }

  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  Future<void> logSelectContent(String contentType, String itemId) async {
    await _analytics.logSelectContent(
      contentType: contentType,
      itemId: itemId,
    );
  }

  Future<void> logTutorialBegin() async {
    await _analytics.logTutorialBegin();
  }

  Future<void> logTutorialComplete() async {
    await _analytics.logTutorialComplete();
  }

  Future<void> logPurchase(
    String currency,
    double value,
    String transactionId,
  ) async {
    await _analytics.logPurchase(
      currency: currency,
      value: value,
      transactionId: transactionId,
    );
  }

  Future<void> logAddToCart(String currency, double value) async {
    await _analytics.logAddToCart(
      currency: currency,
      value: value,
    );
  }

  Future<void> logRemoveFromCart(String currency, double value) async {
    await _analytics.logRemoveFromCart(
      currency: currency,
      value: value,
    );
  }

  Future<void> logScreenView({
    required String screenName,
    required String screenClass,
    required Map<String, String> parameters,
  }) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
      parameters: parameters,
    );
  }
}

class FirebaseScreen {
  static const String home = '/';
  static const String loginStart = '/login_start';
  static const String loginEmail = '/login_email';
  static const String onboardingQuestions = '/onboarding_questions';
  static const String signUpEmail = '/sign_up_email';
  static const String loginForgot = '/login_forgot';
  static const String loginInvalid = '/login_invalid';
  static const String onBoardingStart = '/on_boarding_start';
  static const String onboardingQuestionsStart = '/onboarding_questions_start';
  static const String investmentResult = '/investment_result';
  static const String homeHome = '/home_home';
  static const String homeV2 = '/home_v2';
  static const String homeNotification = '/home_notification';
  static const String profile = '/profile';
  static const String planList = '/plan_list';
  static const String privacy = '/privacy';
  static const String transfers = '/transfers';
  static const String languages = '/languages';
  static const String help = '/help';
  static const String sendCode = '/send_code';
  static const String investmentStep1 = '/investment_step1';
  static const String investmentStep2 = '/investment_step2';
  static const String investmentStep3 = '/investment_step3';
  static const String setNewPassword = '/set_new_password';
  static const String calculatorTool = '/calculator_tool';
  static const String calculatorResult = '/calculator_result';
  static const String finance = '/finance';
  static const String catalog = '/catalog';
  static const String financeScreen2 = '/finance_screen2';
  static const String contractView = '/contract_view';
  static const String calendarPage = '/calendar_page';
  static const String finishInvestment = '/finish_investment';
  static const String processInvestment = '/process_investment';
  static const String investmentHistory = '/investment_history';
  static const String reinvestmentStep1 = '/reinvestment_step_1';
  static const String reinvestmentStep2 = '/reinvestment_step_2';
  static const String evaluation = '/evaluation';
  static const String emptyTransference = '/empty_transference';
  static const String activateAccount = '/activate_account';
  static const String fundDetail = '/fund_detail';
  static const String investmentStep1V2 = '/v2/investment/step-1';
  static const String investmentStep2V2 = '/v2/investment/step-2';
  static const String aggroInvestmentBookingV2 = '/v2/aggro-investment/booking';
  static const String aggroInvestmentV2 = '/v2/aggro-investment';
  static const String investmentBlueGoldV2 = '/v2/investment_blue_gold';
  static const String simulatorV2 = '/v2/simulator';
  static const String binnacleV2 = '/v2/binnacle';
  static const String summaryV2 = '/v2/summary';
  static const String calendarV2 = '/v2/calendar';
  static const String investmentV2 = '/v2/investment';
  static const String notificationsV2 = '/v2/notifications';
  static const String lotDetailV2 = '/v2/lot_detail';
  static const String registerV2 = '/v2/register';
  static const String sendCodeV2 = '/v2/send_code';
  static const String activateAccountV2 = '/v2/activate_account';
  static const String completeDetailsV2 = '/v2/complete_details';
  static const String validateIdentityV2 = '/v2/validate_identity';
  static const String scanDocumentV2 = '/v2/scan_document';
  static const String formPersonalDataV2 = '/v2/form_personal_data';
  static const String formLocationV2 = '/v2/form_location';
  static const String formJobV2 = '/v2/form_job';
  static const String formLegalTermsV2 = '/v2/form_legal_terms';
  static const String aboutMeV2 = '/v2/form_about_me';
  static const String profileV2 = '/v2/profile';
  static const String onBoardingV2 = '/v2/on_boarding';
  static const String myDataV2 = '/v2/my_data';
  static const String settingsV2 = '/v2/settings';
  static const String newNotificationsV2 = '/v2/new_notifications';
  static const String privacyV2 = '/v2/privacy';
  static const String legalDocumentsV2 = '/v2/legal_documents';
  static const String supportV2 = '/v2/support';
  static const String supportTicketV2 = '/v2/support_ticket';
  static const String frequentlyQuestionsV2 = '/v2/frequently_questions';
  static const String editPersonalDataV2 = '/v2/edit_personal_data';
  static const String editLocationDataV2 = '/v2/edit_location_data';
  static const String editJobDataV2 = '/v2/edit_job_data';
  static const String additionalInformationV2 = '/v2/additional_information';
  static const String myAccountsV2 = '/v2/my_accounts';
  static const String loginEmailV2 = '/v2/login_email';
  static const String loginForgotV2 = '/v2/login_forgot';
  static const String setNewPasswordV2 = '/v2/set_new_password';
  static const String biometricTest = '/biometric_test';
  static const String geolocatorV2 = '/v2/geolocator';
  static const String firebaseTestV2 = '/v2/firebase_test';
  static const String payOutV2 = '/v2/pay_out';
  static const String rextieCommunicationV2 = '/v2/rextie_comminication';
  static const String pushNotification = '/push_notification';
  static const String exitV2 = '/v2/exit';
}

class FirebaseAnalyticsEvents {
  // E-Commerce Events
  static const String addPaymentInfo = "add_payment_info";
  static const String addShippingInfo = "add_shipping_info";
  static const String addToCart = "add_to_cart";
  static const String addToWishlist = "add_to_wishlist";
  static const String beginCheckout = "begin_checkout";
  static const String purchase = "purchase";
  static const String refund = "refund";
  static const String removeFromCart = "remove_from_cart";
  static const String viewCart = "view_cart";
  static const String viewItem = "view_item";
  static const String viewItemList = "view_item_list";
  static const String viewPromotion = "view_promotion";

  // General App Events
  static const String adImpression = "ad_impression";
  static const String appOpen = "app_open";
  static const String campaignDetails = "campaign_details";
  static const String earnVirtualCurrency = "earn_virtual_currency";
  static const String generateLead = "generate_lead";
  static const String joinGroup = "join_group";
  static const String login = "login";
  static const String signUp = "sign_up";
  static const String spendVirtualCurrency = "spend_virtual_currency";
  static const String unlockAchievement = "unlock_achievement";
  static const String share = "share";

  // Gameplay Events
  static const String levelEnd = "level_end";
  static const String levelStart = "level_start";
  static const String levelUp = "level_up";
  static const String postScore = "post_score";
  static const String tutorialBegin = "tutorial_begin";
  static const String tutorialComplete = "tutorial_complete";

  // User Interaction Events
  static const String screenView = "screen_view";
  static const String search = "search";
  static const String selectContent = "select_content";
  static const String selectItem = "select_item";
  static const String selectPromotion = "select_promotion";
  static const String viewSearchResults = "view_search_results";

  // Custom Events
  static const String addCoupon = "click_add_coupon";
  static const String completeRegistration = "click_complete_registration";
  static const String calculateSimulation = "click_calculate_simulation";
  static const String continueSimulation = "click_continue_simulation";
  static const String editSimulation = "click_edit_simulation";
  static const String addVoucher = "click_add_voucher";
  static const String contactAdviser = "click_contact_adviser";
  static const String investmentPressValidate =
      "click_investment_press_validate";
  static const String clickCalendar = "click_calendar";
  static const String voucherDownloadHistory = "click_voucher_download_history";
  static const String voucherDownloadDetail = "click_voucher_download_detail";
  static const String contactDownloadDetail = "click_contact_download_detail";
  static const String seeInterestTable = "click_see_interest_table";
  static const String navigateTo = "navigate_to";
  static const String clickEvent = "click_event";
  static const String pushDataSucces = "push_data_succes";
  static const String pushDataError = "push_data_error";
  static const String scrollPage = "scroll_page";
}
