import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputTextFileInvest extends ConsumerWidget {
  const InputTextFileInvest({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    required this.title,
    this.isDisable = true,
    this.onError,
    this.isError = false,
    this.isNumeric = false,
    this.isRow = false,
  });
  final bool isDisable;
  final bool isRow;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final String hintText;
  final bool isNumeric;
  final bool isError;
  final VoidCallback? onError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int hintDark = 0xFFE6E6E6;
    const int hintLight = 0xFF535050;
    const int fillDark = 0xFF0E0E0E;
    const int fillLight = 0xFFDCF5FC;
    const int textDark = 0xFFFFFFFF;
    const int textLight = 0xFF000000;
    const int borderColorDark = 0xFFA2E6FA;
    const int borderColorLight = 0xFF0D3A5C;
    const int borderError = 0xFFED1C24;
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return TextFormField(
      enabled: isDisable,
      onTap: () {
        if (onError != null && isError) {
          onError!();
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      controller: controller,
      style: TextStyle(
        fontSize: 12,
        color: isDarkMode ? const Color(textDark) : const Color(textLight),
        fontWeight: FontWeight.w400,
        fontFamily: "Poppins",
      ),
      decoration: InputDecoration(
        label: TextPoppins(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          textDark: 0xFFA2E6FA,
          textLight: 0xFF0D3A5C,
        ),
        hintStyle: TextStyle(
          fontSize: isRow ? 9 : 12,
          color: isDarkMode ? const Color(hintDark) : const Color(hintLight),
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
        ),
        hintText: hintText,
        fillColor: isDarkMode ? const Color(fillDark) : const Color(fillLight),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          borderSide: isError
              ? const BorderSide(color: Color(borderError), width: 1)
              : BorderSide(
                  color: isDarkMode
                      ? const Color(borderColorDark)
                      : const Color(borderColorLight),
                  width: 1,
                ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          borderSide: isError
              ? const BorderSide(color: Color(borderError), width: 1)
              : BorderSide(
                  color: isDarkMode
                      ? const Color(borderColorDark)
                      : const Color(borderColorLight),
                  width: 1,
                ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          borderSide: isError
              ? const BorderSide(color: Color(borderError), width: 1)
              : BorderSide(
                  color: isDarkMode
                      ? const Color(borderColorDark)
                      : const Color(borderColorLight),
                  width: 1,
                ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(
            color: Color(borderError),
            width: 1,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(
            color: Color(borderError),
            width: 1,
          ),
        ),
        suffixIcon: isError
            ? const Icon(
                Icons.error_outline,
                color: Color(borderError),
                size: 20,
              )
            : const Icon(
                Icons.person_outline,
                color: Colors.transparent,
                size: 20,
              ),
      ),
      validator: validator,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    );
  }
}
