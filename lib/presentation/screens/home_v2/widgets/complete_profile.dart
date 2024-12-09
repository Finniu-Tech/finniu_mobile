import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';

class ProfileCompletenessSection extends ConsumerWidget {
  const ProfileCompletenessSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileCompletenessAsync = ref.watch(userProfileCompletenessProvider);
    return profileCompletenessAsync.when(
      data: (profileCompleteness) {
        if (!profileCompleteness.isComplete()) {
          return CompleteProfileNotificationWidget(
            message: 'Completa tus datos en unos minutos para comenzar a invertir',
            buttonText: 'Completar',
            onPressed: () {
              Navigator.pushNamed(
                context,
                profileCompleteness.getNextStep() ?? '/v2/my_data',
              );
            },
            imagePath: 'assets/home/complete_profile.png',
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Text('Error al cargar el estado del perfil'),
    );
  }
}

class CompleteProfileNotificationWidget extends ConsumerWidget {
  final String message;
  final String buttonText;
  final VoidCallback onPressed;
  final String imagePath;

  const CompleteProfileNotificationWidget({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onPressed,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    // Define color variables
    final Color backgroundColor = isDarkMode ? const Color(0xffA2E6FA) : const Color(0xff051926);
    final Color textColor = isDarkMode ? Colors.black : Colors.white;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 100,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  imagePath,
                  width: 81,
                  height: 50,
                  // color: imageColor,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CompleteButtonText(
                        isDarkMode: isDarkMode,
                        text: "Completar",
                        onPressed: onPressed,
                        underline: false,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class CompleteButtonText extends StatelessWidget {
  const CompleteButtonText({
    super.key,
    required this.isDarkMode,
    required this.text,
    required this.onPressed,
    this.underline = true,
  });
  final String text;
  final bool isDarkMode;
  final void Function()? onPressed;
  final bool underline;
  @override
  Widget build(BuildContext context) {
    const int textColorDark = 0xff0D3A5C;
    const int textColorLight = 0xffA2E6FA;
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: underline ? TextDecoration.underline : null,
              decorationColor: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
              color: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
              fontFamily: "Poppins",
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 2),
          Icon(
            Icons.arrow_forward_ios,
            size: 12,
            color: isDarkMode ? const Color(textColorDark) : const Color(textColorLight),
          ),
        ],
      ),
    );
  }
}
