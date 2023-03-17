import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:image_picker/image_picker.dart';

class FinanceStep2 extends HookConsumerWidget {
  final fieldValues = <String, dynamic>{
    'names': null,
    'docNumber': null,
    'department': null,
    'district': null,
    'address': null,
    'civilState': null,
  };
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeProvider = Provider.of<SettingsProvider>(context, listen: false);
    final themeProvider = ref.watch(settingsNotifierProvider);
    final currentTheme = ref.watch(settingsNotifierProvider);
    final showError = useState(false);
    final namesController = useTextEditingController();
    final amountController = useTextEditingController();
    final incomeController = useTextEditingController();
    final _formKey = GlobalKey<FormState>();

    final percentage = useState(0.0);
    final percentageString = useState('0%');

    final imageFile = useState('');

    String mapControllerKey(String key) {
      if (key == 'names') {
        return namesController.text;
      } else if (key == 'docNumber') {
        return amountController.text;
      } else if (key == 'department') {
        return incomeController.text;
  
      } else {
        return '';
      }
    }

    void _calculatePercentage(String key) {
      fieldValues[key] = mapControllerKey(key);

      // Count the number of non-empty fields
      int count = fieldValues.values.where((value) => value != null && value.toString().isNotEmpty).length;

      // Update the progress bar with the percentage of completed fields
      if (count == 0) {
        percentage.value = 0.0;
      } else {
        percentage.value = (count / 6.0);
      }
      percentageString.value = '${(percentage.value * 100).round()}%';
    }

    return CustomScaffoldReturnLogo(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const SizedBox(
                  height: 25,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
              image: AssetImage('assets/images/finance.png'),
              width: 40, // ajusta el tamaño de la imagen según tus necesidades
              height: 40,
            ),
              
                      Text(
                        'Mis finanzas',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode ? Color(primaryLight) : Color(primaryDark),
                        ),
                      ),
                
                  ],
                 ),
                 
                    Column(
                      children: [
                        Text(
                            'Ingresa tu ingreso mensual',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 14,
                   
                              color: themeProvider.isDarkMode ? Color(whiteText) : Color(blackText),
                            ),
                          ),
                      ],
                    ),
                 SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 224,
                  child: TextFormField(
                    controller: amountController,
                    key: const Key('amount'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                   
                    onEditingComplete: () {
                      _calculatePercentage('amount');
                    },
          
                    decoration: const InputDecoration(
                      hintText: 'Ingrese el monto de sus ingreos',
                      label: Text("Monto"),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
               
               
                    Column(
                      children: [
                        Container(width: 185,
                          child: Text(
                              'Elige cuanto de tus ingreso destinarias para invertir',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                height: 1.4,
                                fontSize: 14,
                                         
                                color: themeProvider.isDarkMode ? Color(whiteText) : Color(blackText),
                              ),
                            ),
                        ),
                      ],
                    ),
                 SizedBox(height: 10,),
              
                SizedBox(
                  width: 224,
                  height: 39,
                  child: DropdownSearch<String>(
                    selectedItem: incomeController.text != '' ? incomeController.text : null,
                    key: const Key('income'),
                    onChanged: (value) {
                     incomeController.text = value.toString();
                      _calculatePercentage('income');
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Ingresos',
                      ),
                    ),
                    items: ['10-15%', '15-20%'],
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      itemBuilder: (context, item, isSelected) => Container(
                        decoration: BoxDecoration(
                          color: Color(
                            isSelected ? (themeProvider.isDarkMode ? primaryLight : primaryDarkAlternative) : (themeProvider.isDarkMode ? primaryDarkAlternative : primaryLight),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.all(
                            width: 2,
                            color: themeProvider.isDarkMode ? const Color(primaryDarkAlternative) : const Color(primaryLight), // Aquí especificas el color de borde deseado
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
                              isSelected ? (themeProvider.isDarkMode ? primaryDark : Colors.white.value) : (themeProvider.isDarkMode ? Colors.white.value : primaryDark),
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
                ),
             
             SizedBox(height: 20,),
             
             const CircularFinanceSimulation(),
               

             



           ]
                )
                )
                )
                )
                )
                ;
                }
                }
  

                class CircularFinanceSimulation extends ConsumerWidget {
  const CircularFinanceSimulation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: CircularPercentIndicator(
        circularStrokeCap: CircularStrokeCap.round,
        radius: 80.0,
        lineWidth: 10.0,
        percent: 0.5,
        center: CircleAvatar(
          radius: 50,
          backgroundColor: themeProvider.isDarkMode
              ? Color(backgroundColorDark)
              : Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            
              SizedBox(height: 8),
              Text(
                "S/4000",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode
                        ? Color(whiteText)
                        : Color(blackText)),
              ),
             Container(
               child: Text(
                  "Total de ingresos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Color(whiteText)
                          : Color(blackText)),
                ),
             ),
    
            
            ],
          ),
        ),
        progressColor:
            Color(themeProvider.isDarkMode ? primaryLight : primaryDark),
        backgroundColor:
            Color(themeProvider.isDarkMode ? primaryDark : primaryLight),
        fillColor: themeProvider.isDarkMode
            ? Color(backgroundColorDark)
            : Colors.white,
      ),
    );
  }
}

