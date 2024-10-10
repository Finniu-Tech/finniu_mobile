import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectableSupportDropdownItem extends HookConsumerWidget {
  const SelectableSupportDropdownItem({
    super.key,
    required this.options,
    required this.selectController,
    required this.hintText,
    required this.validator,
    required this.itemSelectedValue,
    this.onError,
    this.isError = false,
  });

  final List<String> options;
  final TextEditingController selectController;
  final String hintText;
  final String? Function(String?)? validator;
  final String? itemSelectedValue;
  final bool isError;
  final VoidCallback? onError;

  final int hintDark = 0xFFB3B3B3;
  final int hintLight = 0xffB3B3B3;
  final int fillDark = 0xFF212121;
  final int fillLight = 0xFFFFFFFF;
  final int iconDark = 0xFFA2E6FA;
  final int iconLight = 0xFF0D3A5C;
  final int textSelectDark = 0xFFFFFFFF;
  final int textSelectLight = 0xFF000000;
  final int dividerDark = 0xFF535050;
  final int dividerLight = 0xFFD9D9D9;
  final int dropdownColorDark = 0xFF212121;
  final int dropdownColorLight = 0xFFFFFFFF;
  final int borderColorDark = 0xFF292828;
  final int borderColorLight = 0xFFD9D9D9;
  final int borderError = 0xFFED1C24;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final ValueNotifier<bool> reload = useState(false);
    final list = options.toSet();

    return DropdownButtonFormField<String>(
      selectedItemBuilder: (context) {
        return list
            .map(
              (item) => Text(
                item,
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode
                      ? Color(textSelectDark)
                      : Color(textSelectLight),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  overflow: TextOverflow.ellipsis,
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
        size: 24,
        color: Colors.transparent,
      ),
      value: selectController.text.isNotEmpty ? selectController.text : null,
      hint: Text(
        hintText,
        style: TextStyle(
          fontSize: 12,
          color: isDarkMode ? Color(hintDark) : Color(hintLight),
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          overflow: TextOverflow.ellipsis,
        ),
      ),
      decoration: InputDecoration(
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
        suffixIcon: Icon(
          Icons.keyboard_arrow_down,
          size: 24,
          color: isError
              ? Color(borderError)
              : isDarkMode
                  ? Color(iconDark)
                  : Color(iconLight),
        ),
      ),
      iconSize: 24,
      dropdownColor:
          isDarkMode ? Color(dropdownColorDark) : Color(dropdownColorLight),
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
                          ? Color(textSelectDark)
                          : Color(textSelectLight),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                  if (option == selectController.text)
                    Icon(
                      Icons.check_circle_outline,
                      size: 24,
                      color: isDarkMode ? Color(iconDark) : Color(iconLight),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Divider(
                color: isDarkMode ? Color(dividerDark) : Color(dividerLight),
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
