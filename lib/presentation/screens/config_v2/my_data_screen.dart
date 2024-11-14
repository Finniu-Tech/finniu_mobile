import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/config_v2/scaffold_config.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_navigate_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyDataScreen extends ConsumerWidget {
  const MyDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const ScaffoldConfig(
      title: "Mis datos",
      children: _BodyMyData(),
    );
  }
}

class _BodyMyData extends ConsumerWidget {
  const _BodyMyData();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigate(BuildContext context, String navigate) {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.navigateTo,
        parameters: {
          "screen": FirebaseScreen.myDataV2,
          "navigate_to": navigate,
        },
      );
      Navigator.pushNamed(context, navigate);
    }

    final profileCompletenessAsync = ref.watch(userProfileCompletenessProvider);

    return profileCompletenessAsync.when(
      data: (profileCompleteness) {
        return Column(
          children: [
            ButtonNavigateProfile(
              isComplete: profileCompleteness.hasCompletePersonalData(),
              icon: "assets/svg_icons/user_icon.svg",
              title: "Datos personales",
              subtitle: "Información personal legal. \n",
              onTap: () => navigate(context, '/v2/edit_personal_data'),
            ),
            ButtonNavigateProfile(
              isComplete: profileCompleteness.hasCompleteLocation(),
              icon: "assets/svg_icons/map_icon_v2.svg",
              title: "Ubicación",
              subtitle: "Información sobre su ubicación actual \n",
              onTap: () => navigate(context, '/v2/edit_location_data'),
            ),
            ButtonNavigateProfile(
              isComplete: profileCompleteness.hasCompleteOccupation(),
              icon: "assets/svg_icons/bag_icon_v2.svg",
              title: "Ocupación laboral",
              subtitle: "Información sobre tu ocupación laboral \n",
              onTap: () => navigate(context, '/v2/edit_job_data'),
            ),
            // ButtonNavigateProfile(
            //   isComplete: userProfile.completeAboutData(),
            //   icon: "assets/svg_icons/user_icon_v2.svg",
            //   title: "Información adicional",
            //   subtitle:
            //       "Información de mi nombre favorito, cumpleaños y otros más....",
            //   onTap: () => navigate(context, '/v2/additional_information'),
            // ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          const Text('Error al cargar el estado del perfil'),
    );
  }
}
