import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

class SelecDropdownInvest extends StatelessWidget {
  const SelecDropdownInvest({
    super.key,
    required this.options,
    required this.selectController,
    required this.hintText,
    required this.validator,
    required this.itemSelectedValue,
    required this.title,
    required this.isDarkMode,
    this.onError,
    this.isError = false,
  });

  final List<String> options;
  final TextEditingController selectController;
  final String title;
  final String hintText;
  final String? Function(String?)? validator;
  final String? itemSelectedValue;
  final bool isError;
  final bool isDarkMode;
  final VoidCallback? onError;

  @override
  Widget build(BuildContext context) {
    const int hintDark = 0xFFFFFFFF;
    const int hintLight = 0xFF535050;
    const int fillDark = 0xFF0E0E0E;
    const int fillLight = 0xFffDCF5FC;
    const int iconDark = 0xFFA2E6FA;
    const int iconLight = 0xFF0D3A5C;
    const int textSelectDark = 0xFFFFFFFF;
    const int textSelectLight = 0xFF000000;

    const int dropdownColorDark = 0xFF1B1B1B;
    const int dropdownColorLight = 0xFffDCF5FC;

    const int borderColorDark = 0xFFA2E6FA;
    const int borderColorLight = 0xFF0D3A5C;
    const int itemContainerDark = 0xFFA2E6FA;
    const int itemContainerLight = 0xFFA2E6FA;
    const int itemContainerSelectDark = 0xFF0D3A5C;
    const int itemContainerSelectLight = 0xFF0D3A5C;
    const int itemText = 0xFF0D3A5C;
    const int itemTextSelect = 0xFFFFFFFF;

    const int borderError = 0xFFED1C24;
    // const int errorDark = 0xff181818;
    // const int errorLight = 0xffA2E6FA;

    return DropdownButtonFormField<String>(
      selectedItemBuilder: (context) {
        return options
            .map(
              (item) => Text(
                item,
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode
                      ? const Color(textSelectDark)
                      : const Color(textSelectLight),
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
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              color: option == itemSelectedValue
                  ? isDarkMode
                      ? const Color(itemContainerSelectDark)
                      : const Color(itemContainerSelectLight)
                  : isDarkMode
                      ? const Color(itemContainerDark)
                      : const Color(itemContainerLight),
            ),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 14,
                color: option == itemSelectedValue
                    ? const Color(itemTextSelect)
                    : const Color(itemText),
                fontWeight: FontWeight.w400,
                fontFamily: "Poppins",
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        selectController.text = newValue!;
      },
    );
  }
}
