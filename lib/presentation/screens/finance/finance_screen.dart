
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dropdown_search/dropdown_search.dart';

class FinanceScreen extends HookConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeProvider = Provider.of<SettingsProvider>(context, listen: false);
    final themeProvider = ref.watch(settingsNotifierProvider);
    final currentTheme = ref.watch(settingsNotifierProvider);
    final amountController = useTextEditingController();
    final incomeController = useTextEditingController();

    return Scaffold(
       bottomNavigationBar: const BottomNavigationBarHome(),
       appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          leading: themeProvider.isDarkMode
              ? const CustomReturnButton(
                  colorBoxdecoration: primaryDark,
                  colorIcon: primaryDark,
                )
              : const CustomReturnButton(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: SizedBox(
                width: 70,
                height: 70,
                child: themeProvider.isDarkMode
                    ? Image.asset('assets/images/logo_small_dark.png')
                    : Image.asset('assets/images/logo_small.png'),
              ),
            ),
          ],
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
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
                    color: themeProvider.isDarkMode ? const Color(primaryLight) : const Color(primaryDark),
                  ),
                ),
          
            ],
           ),
           
              Text(
                  'Ingresa tu ingreso mensual',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
             
                    color: themeProvider.isDarkMode ? const Color(whiteText) : const Color(blackText),
                  ),
                ),
           const SizedBox(
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
              decoration: const InputDecoration(
                hintText: 'Ingrese el monto de sus ingreos',
                label: Text("Monto"),
              ),
            ),
          ),
          const SizedBox(height: 10),

              SizedBox(width: 185,
                child: Text(
                    'Elige cuanto de tus ingreso destinarias para invertir',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 14,
                               
                      color: themeProvider.isDarkMode ? const Color(whiteText) : const Color(blackText),
                    ),
                  ),
              ),
           const SizedBox(height: 10,),
        
          SizedBox(
            width: 224,
            height: 39,
            child: DropdownSearch<String>(
              selectedItem: incomeController.text != '' ? incomeController.text : null,
              key: const Key('income'),
              onChanged: (value) {
              
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
                    suffixIcon: const Icon(Icons.search),
                    label: const Text('Buscar'),
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
          const SizedBox(height: 28),
        
           Container(
           width: 350,
           height: 127,
           padding: EdgeInsets.all(20),
           alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.expand,
               children: <Widget>[
                 Container(
                   width: 220,
                   height: 127,
                   decoration: BoxDecoration(
                     
                     color: currentTheme.isDarkMode
                         ? const Color(primaryLightAlternative)
                         : const Color(secondary),
                     borderRadius: BorderRadius.circular(15),
                     border: Border.all(
                       color: const Color(secondary),
                     ),
                   
                   
                   ),
                   child: Text(
                     textAlign: TextAlign.justify,
                     style: TextStyle(
                       fontSize: 12,
                       height: 1,
                       color: 
                      Color(blackText),
                       fontWeight: FontWeight.w500,
                     ),
                     "En instantes te mostraremos el gráfico de tus ingresos y algunos tips",
                                        
                   ),
                 ),
                 Positioned(
                  top: 30,
                  left: -30,
                  child: Container(height: 80, width: 80, child: Image.asset("assets/images/finance_2.png", height: 66, width: 66,)),
                  //  child: Container(
                  //    width: 60,
                  //    height: 64,
                  //    decoration: const BoxDecoration(
                  //      image: DecorationImage(
                  //        image: AssetImage(
                  //            "assets/images/finance_2.png",),
                  //        fit: BoxFit.contain,
                  //      ),
                  //    ),
                  //  ),
                 ),
                 Image.asset('assets/images/clock.png', height: 40, width: 40,)
                ],
             ),
           ),
         const SizedBox(height: 20,),
        Container(
      width: 320,
      height: 137,decoration: BoxDecoration(
            color:   themeProvider.isDarkMode ? const Color(primaryDark) : const Color(primaryLightAlternative),
            borderRadius: BorderRadius.circular(10),
          ),
        
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
      
      image: DecorationImage(
        image: AssetImage('assets/images/finance.png'),
        fit: BoxFit.cover,
      ),
      ),
        ),
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
      Container(width: 180,
      
        child: Text(textAlign:TextAlign.justify,
          'Multiplica tu dinero desde hoy',
          style: TextStyle(
          
            fontWeight: FontWeight.bold,color: themeProvider.isDarkMode ? const Color(whiteText) : const Color(primaryDark),
            fontSize: 16,
          ),
        ),
      ),
      
      const SizedBox(height: 16),
       SizedBox(
        width: 161,
        height: 38,
        child: TextButton(
         
          onPressed: () {
            Navigator.pushNamed(context, '/finance_step2');
          },
          child: const Text(
            'Ver planes',
          ),
        ),
      ),
      ],
        ),
      ],
      ),
        ),
      ],
          
         
          
         
        
      ),
      );
  }
}

