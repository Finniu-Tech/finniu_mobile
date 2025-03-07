import 'package:finniu/constants/country.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InputPhoneUserProfile extends ConsumerWidget {
  const InputPhoneUserProfile({
    super.key,
    required this.controller,
    required this.countryController,
    required this.hintText,
    required this.validator,
    required this.onError,
    this.isError = false,
    this.isNumeric = false,
  });

  final TextEditingController controller;
  final TextEditingController countryController;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isNumeric;
  final VoidCallback? onError;
  final bool isError;

  final int hintDark = 0xFF989898;
  final int hintLight = 0xFF989898;
  final int fillDark = 0xFF222222;
  final int fillLight = 0xFFF7F7F7;
  final int textDark = 0xFFFFFFFF;
  final int textLight = 0xFF000000;
  final int borderColorDark = 0xFFA2E6FA;
  final int borderColorLight = 0xFF0D3A5C;
  final int prefixTextDark = 0xffFFFFFF;
  final int prefixTextLight = 0xff000000;
  final int iconColorDark = 0xffFFFFFF;
  final int iconColorLight = 0xff000000;
  final int borderError = 0xFFED1C24;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onTap: () {
            if (onError != null && isError) {
              onError!();
              ScaffoldMessenger.of(context).clearSnackBars();
            }
          },
          controller: controller,
          style: TextStyle(
            fontSize: 12,
            color: isDarkMode ? Color(textDark) : Color(textLight),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 12,
              color: isDarkMode ? Color(hintDark) : Color(hintLight),
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
            ),
            hintText: hintText,
            filled: true,
            fillColor: isDarkMode ? Color(fillDark) : Color(fillLight),
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
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(
                color: Color(borderError),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              borderSide: BorderSide(
                color: Color(borderError),
                width: 1,
              ),
            ),
            prefixIcon: PrefixIconCountries(
              isDarkMode: isDarkMode,
              iconColorDark: iconColorDark,
              iconColorLight: iconColorLight,
              countryController: countryController,
            ),
            suffixIcon: isError
                ? Icon(
                    Icons.error_outline,
                    color: Color(borderError),
                    size: 24,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.transparent,
                    size: 24,
                  ),
          ),
          validator: validator,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class PrefixIconCountries extends StatefulWidget {
  const PrefixIconCountries({
    super.key,
    required this.isDarkMode,
    required this.iconColorDark,
    required this.iconColorLight,
    required this.countryController,
  });

  final TextEditingController countryController;
  final bool isDarkMode;
  final int iconColorDark;
  final int iconColorLight;

  @override
  State<PrefixIconCountries> createState() => _PrefixIconCountriesState();
}

class _PrefixIconCountriesState extends State<PrefixIconCountries> {
  Country _selectedCountry = Country(
    name: "Peru",
    dialCode: "+51",
    code: "PE",
    flag: "🇵🇪",
  );

  Future<List<Country>> _loadCountries() async {
    return await loadCountriesFromFile();
  }

  @override
  void initState() {
    super.initState();
    widget.countryController.text = _selectedCountry.dialCode;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Country>>(
      future: _loadCountries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading countries'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No countries available'));
        }

        final countries = snapshot.data!;

        return GestureDetector(
          onTap: () {
            selectCountry(
              context,
              widget.isDarkMode,
              countries,
              (selectedCountry) {
                setState(() {
                  _selectedCountry = selectedCountry;
                  widget.countryController.text = selectedCountry.dialCode;
                });
              },
            );
          },
          child: SizedBox(
            width: 95,
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 15),
                TextPoppins(
                  text: _selectedCountry.flag,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(width: 3),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: widget.isDarkMode
                      ? Color(widget.iconColorDark)
                      : Color(widget.iconColorLight),
                ),
                const SizedBox(width: 3),
                TextPoppins(
                  text: _selectedCountry.dialCode,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void selectCountry(
  BuildContext context,
  bool isDarkMode,
  List<Country> countries,
  Function(Country) onCountrySelected,
) {
  const int backgroundColorDark = 0xff1A1A1A;
  const int backgroundColorLight = 0xffFFFFFF;
  const int textSelectDark = 0xFFFFFFFF;
  const int textSelectLight = 0xFF000000;
  const int dividerDark = 0xFF535050;
  const int dividerLight = 0xFFD9D9D9;

  showModalBottomSheet(
    context: context,
    builder: (context) {
      final TextEditingController searchController = TextEditingController();
      List<Country> filteredCountries = countries;

      void filterCountries(String query) {
        if (query.isEmpty) {
          filteredCountries = countries;
        } else {
          filteredCountries = countries.where((country) {
            return country.name.toLowerCase().contains(query.toLowerCase()) ||
                country.dialCode.contains(query);
          }).toList();
        }
      }

      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: isDarkMode
                  ? const Color(backgroundColorDark)
                  : const Color(backgroundColorLight),
            ),
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Buscar país',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (query) {
                      setState(() {
                        filterCountries(query);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = filteredCountries[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onCountrySelected(
                            country,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  country.flag,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: isDarkMode
                                        ? const Color(textSelectDark)
                                        : const Color(textSelectLight),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        country.dialCode,
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
                                      Text(
                                        country.name,
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
                                    ],
                                  ),
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
                            const SizedBox(height: 4),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
