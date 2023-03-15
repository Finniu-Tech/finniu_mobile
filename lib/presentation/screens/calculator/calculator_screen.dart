import 'package:dropdown_search/dropdown_search.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
class Calculator extends HookConsumerWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

  final themeProvider = ref.watch(settingsNotifierProvider);
    final showError = useState(false);
    final namesController = useTextEditingController();
    final docNumberController = useTextEditingController();
    final departmentController = useTextEditingController();
    final districtController = useTextEditingController();
    final addressController = useTextEditingController();
    final civilStateController = useTextEditingController();

    final _formKey = GlobalKey<FormState>();

    final percentage = useState(0.0);
    final percentageString = useState('0%');

    final imageFile = useState('');



    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      
        Row(
          children: [
            SizedBox(
              child: Container(
                alignment: Alignment.topCenter,
                child: Container(width :MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    'Simula tu inversion de manera rapida y sencilla',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color:Color(primaryDark),
                    ),
                  ),
                ),
              ),
            ),
            
          ],
        ),
    

        SizedBox(
          height: 15.0,
        ),
       
          SizedBox(
                  width: 224,
                  // height: 38,
                  child: TextFormField(
                    key: const Key('address'),
                    controller: addressController,
                    onChanged: (value) {
                      _calculatePercentage('address');
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Ingrese su monto de inversion',
                      suffixIconConstraints: BoxConstraints(
                        maxHeight: 38,
                        minWidth: 38,
                      ),
                      label: Text(
                        "Monto",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                if (showError.value) ...[
                  const Text(
                    'No se pudo completar el registro',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red,
                    ),
                  ),
                ],
                const SizedBox(height: 28),
                SizedBox(
                  width: 224,
                  height: 38,
                  child: DropdownSearch<String>(
                    selectedItem: districtController.text != '' ? districtController.text : null,
                    key: const Key('plazo'),
                    onChanged: (value) {
                      districtController.text = value.toString();
                      _calculatePercentage('plazo');
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Plazo',
                      ),
                    ),
                    items: [
                      '6 meses ',
                      '12 meses',
                   
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
                        margin: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
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
                const SizedBox(height: 15),
                if (showError.value) ...[
                  const Text(
                    'No se pudo completar el registro',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red,
                    ),
                  ),
                ],
                const SizedBox(height: 15),
              
                const SizedBox(height: 15),
                SizedBox(
                  width: 224,
                  height: 38,
                  child: DropdownSearch<String>(
                    selectedItem: civilStateController.text != '' ? civilStateController.text : null,
                    key: const Key('selectionrentability'),
                    onChanged: (value) {
                      civilStateController.text = value.toString();
                      _calculatePercentage('selectionrentability');
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Eleccion de Rentabilidad',
                      ),
                    ),
                    items: ['6 meses', '12 meses'],
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
                        margin: const EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
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
                const SizedBox(height: 15),
                if (showError.value) ...[
                  const Text(
                    'No se pudo completar el registro',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.red,
                    ),
                  ),
                ],
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const CustomButton(text: 'Continuar', colorBackground: primaryDark, colorText: whiteText, pushName: '/home_home'),
                ),
      
      
      
      
      
      
      
      ]),
    ));
  }
}

void _calculatePercentage(String s) {
}
