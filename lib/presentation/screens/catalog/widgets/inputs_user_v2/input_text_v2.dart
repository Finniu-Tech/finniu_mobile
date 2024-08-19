import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputTextFileUserProfile extends ConsumerWidget {
  const InputTextFileUserProfile({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isNumeric = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isNumeric;

  final int hintDark = 0xFF989898;
  final int hintLight = 0xFF989898;
  final int fillDark = 0xFF222222;
  final int fillLight = 0xFFF7F7F7;
  final int textDark = 0xFFFFFFFF;
  final int textLight = 0xFF000000;
  final int borderColorDark = 0xFFA2E6FA;
  final int borderColorLight = 0xFF0D3A5C;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode ? Color(textDark) : Color(textLight),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Color(hintDark) : Color(hintLight),
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
            ),
            hintText: hintText,
            fillColor: isDarkMode ? Color(fillDark) : Color(fillLight),
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(
                color: isDarkMode
                    ? Color(borderColorDark)
                    : Color(borderColorLight),
                width: 1,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
          ),
          validator: validator,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class InputPhoneUserProfile extends ConsumerWidget {
  const InputPhoneUserProfile({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.isNumeric = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isNumeric;

  final int hintDark = 0xFF989898;
  final int hintLight = 0xFF989898;
  final int fillDark = 0xFF222222;
  final int fillLight = 0xFFF7F7F7;
  final int textDark = 0xFFFFFFFF;
  final int textLight = 0xFF000000;
  final int borderColorDark = 0xFFA2E6FA;
  final int borderColorLight = 0xFF0D3A5C;
  final int prefixTextDark = 0xffFFFFFF;
  final int prefixTextLight = 0xff000000;
  final int iconColorDark = 0xffFFFFFF;
  final int iconColorLight = 0xff000000;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode ? Color(textDark) : Color(textLight),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Color(hintDark) : Color(hintLight),
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
            ),
            hintText: hintText,
            fillColor: isDarkMode ? Color(fillDark) : Color(fillLight),
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(
                color: isDarkMode
                    ? Color(borderColorDark)
                    : Color(borderColorLight),
                width: 1,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            prefixIcon: SizedBox(
              width: 95,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 15),
                  Image.asset(
                    "assets/images/peru_flag_v2.png",
                    width: 26,
                    height: 16,
                  ),
                  const SizedBox(width: 3),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: isDarkMode
                        ? Color(iconColorDark)
                        : Color(iconColorLight),
                  ),
                  const SizedBox(width: 3),
                  const TextPoppins(text: "+51", fontSize: 12, isBold: true),
                ],
              ),
            ),
          ),
          validator: validator,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
