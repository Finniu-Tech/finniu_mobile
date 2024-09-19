import 'package:finniu/main.dart';
import 'package:finniu/services/event_tracking_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isProduction = appConfig.environment == 'production';

final eventTrackerServiceProvider = Provider<EventTrackerService>((ref) {
  return createEventTrackerService(isProduction);
});
