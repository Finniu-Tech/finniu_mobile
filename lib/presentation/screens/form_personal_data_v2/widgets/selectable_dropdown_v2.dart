import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectableDropdownItem extends ConsumerStatefulWidget {
  const SelectableDropdownItem({
    super.key,
    required this.options,
    required this.selectController,
    required this.hintText,
    required this.validator,
    required this.itemSelectedValue,
  });
  final List<String> options;
  final TextEditingController selectController;
  final String hintText;
  final String? Function(String?)? validator;
  final String? itemSelectedValue;

  @override
  SelectableDropdownItemState createState() => SelectableDropdownItemState();
}

class SelectableDropdownItemState
    extends ConsumerState<SelectableDropdownItem> {
  final int hintDark = 0xFF989898;
  final int hintLight = 0xFF989898;
  final int fillDark = 0xFF222222;
  final int fillLight = 0xFFF7F7F7;
  final int iconDark = 0xFFA2E6FA;
  final int iconLight = 0xFF0D3A5C;
  final int textSelectDark = 0xFFFFFFFF;
  final int textSelectLight = 0xFF000000;
  final int dividerDark = 0xFF535050;
  final int dividerLight = 0xFFD9D9D9;
  final int dropdownColorDark = 0xFF222222;
  final int dropdownColorLight = 0xFFF7F7F7;
  final int borderColorDark = 0xFFA2E6FA;
  final int borderColorLight = 0xFF0D3A5C;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return DropdownButtonFormField<String>(
      selectedItemBuilder: (context) {
        return widget.options
            .map(
              (item) => Text(
                item,
                style: TextStyle(
                  fontSize: 14,
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
      validator: widget.validator,
      icon: Icon(
        Icons.keyboard_arrow_down,
        size: 24,
        color: isDarkMode ? Color(iconDark) : Color(iconLight),
      ),
      value: widget.selectController.text.isNotEmpty
          ? widget.selectController.text
          : null,
      hint: Text(
        widget.hintText,
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
      ),
      dropdownColor:
          isDarkMode ? Color(dropdownColorDark) : Color(dropdownColorLight),
      items: widget.options.map((String option) {
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
                      fontSize: 12,
                      color: isDarkMode
                          ? Color(textSelectDark)
                          : Color(textSelectLight),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                  if (option == widget.selectController.text)
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
        setState(() {
          widget.selectController.text = newValue!;
        });
      },
    );
  }
}
