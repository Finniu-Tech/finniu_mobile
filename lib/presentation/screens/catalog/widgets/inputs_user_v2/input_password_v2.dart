import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputPasswordFieldUserProfile extends HookConsumerWidget {
  const InputPasswordFieldUserProfile({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;

  final int hintDark = 0xFF989898;
  final int hintLight = 0xFF989898;
  final int fillDark = 0xFF222222;
  final int fillLight = 0xFFF7F7F7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isObscure = useState(true);
    const int iconDark = 0xFFA2E6FA;
    const int iconLight = 0xFF000000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: isObscure.value,
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
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: isObscure.value
                  ? SvgPicture.asset(
                      "assets/svg_icons/eye_close.svg",
                      width: 24,
                      height: 24,
                      color: isDarkMode
                          ? const Color(iconDark)
                          : const Color(iconLight),
                    )
                  : Icon(
                      Icons.visibility,
                      color: isDarkMode
                          ? const Color(iconDark)
                          : const Color(iconLight),
                      size: 24,
                    ),
              onPressed: () {
                isObscure.value = !isObscure.value;
              },
            ),
          ),
          validator: validator,
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
