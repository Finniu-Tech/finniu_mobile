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

   final currentTheme = ref.watch(settingsNotifierProvider);
   final themeProvider = ref.watch(settingsNotifierProvider);
   
   final showError = useState(false);
    final rentabilityController = useTextEditingController();
    
    final termController = useTextEditingController();
    final amountController = useTextEditingController();

    final _formKey = GlobalKey<FormState>();

    final percentage = useState(0.0);
    final percentageString = useState('0%');

    final imageFile = useState('');



List<Color> dayColors = [Color (gradient_primary), Color (gradient_secondary)];
List<Color> nightColors = [Color(primaryDark), Color (primaryLight)]; 



    return Scaffold(
       body: Container(alignment: Alignment.centerRight,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: currentTheme.isDarkMode ? nightColors : dayColors)

      ),
    
  
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  
                  child: Image.asset(
                    'assets/images/logo_small.png',
                    width: 70,
                    height:70,
                    color:currentTheme.isDarkMode
                  ? const Color(whiteText)
                  : const Color(blackText),
                  ),
                ),
              ),

        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Container(
                alignment: Alignment.center,
                child: Container(width :MediaQuery.of(context).size.width * 0.8,
                  child: Text(textAlign:TextAlign.center,
                    'Simula tu inversión de manera rápida y sencilla',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
                    ),
                  ),
                ),
              ),
            ),
            
          ],
        ),
    
           Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Image.asset(
                    'assets/welcome/welcome1.png',
                    width: 180,
                    height: 260,
                  ),
                ),
              ),


          SizedBox(
                  width: 224,
                  // height: 38,
                  child: TextFormField(
                    key: const Key('address'),
                    controller: amountController,
                    onChanged: (value) {
                      _calculatePercentage('address');
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                      hintText: 'Ingrese su monto de inversion',
                       hintStyle: TextStyle(color: currentTheme.isDarkMode
                  ? const Color(whiteText)
                  : const Color(grayText1),),
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
              
            const SizedBox(height: 15),
                 SizedBox(
                  width: 224,
                  height: 39,
                  child: DropdownSearch<String>(
                    selectedItem: amountController.text != '' ?  amountController.text : null,
                    key: const Key('term'),
                    onChanged: (value) {
                    amountController.text = value.toString();
                      _calculatePercentage('term');
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Plazo',
                         hintText: 'Seleccione su plazo de inversion',
                      ),
                    ),
                    items: ['6 meses ', '12 meses'],
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
                const SizedBox(height: 15),
              
                const SizedBox(height: 15),
               SizedBox(
                  width: 224,
                  height: 39,
                  child: DropdownSearch<String>(
                    selectedItem: rentabilityController.text != '' ?  rentabilityController.text : null,
                    key: const Key('rentability'),
                    onChanged: (value) {
                    rentabilityController.text = value.toString();
                      _calculatePercentage('rentability');
                    },
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Eleccion de Rentabilidad',
                         hintText: 'Seleccione su eleccion',
                      ),
                    ),
                    items: ['Mensual ', 'Plazo Fijo'],
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
                
                   SizedBox(height: 17),
                
                
                 Container(
  width: 224,
  height: 67,
  color: Color(primaryLightAlternative),
  child: Padding(
    padding: const EdgeInsets.all(14.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            SizedBox(width: 5), // Espacio entre el icono y el texto
            Text(
              'Tu plan recomendado es',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(blackText),
              ),
            ),
                        
      InkWell(
                    onTap: () => showDialog<String>(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        
                        
                        backgroundColor: const Color(primaryDark),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                                            
                        
                        ),
                        
                        
                        content: Stack(
                          children: [
                            Positioned(
                              top: 30,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Image.asset(
                                  'assets/result/money.png',
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ),
                              
                           
                           
                            Positioned(
                              
                              left: 260,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                color: const Color(whiteText),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 100, left: 20, right: 20),
                              child:Column(
                              children:[
      
                                Text(
        'Plan Origen',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(primaryLight),
          height: 1.5,
        ),
      ),
      SizedBox(height: 10,),
                               Text(
                                  textAlign: TextAlign.justify,
                                  'Esta inversion prioriza la estabilidad generando una rentabilidad moderada.Si recien empiezas a invertir, este plan es perfecto para ti.',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(whiteText), height: 1.5, )),
                           ] ),
                                                  
                          
                        )],
                        ),
                      ),
                    ),
                    child: Icon(
                      Icons.quiz_outlined, // Icono que deseas utilizar
                      size: 20, // Tamaño del icono
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark), // Color del icono
                    ),
                  ),
          
            
            ],
    
       
        ),
       Text(
              'Plan Origen',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(primaryDark),
              ),
            ), ],
    ),
  ),
),
     
                 Container(
                  margin:  EdgeInsets.only(top: 20),
                  child: CustomButton(text: 'Continuar', colorBackground: currentTheme.isDarkMode
                  ? (primaryLight)
                  :  primaryDark,     colorText: currentTheme.isDarkMode
                  ? (primaryDark)
                  :  whiteText, pushName: '/calculator_result'), ),
      
      ],
              ),
            ),
      
      
      );
    ;
  }
}

void _calculatePercentage(String s) {
}





