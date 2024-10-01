import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputTextAreaSupport extends ConsumerWidget {
  const InputTextAreaSupport({
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

  final int textDark = 0xFFFFFFFF;
  final int textLight = 0xFF000000;
  final int hintDark = 0xFFB3B3B3;
  final int hintLight = 0xffB3B3B3;
  final int fillDark = 0xFF212121;
  final int fillLight = 0xFFFFFFFF;
  final int iconDark = 0xFFA2E6FA;
  final int iconLight = 0xFF0D3A5C;
  final int borderColorDark = 0xFFD9D9D9;
  final int borderColorLight = 0xFFD9D9D9;
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
          keyboardType: TextInputType.multiline,
          maxLines: 5,
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
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: isError
                  ? BorderSide(color: Color(borderError), width: 1)
                  : BorderSide(
                      color: isDarkMode
                          ? Color(borderColorDark)
                          : Color(borderColorLight),
                      width: 1,
                    ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: isError
                  ? BorderSide(color: Color(borderError), width: 1)
                  : BorderSide(
                      color: isDarkMode
                          ? Color(borderColorDark)
                          : Color(borderColorLight),
                      width: 1,
                    ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Color(borderError),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
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
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
