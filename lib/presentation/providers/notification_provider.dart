import 'package:finniu/infrastructure/datasources/notifications_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsDataSourceProvider = Provider<NotificationsDataSource>((ref) {
  final config = ref.watch(appConfigProvider);
  return NotificationsDataSource(baseUrl: config.notificationsBaseUrl);
});

class NotificationSetupState {
  final bool isInitialized;
  final bool hasShownDialog;

  NotificationSetupState({
    this.isInitialized = false,
    this.hasShownDialog = false,
  });

  NotificationSetupState copyWith({
    bool? isInitialized,
    bool? hasShownDialog,
  }) {
    return NotificationSetupState(
      isInitialized: isInitialized ?? this.isInitialized,
      hasShownDialog: hasShownDialog ?? this.hasShownDialog,
    );
  }
}

// StateNotifier
class NotificationSetupStateNotifier extends StateNotifier<NotificationSetupState> {
  NotificationSetupStateNotifier() : super(NotificationSetupState());

  void updateFields({
    bool? isInitialized,
    bool? hasShownDialog,
  }) {
    state = state.copyWith(
      isInitialized: isInitialized,
      hasShownDialog: hasShownDialog,
    );
  }

  void markInitialized() {
    updateFields(isInitialized: true);
  }

  void markDialogShown() {
    updateFields(hasShownDialog: true);
  }
}

// Provider
final notificationSetupStateNotifierProvider =
    StateNotifierProvider<NotificationSetupStateNotifier, NotificationSetupState>(
  (ref) => NotificationSetupStateNotifier(),
);
