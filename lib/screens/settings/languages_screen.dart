import 'package:dropdown_search/dropdown_search.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/providers/settings_provider.dart';
import 'package:finniu/screens/settings/widgets.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';

class LanguagesStart extends ConsumerWidget {
  const LanguagesStart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    // final currentTheme = Provider.of<SettingsProvider>(context, listen: false);
    var languageController;
    return CustomScaffoldReturnLogo(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/languages/land.png',
                  width: 125,
                  height: 150,
                ),
                // SizedBox(width: 10),

                Text(
                  "Lenguajes",
                  style: TextStyle(fontSize: 24, color: currentTheme.isDarkMode ? const Color(primaryLight) : const Color(primaryDark), fontWeight: FontWeight.bold),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      IconContainer(
                        image: 'assets/languages/translate.png',
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text('Configuración de lenguaje', style: TextStyle(fontSize: 14, color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText), fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              )),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 3,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: currentTheme.isDarkMode ? const Color(gradient_primary) : const Color(gradient_secondary_option),
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Idioma seleccionado de la aplicación',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: currentTheme.isDarkMode ? const Color(whiteText) : const Color(blackText),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 224,
              height: 39,
              child: DropdownSearch<String>(
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Idioma',
                  ),
                ),
                items: [
                  'Español',
                  'Portugués',
                  'Inglés',
                ],
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  itemBuilder: (context, item, isSelected) => Container(
                    decoration: BoxDecoration(
                      color: Color(isSelected ? primaryDark : primaryLight),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
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
                        color: Color(isSelected ? Colors.white.value : primaryDark),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  menuProps: const MenuProps(
                    backgroundColor: Color(primaryLightAlternative),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(primaryDark),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),
                  ),
                  showSearchBox: true,
                  searchFieldProps: const TextFieldProps(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.search),
                      label: Text('Buscar'),
                    ),
                  ),
                ),
                dropdownButtonProps: const DropdownButtonProps(
                  color: Color(primaryDark),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
