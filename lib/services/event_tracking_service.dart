import 'package:firebase_analytics/firebase_analytics.dart';

abstract class EventTrackerInterface {
  Future<void> logButtonClick(String buttonName);
  Future<void> logScreenView(String screenName);
  Future<void> logPurchase({
    required double value,
    required String currency,
    required String itemName,
  });
}

class GoogleAnalyticsTracker implements EventTrackerInterface {
  final FirebaseAnalytics _analytics;

  GoogleAnalyticsTracker(this._analytics);

  @override
  Future<void> logButtonClick(String buttonName) async {
    await _analytics.logEvent(
      name: 'button_click',
      parameters: {
        'button_name': buttonName,
      },
    );
  }

  @override
  Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  @override
  Future<void> logPurchase({
    required double value,
    required String currency,
    required String itemName,
  }) async {
    await _analytics.logPurchase(
      value: value,
      currency: currency,
      items: [
        AnalyticsEventItem(
          itemName: itemName,
        ),
      ],
    );
  }
}

class EventTrackerService {
  final EventTrackerInterface _tracker;

  EventTrackerService(this._tracker);

  Future<void> logButtonClick(String buttonName) async {
    await _tracker.logButtonClick(buttonName);
  }

  Future<void> logScreenView(String screenName) async {
    await _tracker.logScreenView(screenName);
  }

  Future<void> logPurchase({
    required double value,
    required String currency,
    required String itemName,
  }) async {
    await _tracker.logPurchase(
      value: value,
      currency: currency,
      itemName: itemName,
    );
  }
}

class NoOpEventTracker implements EventTrackerInterface {
  @override
  Future<void> logButtonClick(String buttonName) async {
    //pass
  }

  @override
  Future<void> logScreenView(String screenName) async {
    // No hace nada
  }

  @override
  Future<void> logPurchase({
    required double value,
    required String currency,
    required String itemName,
  }) async {
    //pass
  }
}

EventTrackerService createEventTrackerService(bool isProduction) {
  if (isProduction) {
    final analytics = FirebaseAnalytics.instance;
    return EventTrackerService(GoogleAnalyticsTracker(analytics));
  } else {
    return EventTrackerService(NoOpEventTracker());
  }
}
