import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/infrastructure/models/notifications/notification_model.dart';
import 'package:finniu/infrastructure/models/notifications_entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/bubble_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_navigate_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_switch_profile.dart';
import 'package:finniu/services/device_info_service.dart';
import 'package:finniu/services/push_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldConfig(
      title: "Configuraciones",
      children: _BodySettings(),
    );
  }
}

class _BodySettings extends HookConsumerWidget {
  _BodySettings();

  Future<NotificationPreferences> _loadPreferences(String userId, WidgetRef ref) async {
    final deviceInfo = await DeviceInfoService().getDeviceInfo(userId);
    return ref.read(pushNotificationServiceProvider).getDevicePreferences(
          deviceId: deviceInfo.deviceId,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mover los hooks al nivel superior del build
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final bubbleState = ref.watch(positionProvider);
    final userProfile = ref.watch(userProfileNotifierProvider);
    final isMarketingPushActive = useState(true);
    final isOperationalPushActive = useState(true);

    final future = useMemoized(
      () => _loadPreferences(userProfile.id!, ref),
      [userProfile.id],
    );

    final snapshot = useFuture(future);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text('Error cargando preferencias: ${snapshot.error}'));
    }
    useEffect(() {
      if (snapshot.hasData) {
        final preferences = snapshot.data!;
        isMarketingPushActive.value = preferences.acceptsMarketing;
        isOperationalPushActive.value = preferences.acceptsOperational;
      }
      return null;
    }, [snapshot.data]);

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    void setDarkMode() {
      if (!isDarkMode) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.clickEvent,
          parameters: {
            "screen": FirebaseScreen.settingsV2,
            "click": "dark_mode",
          },
        );
        ref.read(settingsNotifierProvider.notifier).setDarkMode();
      } else {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.clickEvent,
          parameters: {
            "screen": FirebaseScreen.settingsV2,
            "click": "light_mode",
          },
        );
        ref.read(settingsNotifierProvider.notifier).setLightMode();
      }
    }

    void setBubble() {
      if (bubbleState.isRender) {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.closeJulia,
          parameters: {
            "screen": FirebaseScreen.settingsV2,
            "click": "close_julia",
          },
        );
        ref.read(positionProvider.notifier).resetBubble();
      } else {
        ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
          eventName: FirebaseAnalyticsEvents.openJulia,
          parameters: {
            "screen": FirebaseScreen.settingsV2,
            "click": "open_julia",
          },
        );
        ref.read(positionProvider.notifier).getBubble();
      }
    }

    Future<void> _updateNotificationPreferences({
      required WidgetRef ref,
      required NotificationType type,
      required bool value,
    }) async {
      final deviceInfo = await DeviceInfoService().getDeviceInfo(userProfile.id!);
      final Map<String, dynamic> updates = {};

      if (type == NotificationType.operational) {
        updates['accepts_operational'] = value;
        updates['accepts_marketing'] = isMarketingPushActive.value;
      } else if (type == NotificationType.marketing) {
        updates['accepts_marketing'] = value;
        updates['accepts_operational'] = isOperationalPushActive.value;
      }

      try {
        await ref.read(pushNotificationServiceProvider).updateDevice(
              deviceId: deviceInfo.deviceId,
              updates: updates,
            );
      } catch (e, stackTrace) {
        print('Error updating notification preferences: $e');
        print('stackTrace: $stackTrace');
      }
    }

    Future<void> handleNotificationSettings({
      required WidgetRef ref,
      required BuildContext context,
      required NotificationType type,
      required ValueNotifier<bool> stateNotifier,
    }) async {
      final pushService = ref.read(pushNotificationServiceProvider);
      final newValue = !stateNotifier.value;
      print('Current value: ${stateNotifier.value}');
      print('New value: $newValue');

      try {
        context.loaderOverlay.show();

        // Verificar el estado actual de los permisos del SO
        final hasPermission = await pushService.areNotificationsEnabled();

        if (newValue && !hasPermission) {
          final permissionsGranted = await pushService.requestNativePermissions(context, pushService);
          if (!permissionsGranted) {
            context.loaderOverlay.hide();
            return;
          }
        }

        // Preparar las actualizaciones incluyendo el state basado en los permisos del SO
        final Map<String, dynamic> updates = {
          'state': hasPermission ? 'active' : 'denied', // Siempre actualizar el state según permisos del SO
        };

        if (type == NotificationType.operational) {
          updates['accepts_operational'] = newValue;
          updates['accepts_marketing'] = isMarketingPushActive.value;
        } else if (type == NotificationType.marketing) {
          updates['accepts_marketing'] = newValue;
          updates['accepts_operational'] = isOperationalPushActive.value;
        }

        final deviceInfo = await DeviceInfoService().getDeviceInfo(userProfile.id!);
        await pushService.updateDevice(
          deviceId: deviceInfo.deviceId,
          updates: updates,
        );

        if (type == NotificationType.operational) {
          isOperationalPushActive.value = newValue;
        }
        if (type == NotificationType.marketing) {
          isMarketingPushActive.value = newValue;
        }

        if (!hasPermission && newValue) {
          stateNotifier.value = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor activa los permisos de notificaciones en la configuración'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        print('Error updating notification settings: $e');
        stateNotifier.value = !newValue;
      } finally {
        if (context.mounted) {
          context.loaderOverlay.hide();
        }
      }
    }

    void navigatePrivacy() {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.navigateTo,
        parameters: {
          "screen": FirebaseScreen.settingsV2,
          "navigate_to": FirebaseScreen.privacyV2,
        },
      );
      Navigator.pushNamed(context, '/v2/privacy');
    }

    return Column(
      children: [
        ButtonSwitchProfile(
          icon: "assets/svg_icons/dark_mode_icon.svg",
          title: "Modo oscuro",
          subtitle: "Elige tu modo favorito",
          onTap: () => setDarkMode(),
          value: isDarkMode,
        ),
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/lock_key_icon.svg",
          title: "Privacidad",
          subtitle: "Configura tu privacidad \n",
          onTap: () => navigatePrivacy(),
        ),
        ButtonSwitchProfile(
          icon: "assets/svg_icons/julia_icon.svg",
          title: "Chat de ayuda",
          subtitle: "Visualización de chat con Julia en la app",
          onTap: () => setBubble(),
          value: bubbleState.isRender,
        ),
        ButtonSwitchProfile(
          key: ValueKey('marketing-${isMarketingPushActive.value}'),
          icon: "assets/svg_icons/julia_icon.svg",
          title: "Notificaciones",
          subtitle: "Notificaciones de marketing",
          onTap: () => handleNotificationSettings(
            ref: ref,
            context: context,
            type: NotificationType.marketing,
            stateNotifier: isMarketingPushActive,
          ),
          value: isMarketingPushActive.value,
          isExternalState: true,
        ),
        ButtonSwitchProfile(
          key: ValueKey('operational-${isOperationalPushActive.value}'),
          icon: "assets/svg_icons/julia_icon.svg",
          title: "Notificaciones",
          subtitle: "Notificaciones de operaciones",
          onTap: () => handleNotificationSettings(
            ref: ref,
            context: context,
            type: NotificationType.operational,
            stateNotifier: isOperationalPushActive,
          ),
          value: isOperationalPushActive.value,
          isExternalState: true,
        ),
      ],
    );
  }
}
