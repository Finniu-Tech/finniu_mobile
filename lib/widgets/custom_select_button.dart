import 'package:dropdown_search/dropdown_search.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomSelectButton extends HookConsumerWidget {
  final textEditingController;
  final callbackOnChange;
  final List<String>? items;
  final Future<List<String>> Function(String)? asyncItems;
  final String labelText;
  final String? hintText;
  final String? identifier;
  const CustomSelectButton({
    super.key,
    required this.textEditingController,
    this.items,
    this.callbackOnChange,
    required this.labelText,
    this.hintText,
    this.asyncItems,
    this.identifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // required this.currentStep,
    if (items == null && asyncItems == null) {
      throw ArgumentError("At least one of item and async must be provided.");
    }
    final themeProvider = ref.watch(settingsNotifierProvider);
    return SizedBox(
      width: 224,
      height: 39,
      child: DropdownSearch<String>(
        // selectedItem: TextEditingController.text != 'TextEditingController' ? TextEditingController().text : null,
        key: Key(identifier ?? ''),
        onChanged: (value) => callbackOnChange(value),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
          ),
        ),
        items: items ?? [],
        asyncItems: asyncItems,
        popupProps: PopupProps.menu(
          showSelectedItems: true,
          itemBuilder: (context, item, isSelected) => Container(
            decoration: BoxDecoration(
              color: Color(
                isSelected
                    ? (themeProvider.isDarkMode
                        ? primaryLight
                        : primaryDarkAlternative)
                    : (themeProvider.isDarkMode
                        ? primaryDarkAlternative
                        : primaryLight),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(
                width: 2,
                color: themeProvider.isDarkMode
                    ? const Color(primaryDarkAlternative)
                    : const Color(
                        primaryLight), // Aquí especificas el color de borde deseado
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
                color: Color(
                  isSelected
                      ? (themeProvider.isDarkMode
                          ? primaryDark
                          : Colors.white.value)
                      : (themeProvider.isDarkMode
                          ? Colors.white.value
                          : primaryDark),
                ),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          menuProps: MenuProps(
            backgroundColor: Color(
              themeProvider.isDarkMode ? primaryDark : primaryLightAlternative,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color(
                  themeProvider.isDarkMode ? primaryLight : primaryDark,
                ),
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
              fillColor: Theme.of(context).backgroundColor,
              suffixIcon: Icon(Icons.search),
              label: Text('Buscar'),
            ),
          ),
        ),
        dropdownButtonProps: DropdownButtonProps(
          color: Color(
            themeProvider.isDarkMode ? primaryLight : primaryDark,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );

    ;
  }
}
