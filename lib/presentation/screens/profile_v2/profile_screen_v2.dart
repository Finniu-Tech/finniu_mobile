import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/app_bar_profile.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/button_my_data.dart';
import 'package:finniu/presentation/screens/profile_v2/widgets/image_profile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileV2 extends ConsumerWidget {
  const UserProfileV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;
    return Scaffold(
      appBar: const AppBarProfile(title: "Mi perfil"),
      backgroundColor: isDarkMode
          ? const Color(backgroundDark)
          : const Color(backgroundLight),
      body: const SingleChildScrollView(
        child: _BodyProfile(),
      ),
    );
  }
}

class _BodyProfile extends ConsumerWidget {
  const _BodyProfile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userProfile = ref.watch(userProfileNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ImageProfileStack(
          fullName: "Mariana",
          email: "JUQpC@example.com",
          profileImage:
              "https://img.lovepik.com/free-png/20220121/lovepik-creative-owl-animal-small-avatar-art-illustration-png-image_401570099_wh860.png",
          backgroundImage:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-8W1UenncOIyiL8R0a2TZfGB0H3jXgKnIww&s",
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonMyData(
              icon: "assets/svg_icons/file_text_icon.svg",
              title: "Mis datos",
              subtitle: "Clic para ver mis datos",
              load: 0.5,
              onTap: () => print("click"),
            ),
            const SizedBox(
              width: 10,
            ),
            ButtonMyData(
              icon: "assets/svg_icons/credit-card.svg",
              title: "Mis cuentas",
              subtitle: "Falta agregar tus cuentas",
              load: 1,
              onTap: () => print("click"),
            ),
          ],
        ),
      ],
    );
  }
}
