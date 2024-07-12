import 'package:dropdown_search/dropdown_search.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomSelectButton extends HookConsumerWidget {
  final TextEditingController textEditingController;
  final callbackOnChange;
  final List<String>? items;
  final Future<List<String>> Function(String)? asyncItems;
  final String labelText;
  final String? hintText;
  final String? identifier;
  final bool? enabled;
  final double? width;
  final double? height;
  final Color? enableColor;
  final Color? enabledFillColor;
  final Color? disabledFillColor;
  final Color? enabledBorderColor;
  final Color? disabledBorderColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color? dropdownBackgroundColor;
  final Color? dropdownBorderColor;
  final Color? dropdownButtonColor;

  CustomSelectButton({
    Key? key,
    required this.textEditingController,
    this.items,
    this.callbackOnChange,
    required this.labelText,
    this.hintText,
    this.asyncItems,
    this.identifier,
    this.enabled = true,
    this.width,
    this.height,
    this.enableColor,
    this.enabledFillColor,
    this.disabledFillColor,
    this.enabledBorderColor,
    this.disabledBorderColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.dropdownBackgroundColor,
    this.dropdownBorderColor,
    this.dropdownButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final themeProvider = ref.watch(settingsNotifierProvider);

    if (items == null && asyncItems == null) {
      throw ArgumentError("At least one of items and asyncItems must be provided.");
    }

    final Color _enabledFillColor =
        enabledFillColor ?? (currentTheme.isDarkMode ? const Color(backgroundColorDark) : const Color(whiteText));
    final Color _disabledFillColor =
        disabledFillColor ?? (currentTheme.isDarkMode ? const Color(grayText) : const Color(0xffF4F4F4));
    final Color _enabledBorderColor =
        enabledBorderColor ?? (themeProvider.isDarkMode ? const Color(primaryLight) : const Color(primaryDark));
    final Color _disabledBorderColor = disabledBorderColor ?? _enabledBorderColor;
    final Color _selectedItemColor = selectedItemColor ??
        (themeProvider.isDarkMode ? const Color(primaryLight) : const Color(primaryDarkAlternative));
    final Color _unselectedItemColor = unselectedItemColor ??
        (themeProvider.isDarkMode ? const Color(primaryDarkAlternative) : const Color(primaryLight));
    final Color _dropdownBackgroundColor = dropdownBackgroundColor ??
        (themeProvider.isDarkMode ? const Color(primaryDark) : const Color(primaryLightAlternative));
    final Color _dropdownBorderColor =
        dropdownBorderColor ?? (themeProvider.isDarkMode ? const Color(primaryLight) : const Color(primaryDark));
    final Color _dropdownButtonColor =
        dropdownButtonColor ?? (themeProvider.isDarkMode ? const Color(primaryLight) : const Color(primaryDark));

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      constraints: const BoxConstraints(minWidth: 263, maxWidth: 400),
      child: DropdownSearch<String>(
        enabled: enabled ?? false,
        selectedItem: textEditingController.text,
        key: Key(identifier ?? ''),
        onChanged: callbackOnChange,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            filled: true,
            fillColor: enabled == true ? _enabledFillColor : _disabledFillColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: _enabledBorderColor,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: _disabledBorderColor,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        items: items ?? [],
        asyncItems: asyncItems,
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          itemBuilder: (context, item, isSelected) => Container(
            decoration: BoxDecoration(
              color: isSelected ? _selectedItemColor : _unselectedItemColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                width: 2,
                color: _dropdownBorderColor,
              ),
            ),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
              right: 15,
              left: 15,
            ),
            child: Text(
              item.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected
                    ? (themeProvider.isDarkMode ? const Color(primaryDark) : Colors.white)
                    : (themeProvider.isDarkMode ? Colors.white : const Color(primaryDark)),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          menuProps: MenuProps(
            backgroundColor: _dropdownBackgroundColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: _dropdownBorderColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
          ),
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              suffixIcon: const Icon(Icons.search),
              label: const Text('Buscar'),
            ),
          ),
        ),
        dropdownButtonProps: DropdownButtonProps(
          color: _dropdownButtonColor,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
