import 'package:finniu/domain/entities/dead_line.dart';
import 'package:finniu/presentation/providers/dead_line_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProviderSelectableDropdownInvest extends HookConsumerWidget {
  const ProviderSelectableDropdownInvest({
    super.key,
    required this.selectController,
    required this.validator,
    required this.itemSelectedValue,
    this.onError,
    this.isError = false,
  });

  final bool isError;
  final VoidCallback? onError;
  final TextEditingController selectController;

  final String? Function(String?)? validator;
  final String? itemSelectedValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    final AsyncValue<List<DeadLineEntity>> deadlinesList =
        ref.watch(deadLineFutureProvider);

    return deadlinesList.when(
      data: (data) {
        data.sort((a, b) => a.value.compareTo(b.value));
        return SelectableDeadlinesDropdownItem(
          isDarkMode: isDarkMode,
          title: " Plazo ",
          onError: onError,
          isError: isError,
          itemSelectedValue: selectController.text,
          options: data,
          selectController: selectController,
          hintText: "Seleccione su plazo de inversión",
          validator: validator,
        );
      },
      loading: () {
        return SelectableDeadlinesDropdownItem(
          isDarkMode: isDarkMode,
          title: " Plazo ",
          itemSelectedValue: selectController.text,
          options: const [],
          selectController: selectController,
          hintText: "Cargando...",
          validator: validator,
          isLoading: true,
        );
      },
      error: (error, stack) {
        return SelectableDeadlinesDropdownItem(
          isDarkMode: isDarkMode,
          title: " Plazo ",
          itemSelectedValue: selectController.text,
          options: const [],
          selectController: selectController,
          hintText: "Seleccione su plazo de inversión",
          validator: validator,
        );
      },
    );
  }
}

class SelectableDeadlinesDropdownItem extends HookConsumerWidget {
  const SelectableDeadlinesDropdownItem({
    super.key,
    this.isLoading = false,
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

  final List<DeadLineEntity> options;
  final TextEditingController selectController;
  final String title;
  final String hintText;
  final String? Function(String?)? validator;
  final String? itemSelectedValue;
  final bool isError;
  final bool isDarkMode;
  final VoidCallback? onError;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    final ValueNotifier<bool> reload = useState(false);
    final list = options.toSet();
    return DropdownButtonFormField<String>(
      selectedItemBuilder: (context) {
        return list
            .map(
              (item) => Text(
                item.name,
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
      validator: validator,
      onTap: () {
        if (onError != null && isError) {
          onError!();
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
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
        suffixIcon: isLoading
            ? const SizedBox(
                width: 10,
                height: 10,
                child: CircularLoader(
                  width: 5,
                  height: 5,
                ),
              )
            : Icon(
                Icons.keyboard_arrow_down,
                size: 24,
                color: isError
                    ? const Color(borderError)
                    : isDarkMode
                        ? const Color(iconDark)
                        : const Color(iconLight),
              ),
      ),
      dropdownColor: isDarkMode
          ? const Color(dropdownColorDark)
          : const Color(dropdownColorLight),
      items: list.map((option) {
        return DropdownMenuItem<String>(
          value: option.uuid,
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
              option.name,
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
        reload.value = !reload.value;
      },
    );
  }
}
