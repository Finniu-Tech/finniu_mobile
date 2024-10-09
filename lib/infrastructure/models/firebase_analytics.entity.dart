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
      parameters: parameters,
    );
  }

  Future<void> logLogin(String loginMethod) async {
    try {
      await _analytics.logLogin(loginMethod: loginMethod);
    } catch (e) {
      print(e);
    }
  }

  Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future<void> setUserProperty(String name, String value) async {
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
      String currency, double value, String transactionId) async {
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

  Future<void> logScreenView(String screenName, String screenClass) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenClass,
    );
  }
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
}
