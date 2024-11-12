
## Firebase doc

link debugmode console https://console.firebase.google.com/project/finniu/analytics/app/android:com.finniu/debugview

event purifier documentation page https://firebase.google.com/docs/analytics/debugview?hl=es-419

event documentation https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event

document link with the implemented events https://docs.google.com/spreadsheets/d/1b82gxUfsIbZFAKq5kNh1QNbCG-cMLJiVg0uitFMx1q0/edit?gid=0#gid=0

To enable Analytics debug mode on your development device, specify the following command line argument in Xcode:
``````
-FIRDebugEnabled
```````

This behavior persists until you explicitly disable debug mode by specifying the following command line argument:
``````
-FIRDebugDisabled
``````

To enable Analytics debug mode on an Android device, execute the following commands:
``````
adb shell setprop debug.firebase.analytics.app com.finniu
```````

This behavior persists until you explicitly disable debug mode by executing the following command:
``````
adb shell setprop debug.firebase.analytics.app .none.
``````
provider firebaseAnalyticsServiceProvider
``````
final firebaseAnalyticsProvider = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics.instance;
});

final firebaseAnalyticsServiceProvider =
    Provider<FirebaseAnalyticsService>((ref) {
  final analytics = ref.watch(firebaseAnalyticsProvider);
  return FirebaseAnalyticsService(analytics);
});
``````
example firebaseAnalyticsServiceProvider
``````


    ref.read(firebaseAnalyticsServiceProvider).setUserId(
        "${profile.firstName}_${profile.lastName}${profile.email}_${profile.documentNumber}_${profile.phoneNumber}",
    );

     ref.read(firebaseAnalyticsServiceProvider).setUserProperty(
        name: "first_name",
        value: "${profile.firstName}_${profile.lastName}",
    );

    ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.[event],
        parameters: {
          'parameter': [parameter],
        },
    );

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

    ref.read(firebaseAnalyticsServiceProvider).setSessionTimeoutDuration(
          const Duration(minutes: 5),
      );



``````
events FirebaseAnalyticsEvents import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
``````
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
  static const String addCoupon = "add_coupon";
  static const String completeRegistration = "complete_registration";
  static const String calculateSimulation = "calculate_simulation";
  static const String continueSimulation = "continue_simulation";
  static const String editSimulation = "edit_simulation";
  static const String addVoucher = "add_voucher";
  static const String contactAdviser = "contact_adviser";
  static const String investmentPressValidate = "investment_press_validate";
  static const String clickCalendar = "click_calendar";
  static const String voucherDownloadHistory = "voucher_download_history";
  static const String voucherDownloadDetail = "voucher_download_detail";
  static const String contactDownloadDetail = "contact_download_detail";
  static const String seeInterestTable = "see_interest_table";
}
``````