import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputTextFileUserProfile extends ConsumerWidget {
  const InputTextFileUserProfile({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.onError,
    this.isError = false,
    this.isNumeric = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isNumeric;
  final bool isError;
  final VoidCallback? onError;

  final int hintDark = 0xFF989898;
  final int hintLight = 0xFF989898;
  final int fillDark = 0xFF222222;
  final int fillLight = 0xFFF7F7F7;
  final int textDark = 0xFFFFFFFF;
  final int textLight = 0xFF000000;
  final int borderColorDark = 0xFFA2E6FA;
  final int borderColorLight = 0xFF0D3A5C;
  final int borderError = 0xFFED1C24;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onTap: () {
            if (onError != null && isError) {
              onError!();
              ScaffoldMessenger.of(context).clearSnackBars();
            }
          },
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
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: isError
                  ? BorderSide(color: Color(borderError), width: 1)
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: isError
                  ? BorderSide(color: Color(borderError), width: 1)
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: isError
                  ? BorderSide(color: Color(borderError), width: 1)
                  : BorderSide(
                      color: isDarkMode
                          ? Color(borderColorDark)
                          : Color(borderColorLight),
                      width: 1,
                    ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(
                color: Color(borderError),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(
                color: Color(borderError),
                width: 1,
              ),
            ),
            suffixIcon: isError
                ? Icon(
                    Icons.error_outline,
                    color: Color(borderError),
                    size: 24,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.transparent,
                    size: 24,
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
