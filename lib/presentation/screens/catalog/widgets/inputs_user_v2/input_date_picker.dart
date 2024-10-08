import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputDatePickerUserProfile extends HookConsumerWidget {
  const InputDatePickerUserProfile({
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int hintDark = 0xFF989898;
    const int hintLight = 0xFF989898;
    const int fillDark = 0xFF222222;
    const int fillLight = 0xFFF7F7F7;
    const int textDark = 0xFFFFFFFF;
    const int textLight = 0xFF000000;
    const int borderColorDark = 0xFFA2E6FA;
    const int borderColorLight = 0xFF0D3A5C;
    const int borderError = 0xFFED1C24;
    const int iconDark = 0xFFA2E6FA;
    const int iconLight = 0xFF000000;

    Future<void> selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(
          DateTime.now().year - 18,
          DateTime.now().month,
          DateTime.now().day,
        ),
        firstDate: DateTime(1900),
        lastDate: DateTime(
          DateTime.now().year - 18,
          DateTime.now().month,
          DateTime.now().day,
        ),
        selectableDayPredicate: (DateTime date) {
          DateTime limitDate = DateTime(
            DateTime.now().year - 18,
            DateTime.now().month,
            DateTime.now().day,
          );

          return date.isBefore(limitDate) || date.isAtSameMomentAs(limitDate);
        },
        helpText: "Seleccione su fecha de nacimiento",
        anchorPoint: const Offset(0, 0),
        locale: const Locale('es', 'PE'),
      );

      if (picked != null) {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onTap: () {
            if (onError != null && isError) {
              onError!();
              ScaffoldMessenger.of(context).clearSnackBars();
            }
            selectDate(context);
          },
          controller: controller,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode ? const Color(textDark) : const Color(textLight),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 12,
              color:
                  isDarkMode ? const Color(hintDark) : const Color(hintLight),
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
            ),
            hintText: hintText,
            fillColor:
                isDarkMode ? const Color(fillDark) : const Color(fillLight),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: isError
                  ? const BorderSide(color: Color(borderError), width: 1)
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: isError
                  ? const BorderSide(color: Color(borderError), width: 1)
                  : BorderSide.none,
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
                    size: 24,
                  )
                : Icon(
                    Icons.calendar_today_outlined,
                    color: isDarkMode
                        ? const Color(iconDark)
                        : const Color(iconLight),
                    size: 24,
                  ),
          ),
          readOnly: true,
          validator: validator,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
