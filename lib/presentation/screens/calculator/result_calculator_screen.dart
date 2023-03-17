import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/image_circle.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultCalculator extends HookConsumerWidget {
  const ResultCalculator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    final themeProvider = ref.watch(settingsNotifierProvider);
    var MontoController;
    final amountController = useTextEditingController();

    final termController = useTextEditingController();

    final percentage = useState(0.0);
    return Scaffold(
            backgroundColor: Colors.white,
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
          ]),
      
      
    
      
          bottomNavigationBar: const BottomNavigationBarHome(),
      
      body: SingleChildScrollView(
        child: Column(
          
          children: <Widget>[

             
          //  SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              width: 300,
              height: 40,
              child: Text(
                'Plan Origen',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(Theme.of(context).colorScheme.secondary.value),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 100,
                  // width: MediaQuery.of(context).size.width * 0.90,
                  // width: double.maxFinite,
                  alignment: Alignment.center,
        
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircularImageSimulation(),
                      Positioned(
                        right: 90,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 59.49,
                            height: 31.15,
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: currentTheme.isDarkMode
                                  ? const Color(primaryLight)
                                  : const Color(primaryDark),
                              border: Border.all(
                                width: 4,
                                color: currentTheme.isDarkMode
                                    ? const Color(primaryLight)
                                    : const Color(primaryDark),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // color: Color(primaryDark),
        
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    '6%',
                                    style: TextStyle(
                                      color: currentTheme.isDarkMode
                                          ? const Color(primaryDark)
                                          : const Color(primaryLight),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Rentabilidad',
                                  style: TextStyle(
                                    color: currentTheme.isDarkMode
                                        ? const Color(blackText)
                                        : const Color(whiteText),
                                    fontSize: 7,
                                  ),
                                ),
                             
                              
                             
                             
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               
              ],
        ),
             SizedBox(height: 15,),
             
         Container(width: 210,
           child: Text(
                                    textAlign: TextAlign.center,
                                    'Rentabilidad prioriza la estabilidad generando una rentabilidad moderada.Si recien empiezas a invertir, este plan es perfecto para ti.',
                                    style: TextStyle(
                                      height: 1.5,
                                      color: currentTheme.isDarkMode
                                          ? const Color(whiteText)
                                          : const Color(primaryDark),
                                      fontSize: 12,
                                    ),
                                  ),
         ),
             
             SizedBox(height: 20,),
             Padding(
         padding: const EdgeInsets.all(10.0),
         child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
          width:   136,
          height: 81,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(primaryLight),
            boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
              'Inversion inicial',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Color(blackText),
              ),
            ),
            Text(
              'S/550',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(primaryDark),
              ),
            ),
            
            ],
          ),
           ),
           const SizedBox(width: 17),
           Container(
          width:  136,
          height:  81,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(secondary),
            boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
              'En 6 meses tendrias',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10,
                color: Color(blackText),
              ),
            ),
            Text(
              'S/583',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(primaryDark),
              ),
            ),
            
          
           
           ],
          ),
           ),
        ],
             ),
             ),
           SizedBox(height: 5,),   
        
        Container(
        decoration: BoxDecoration(
          color: currentTheme.isDarkMode
                                  ? const Color(primaryDarkAlternative)
                                  : const Color(primaryLightAlternative),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 320,
        height: 180,
        child: 
        
        Row(mainAxisAlignment: MainAxisAlignment.center,
         
               
          children: [
            Container(alignment: Alignment.center,
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("S/560",style: TextStyle(fontSize: 13,color: currentTheme.isDarkMode
                                  ? const Color(whiteText)
                                  : const Color(blackText),fontWeight: FontWeight.bold ),),
            Text("S/530",style: TextStyle(fontSize: 13,color:currentTheme.isDarkMode
                                  ? const Color(whiteText)
                                  : const Color(blackText),fontWeight: FontWeight.bold ),),
            Text("S/515",style: TextStyle(fontSize: 13,color:currentTheme.isDarkMode
                                  ? const Color(whiteText)
                                  : const Color(blackText),fontWeight: FontWeight.bold),),
          ],
        ),
            ),
            SizedBox(width: 20,),
            GraphContainerWidget(currentTheme: currentTheme),
          ],
        )),
        
        
        
        ])));
   
        
    
  }
}

class GraphContainerWidget extends StatelessWidget {
  const GraphContainerWidget({
    super.key,
    required this.currentTheme,
  });

  final SettingsProviderState currentTheme;

  @override
  Widget build(BuildContext context) {
    return Container(alignment:Alignment.center ,
      // padding: const EdgeInsets.all(10.0),
      child: Row(mainAxisAlignment:MainAxisAlignment.center,
      
        children: [
          Container(
            width: 50,
            height: 155,
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                                ? const Color(primaryDark)
                                : const Color(primaryLight),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
         SizedBox(width: 35,),
          Container(
            width: 50,
            height: 155,
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                                ? const Color(primaryDark)
                                : const Color(primaryLight),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
         
         SizedBox(width: 35,),
          Container(
            width: 50,
            height: 155,
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                                ? const Color(primaryDark)
                                : const Color(primaryLight),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

class _calculatePercentage {
}

class CircularImageSimulation extends ConsumerWidget {
  const CircularImageSimulation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return Container(
    alignment: Alignment.center,
      child: CircularPercentIndicator(
        circularStrokeCap: CircularStrokeCap.round,
        radius: 75.0,
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
              Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  child: Image.asset(
                    'assets/result/money.png',
                    width: 55,
                    height: 60,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "6 meses",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.isDarkMode
                        ? Color(primaryLight)
                        : Color(primaryDark)),
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


