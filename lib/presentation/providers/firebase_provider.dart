import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAnalyticsProvider = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics.instance;
});

final firebaseAnalyticsServiceProvider =
    Provider<FirebaseAnalyticsService>((ref) {
  final analytics = ref.watch(firebaseAnalyticsProvider);
  return FirebaseAnalyticsService(analytics);
});
