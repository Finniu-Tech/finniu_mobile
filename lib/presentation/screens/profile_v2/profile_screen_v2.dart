import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/app_bar_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_my_data.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_navigate_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/image_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UserProfileV2 extends ConsumerWidget {
  const UserProfileV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return const Center(
          child: CircularLoader(
            width: 50,
            height: 50,
          ),
        );
      },
      child: Scaffold(
        appBar: AppBarProfile(
          title: "Mi perfil",
          onLeadingPressed: () => Navigator.pushNamed(context, '/home_v2'),
        ),
        backgroundColor: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        body: const SingleChildScrollView(
          child: _BodyProfile(),
        ),
      ),
    );
  }
}

class _BodyProfile extends ConsumerWidget {
  const _BodyProfile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userProfileNotifierProvider);

    String name = "${userProfile.nickName} ${userProfile.lastNameFather}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageProfileStack(
          fullName: name,
          email: "${userProfile.email}",
          profileImage: userProfile.imageProfileUrl ??
              "https://e7.pngegg.com/pngimages/84/165/png-clipart-united-states-avatar-organization-information-user-avatar-service-computer-wallpaper-thumbnail.png",
          backgroundImage: "",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonMyData(
              isComplete: userProfile.completeData() == 1.0,
              icon: "assets/svg_icons/file_text_icon.svg",
              title: "Mis datos",
              subtitle: "Clic para ver mis datos",
              load: userProfile.completeData(),
              onTap: () => {
                ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
                  eventName: FirebaseAnalyticsEvents.navigateTo,
                  parameters: {
                    "screen": FirebaseScreen.profileV2,
                    "navigate_to": FirebaseScreen.myDataV2,
                  },
                ),
                Navigator.pushNamed(context, '/v2/my_data'),
              },
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonMyData(
              icon: "assets/svg_icons/credit-card.svg",
              title: "Mis cuentas",
              subtitle: "Falta agregar tus cuentas",
              load: 1,
              onTap: () => {
                ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
                  eventName: FirebaseAnalyticsEvents.navigateTo,
                  parameters: {
                    "screen": FirebaseScreen.profileV2,
                    "navigate_to": FirebaseScreen.myAccountsV2,
                  },
                ),
                Navigator.pushNamed(context, '/v2/my_accounts'),
              },
              isComplete: true,
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/settings.svg",
          title: "new home",
          subtitle:
              "Notificaciones, Modo oscuro, \nprivacidad, cambio de contraseña",
          onTap: () => {
            ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
              eventName: FirebaseAnalyticsEvents.navigateTo,
              parameters: {
                "screen": FirebaseScreen.profileV2,
                "navigate_to": FirebaseScreen.settingsV2,
              },
            ),
            Navigator.pushNamed(context, '/v4/home'),
          },
        ),
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/settings.svg",
          title: "Configuraciones",
          subtitle:
              "Notificaciones, Modo oscuro, \nprivacidad, cambio de contraseña",
          onTap: () => {
            ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
              eventName: FirebaseAnalyticsEvents.navigateTo,
              parameters: {
                "screen": FirebaseScreen.profileV2,
                "navigate_to": FirebaseScreen.settingsV2,
              },
            ),
            Navigator.pushNamed(context, '/v2/settings'),
          },
        ),
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/legal_icon_v2.svg",
          title: "Documentos legales",
          subtitle: "Información legal para las \ninversiones",
          onTap: () => {
            ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
              eventName: FirebaseAnalyticsEvents.navigateTo,
              parameters: {
                "screen": FirebaseScreen.profileV2,
                "navigate_to": FirebaseScreen.legalDocumentsV2,
              },
            ),
            Navigator.pushNamed(context, '/v2/legal_documents'),
          },
        ),
        ButtonNavigateProfile(
          isComplete: true,
          icon: "assets/svg_icons/help_circle.svg",
          title: "Soporte y ayuda",
          subtitle: "Ticket de soporte y preguntas \nfrecuentes",
          onTap: () => {
            ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
              eventName: FirebaseAnalyticsEvents.navigateTo,
              parameters: {
                "screen": FirebaseScreen.profileV2,
                "navigate_to": FirebaseScreen.supportV2,
              },
            ),
            Navigator.pushNamed(context, '/v2/support'),
          },
        ),
        ButtonNavigateProfile(
          icon: "assets/svg_icons/log_out.svg",
          title: "Cerrar sesión",
          isComplete: true,
          onlyTitle: true,
          subtitle: "",
          onTap: () => {
            ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
              eventName: FirebaseAnalyticsEvents.navigateTo,
              parameters: {
                "screen": FirebaseScreen.profileV2,
                "navigate_to": FirebaseScreen.exitV2,
              },
            ),
            ref.read(firebaseAnalyticsServiceProvider).resetAnalyticsData(),
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/v2/exit',
              (route) => false,
            ),
          },
        ),
      ],
    );
  }
}
