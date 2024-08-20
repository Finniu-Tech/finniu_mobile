import 'package:finniu/constants/country.dart';
import 'package:finniu/domain/entities/form_select_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
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
                      fontSize: 14,
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

class ProviderSelectableDropdownItem extends ConsumerWidget {
  const ProviderSelectableDropdownItem({
    super.key,
    required this.selectController,
    required this.hintText,
    required this.validator,
    required this.itemSelectedValue,
    required this.regionsSelectProvider,
  });

  final TextEditingController selectController;
  final String hintText;
  final String? Function(String?)? validator;
  final String? itemSelectedValue;
  final AutoDisposeFutureProvider<GeoLocationResponseV2> regionsSelectProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<GeoLocationResponseV2> geoLocationResponse =
        ref.watch(regionsSelectProvider);

    return geoLocationResponse.when(
      data: (data) {
        return SelectableGeoLocationDropdownItem(
          itemSelectedValue: selectController.text,
          options: data.regions,
          selectController: selectController,
          hintText: hintText,
          validator: validator,
        );
      },
      loading: () {
        return SelectableGeoLocationDropdownItem(
          itemSelectedValue: selectController.text,
          options: const [],
          selectController: selectController,
          hintText: "Cargando...",
          validator: validator,
          isLoading: true,
        );
      },
      error: (error, stack) {
        return SelectableGeoLocationDropdownItem(
          itemSelectedValue: selectController.text,
          options: [
            GeoLocationItemV2(
              id: "Error de carga",
              name: "Error de carga",
            ),
          ],
          selectController: selectController,
          hintText: hintText,
          validator: validator,
        );
      },
    );
  }
}

class SelectableGeoLocationDropdownItem extends ConsumerWidget {
  const SelectableGeoLocationDropdownItem({
    super.key,
    required this.options,
    required this.selectController,
    required this.hintText,
    required this.validator,
    required this.itemSelectedValue,
    this.isLoading = false,
  });

  final List<GeoLocationItemV2> options;
  final TextEditingController selectController;
  final String hintText;
  final String? Function(String?)? validator;
  final String? itemSelectedValue;
  final bool isLoading;

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
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return DropdownButtonFormField<String>(
      selectedItemBuilder: (context) {
        return options
            .map(
              (item) => Text(
                item.name,
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
      validator: validator,
      icon: isLoading
          ? const CircularLoader(
              width: 10,
              height: 10,
            )
          : Icon(
              Icons.keyboard_arrow_down,
              size: 24,
              color: isDarkMode ? Color(iconDark) : Color(iconLight),
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
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option.id,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode
                          ? Color(textSelectDark)
                          : Color(textSelectLight),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                  if (option.id == selectController.text)
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
      },
    );
  }
}

class GetFunctionSelectableDropdownItem extends StatefulWidget {
  const GetFunctionSelectableDropdownItem({
    super.key,
    required this.selectController,
    required this.hintText,
    required this.validator,
    required this.itemSelectedValue,
  });

  final TextEditingController selectController;
  final String hintText;
  final String? Function(String?)? validator;
  final String? itemSelectedValue;

  @override
  State<GetFunctionSelectableDropdownItem> createState() =>
      _GetFunctionSelectableDropdownItemState();
}

class _GetFunctionSelectableDropdownItemState
    extends State<GetFunctionSelectableDropdownItem> {
  late Future<List<String>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries = loadListStringCountriesFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: futureCountries,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SelectableGeoLocationDropdownItem(
            itemSelectedValue: widget.selectController.text,
            options: const [],
            selectController: widget.selectController,
            hintText: "Cargando...",
            validator: widget.validator,
            isLoading: true,
          );
        } else if (snapshot.hasError) {
          return SelectableGeoLocationDropdownItem(
            itemSelectedValue: widget.selectController.text,
            options: [
              GeoLocationItemV2(
                id: "Error de carga",
                name: "Error de carga",
              ),
            ],
            selectController: widget.selectController,
            hintText: widget.hintText,
            validator: widget.validator,
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SelectableGeoLocationDropdownItem(
            itemSelectedValue: widget.selectController.text,
            options: [
              GeoLocationItemV2(
                id: "01",
                name: "Peru",
              ),
            ],
            selectController: widget.selectController,
            hintText: widget.hintText,
            validator: widget.validator,
          );
        }

        return SelectableDropdownItem(
          itemSelectedValue: widget.selectController.text,
          options: snapshot.data!,
          selectController: widget.selectController,
          hintText: "Selecciona el país de residencia",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor seleccione un país';
            }
            return null;
          },
        );
      },
    );
  }
}
