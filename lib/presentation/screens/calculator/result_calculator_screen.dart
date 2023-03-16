import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/image_circle.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultCalculator extends HookConsumerWidget {
  const ResultCalculator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    var MontoController;

    return CustomScaffoldReturnLogo(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
   
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.centerLeft,
              width: 390,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width * 0.60,
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
           Expanded(
             child: Container(
          width:   MediaQuery.of(context).size.width * 0.01,
          height:  MediaQuery.of(context).size.height * 0.07,
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
           ),
           const SizedBox(width: 10),
           Expanded(
             child: Container(
          width:   MediaQuery.of(context).size.width * 0.1,
          height:  MediaQuery.of(context).size.height * 0.07,
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
           ),
         ],
       ),
       ),
              
            ],
         
              
                  
              
    )));
            
    ;
          
           
          
        
    
  }
}

class CircularImageSimulation extends ConsumerWidget {
  const CircularImageSimulation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final themeProvider = ref.watch(settingsNotifierProvider);
    return Container(
      margin: EdgeInsets.only(left: 140.0),
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
              )
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
