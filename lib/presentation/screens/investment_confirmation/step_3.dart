
import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_1.dart';
import 'package:finniu/presentation/screens/investment_confirmation/widgets/image_circle.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Step_3 extends ConsumerWidget {
  const Step_3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return CustomScaffoldReturnLogo(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const StepBar(),
            const SizedBox(height: 8,),
         Container(
            width: MediaQuery.of(context).size.width,
            height: 292,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/man.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
         
          Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height * 0.5,
            color: const Color(primaryDark),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children:[
       
           SizedBox(width: 300,
             child: Text(textAlign:TextAlign.justify,
                     "Hola Mari, la validación de tu transferencia será confirmada en 30 min,te enviaremos una notificación cuando validemos tu inversión.",
                     style: TextStyle(
                      
                       height: 1.9,
                       color: Colors.white,
                       fontSize: 16,
                     ),
             ),
           ),
           SizedBox(height: 16),
           Padding(
             padding: const EdgeInsets.only(left: 40),
             child: Container(alignment: Alignment.topLeft,
               child: Text(
                     "Gracias por tu comprensión!",
                     style: TextStyle(
                       color: Color(primaryLight),
                       fontSize: 16,
                     ),
               ),
             ),
           ),
         ],
       ),
),
             
       
    ],
      ),
    ),
  );
}

}




