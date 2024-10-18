import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PasswordRequired extends HookConsumerWidget {
  const PasswordRequired({
    super.key,
    required this.controller,
    required this.isExpanded,
  });
  final bool isExpanded;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int containerDark = 0xff222222;
    const int containerLight = 0xffF7F7F7;

    final ValueNotifier<bool> eightCharacters = useState(false);
    final ValueNotifier<bool> oneNumber = useState(false);
    final ValueNotifier<bool> oneLowercase = useState(false);
    final ValueNotifier<bool> oneCapital = useState(false);
    final ValueNotifier<bool> oneSpecialSymbol = useState(false);

    final RegExp hasDigits = RegExp(r'[0-9]');
    final RegExp hasLowercase = RegExp(r'[a-z]');
    final RegExp hasUppercase = RegExp(r'[A-Z]');
    final RegExp hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    useEffect(
      () {
        controller.text.length >= 8
            ? eightCharacters.value = true
            : eightCharacters.value = false;
        hasDigits.hasMatch(controller.text)
            ? oneNumber.value = true
            : oneNumber.value = false;
        hasLowercase.hasMatch(controller.text)
            ? oneLowercase.value = true
            : oneLowercase.value = false;
        hasUppercase.hasMatch(controller.text)
            ? oneCapital.value = true
            : oneCapital.value = false;
        hasSpecialCharacters.hasMatch(controller.text)
            ? oneSpecialSymbol.value = true
            : oneSpecialSymbol.value = false;
        controller.addListener(() {
          controller.text.length >= 8
              ? eightCharacters.value = true
              : eightCharacters.value = false;
          hasDigits.hasMatch(controller.text)
              ? oneNumber.value = true
              : oneNumber.value = false;
          hasLowercase.hasMatch(controller.text)
              ? oneLowercase.value = true
              : oneLowercase.value = false;
          hasUppercase.hasMatch(controller.text)
              ? oneCapital.value = true
              : oneCapital.value = false;
          hasSpecialCharacters.hasMatch(controller.text)
              ? oneSpecialSymbol.value = true
              : oneSpecialSymbol.value = false;
        });
        return null;
      },
      [controller],
    );

    return Positioned(
      top: 370,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDarkMode
              ? const Color(containerDark)
              : const Color(containerLight),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 200,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: eightCharacters,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 8 caracteres",
                  isValidate: eightCharacters.value,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: oneNumber,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 1 número (0....9)",
                  isValidate: oneNumber.value,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: oneLowercase,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 1 letra minúscula (a...z)",
                  isValidate: oneLowercase.value,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: oneCapital,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 1 letra mayúscula (A...Z)",
                  isValidate: oneCapital.value,
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: oneSpecialSymbol,
              builder: (context, value, child) {
                return ItemValidate(
                  text: "Al menos 1 símbolo especial (!...\$)",
                  isValidate: oneSpecialSymbol.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ItemValidate extends ConsumerWidget {
  const ItemValidate({
    super.key,
    required this.text,
    required this.isValidate,
  });
  final String text;
  final bool isValidate;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const iconTrueDark = 0xff0DCB6C;
    const iconTrueLight = 0xff09A554;
    const iconFalseDark = 0xffFF5C62;
    const iconFalseLight = 0xffED1C24;

    return Row(
      children: [
        isValidate
            ? Icon(
                Icons.check_circle_outline,
                color: isDarkMode
                    ? const Color(iconTrueDark)
                    : const Color(iconTrueLight),
                size: 20,
              )
            : Icon(
                Icons.error_outline,
                color: isDarkMode
                    ? const Color(iconFalseDark)
                    : const Color(iconFalseLight),
                size: 20,
              ),
        const SizedBox(
          width: 5,
        ),
        TextPoppins(
          text: text,
          fontSize: 12,
        ),
      ],
    );
  }
}
