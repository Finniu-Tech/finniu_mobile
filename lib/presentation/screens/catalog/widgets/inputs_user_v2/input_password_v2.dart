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
    required this.isError,
    required this.onError,
    required this.onTap,
    this.focusNode,
    required this.onFocusChanged,
  });

  final FocusNode? focusNode;
  final VoidCallback onTap;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isError;
  final VoidCallback? onError;
  final Function(bool) onFocusChanged;

  // Colores
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
    final isObscure = useState(true);
    const int iconDark = 0xFFA2E6FA;
    const int iconLight = 0xFF000000;

    final localFocusNode = focusNode ?? FocusNode();
    useEffect(
      () {
        localFocusNode.addListener(() {
          onFocusChanged(localFocusNode.hasFocus);
        });
        return localFocusNode.dispose;
      },
      [localFocusNode],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          focusNode: localFocusNode, // Asignar FocusNode
          onTap: () {
            if (onError != null && isError) {
              onError!();
              ScaffoldMessenger.of(context).clearSnackBars();
            }
            onTap();
          },
          controller: controller,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode ? Color(textDark) : Color(textLight),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
          ),
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
            suffixIcon: IconButton(
              icon: isError
                  ? Icon(
                      Icons.error_outline,
                      color: Color(borderError),
                      size: 24,
                    )
                  : isObscure.value
                      ? SvgPicture.asset(
                          "assets/svg_icons/eye_close.svg",
                          width: 20,
                          height: 20,
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
