import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectableDropdownAccounts extends HookConsumerWidget {
  const SelectableDropdownAccounts({
    super.key,
    required this.options,
    required this.selectController,
    required this.hintText,
    required this.validator,
    required this.itemSelectedValue,
    required this.title,
    this.isRow = false,
    this.onError,
    this.isError = false,
  });
  final bool isRow;
  final List<String> options;
  final TextEditingController selectController;
  final String hintText;
  final String? Function(String?)? validator;
  final String? itemSelectedValue;
  final bool isError;
  final VoidCallback? onError;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int hintDark = 0xFF828282;
    const int hintLight = 0xFF535050;
    const int fillDark = 0xFF1A1A1A;
    const int fillLight = 0xFFFFFFFF;
    const int iconDark = 0xFFA2E6FA;
    const int iconLight = 0xFF0D3A5C;
    const int textSelectDark = 0xFFFFFFFF;
    const int textSelectLight = 0xFF000000;
    const int dividerDark = 0xFF535050;
    const int dividerLight = 0xFFD9D9D9;
    const int dropdownColorDark = 0xFF222222;
    const int dropdownColorLight = 0xFFF7F7F7;
    const int borderColorDark = 0xFFA2E6FA;
    const int borderColorLight = 0xFF0D3A5C;
    const int borderError = 0xFFED1C24;
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final ValueNotifier<bool> reload = useState(false);
    final list = options.toSet();

    return DropdownButtonFormField<String>(
      selectedItemBuilder: (context) {
        return list
            .map(
              (item) => SizedBox(
                width: isRow ? 60 : null,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode
                        ? const Color(textSelectDark)
                        : const Color(textSelectLight),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Poppins",
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
            .toList();
      },
      onTap: () {
        if (onError != null && isError) {
          onError!();
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      validator: validator,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        size: 20,
        color: Colors.transparent,
      ),
      value: selectController.text.isNotEmpty ? selectController.text : null,
      hint: Text(
        hintText,
        style: TextStyle(
          fontSize: isRow ? 10 : 12,
          color: isDarkMode ? const Color(hintDark) : const Color(hintLight),
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          overflow: TextOverflow.ellipsis,
        ),
      ),
      decoration: InputDecoration(
        label: TextPoppins(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          textDark: 0xFFA2E6FA,
          textLight: 0xFF0D3A5C,
        ),
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
        suffixIcon: Icon(
          Icons.keyboard_arrow_down,
          size: 24,
          color: isError
              ? const Color(borderError)
              : isDarkMode
                  ? const Color(iconDark)
                  : const Color(iconLight),
        ),
      ),
      iconSize: 24,
      dropdownColor: isDarkMode
          ? const Color(dropdownColorDark)
          : const Color(dropdownColorLight),
      items: list.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode
                          ? const Color(textSelectDark)
                          : const Color(textSelectLight),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                  if (option == selectController.text)
                    Icon(
                      Icons.check_circle_outline,
                      size: 20,
                      color: isDarkMode
                          ? const Color(iconDark)
                          : const Color(iconLight),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Divider(
                color: isDarkMode
                    ? const Color(dividerDark)
                    : const Color(dividerLight),
                height: 1,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        selectController.text = newValue!;
        reload.value = !reload.value;
      },
    );
  }
}
