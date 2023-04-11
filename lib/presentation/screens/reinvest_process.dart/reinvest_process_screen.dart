import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReinvestProcess extends StatefulWidget {
  const ReinvestProcess({super.key});

  @override
  State<ReinvestProcess> createState() => _ReinvestProcessState();
}

class _ReinvestProcessState extends State<ReinvestProcess> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const SizedBox(
                height: 10,
              ),
              
              const Text(textAlign:TextAlign.center,
                'Planes de inversion que puedes reinvertir',
                style: TextStyle(
                  color: 
                      Color(primaryDark),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
    
    const SizedBox(height: 20,),
            SizedBox(
                width: 320,
                height: 102,
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 224,
                        height: 111,
                        padding:  const EdgeInsets.only(
                          left: 45,
                          right: 15,
                          top: 15,
                          bottom: 15,
                        ),
                        decoration: BoxDecoration(
                          color:
                               Color(primaryDark),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color(primaryDark),
                          ),
                        ),
                        child: const Text(
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 12,
                            color: 
                                 Color(whiteText),
                            fontWeight: FontWeight.w500,
                          ),
                          "Hola Mari recuerda que solo peudes reinvertir 15 dias antes de culminar tu plan de inversion.",
                        ),
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: 25,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 88,
                          width: 86,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/icon_arrow.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
     SizedBox(height: 10,),
      const Text(textAlign:TextAlign.center,
                'Planes finalizados',
                style: TextStyle(
                  color: 
                      Color(primaryDark),
                  fontSize: 14,
            
                ),
              ),
    const SizedBox(height: 10,),
    const TableCard(),
    const SizedBox(height: 10,),
    const Text(
                      'Historial de planes en curso',
                      style: TextStyle(
                        color:
                        
                             Color(primaryDark),
                        fontSize: 14,
                  
                      ), 
                    ),
    const SizedBox(height: 10,),
      const TableCard(),
   
    ],
    ),
    ),
    ),
    );
  }
}






class TableCard extends ConsumerWidget {
  const TableCard({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
     final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(

width: MediaQuery.of(context).size.width * 0.9,
  height: 200,
  decoration: BoxDecoration(

    color: currentTheme.isDarkMode
                         ? Colors.transparent
                  : const Color(whiteText),
    border: Border.all(
      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
      width: 2,
    ),
   borderRadius: BorderRadius.circular(20), 

  ),
          
          child: Column(
    mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
             Padding(
               padding: const EdgeInsets.only(left: 15),
               child: Text(
                      'Plan Origen',
                      style: TextStyle(
                        color:currentTheme.isDarkMode
                            ? const Color(primaryLight)
                            : const Color(primaryDark),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ), 
                    ),
             ),
            Spacer(),
            const SizedBox(width: 16,),
             Padding(
               padding: const EdgeInsets.only(right: 10),
               child: Container(width: 69,height: 24,decoration: BoxDecoration(color: Color(primaryDark), borderRadius: BorderRadius.circular(10)),
                 child: Padding(
                   padding: const EdgeInsets.all(6.0),
                   child: GestureDetector( onTap: () {
    Navigator.pushNamed(context, '/reinvest');
  },
                     child: Text( textAlign:TextAlign.center,
                            'Reinvertir',
                            style: TextStyle(
                              fontSize: 11,
                          
                              color:currentTheme.isDarkMode
                                  ? const Color(whiteText)
                                  : const Color(whiteText),
                            ),
                                
                         ),
                   ),
                 ),
               ),
             )
      
      ],
      ),
const SizedBox(height: 10,),
 Padding(
   padding: EdgeInsets.only(left: 17),
   child: Row(
     children: [
         Image.asset(
                     alignment: Alignment.center,
                     'assets/images/circle_green.png',
                    height: 15,
                    
                   ),
      const SizedBox(width: 5,),
       const Text(
                          'En Curso',
                          style: TextStyle(
                            fontSize: 11,
                        
                            color: Color(grayText2)
                          ),
 
            ),
     ],
   ),
 ),






      const SizedBox(height: 10),
      Column(mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               
                Text(
                  'Inicio:29 Mayo',
                  style: TextStyle(
                    color:currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(blackText),
                 fontSize: 7,
                 fontWeight: FontWeight.bold,
                  ),
                  ),
                    
               
                      const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                                          'Final:29 Mayo 2023',
                                          style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                                          ),
                                        ),
                      ),
              ],
            ),
          ) ,
       
       
         


      const SizedBox(height: 15,),
       Row(mainAxisAlignment: MainAxisAlignment.center,
         children: [
      
            Column(
              children: [
                  Container(width: 83.95,height: 43,decoration: BoxDecoration(color: Color(primaryLight), borderRadius: BorderRadius.circular(10)),
         child: Padding(
           padding: const EdgeInsets.all(6.0),
           child: Column(
             children: [
               Text( textAlign:TextAlign.center,
                      'Monto inicial',
                      style: TextStyle(
                        fontSize: 7,
                    
                        color:currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                          
                   ),
             Text( textAlign:TextAlign.center,
                      'S/550',
                      style: TextStyle(
                        fontSize: 14,
                    
                        color:currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                          
                   ), ],
           ),
         ),
       )
              ],
            ),
           
           SizedBox(width: 20,),
           Column(
             children:  [
    Container(width: 83.95,height: 43,decoration: BoxDecoration(color: Color(secondary), borderRadius: BorderRadius.circular(10)),
         child: Padding(
           padding: const EdgeInsets.all(6.0),
           child: Column(
             children: [
               Text( textAlign:TextAlign.center,
                      'En 6 meses tendrias',
                      style: TextStyle(
                        fontSize: 7,
                    
                        color:currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                          
                   ),
             Text( textAlign:TextAlign.center,
                      'S/583',
                      style: TextStyle(
                        fontSize: 14,
                    
                        color:currentTheme.isDarkMode
                            ? const Color(whiteText)
                            : const Color(blackText),
                      ),
                          
                   ),],
           ),
         ),
       )
            ],
           ),
         ],
       ),
 
       ],
      ),
      const SizedBox(height: 10,),
      Container(alignment: Alignment.center,
        
        width: 69,height: 24,decoration: BoxDecoration(color: const Color(primaryDark), borderRadius: BorderRadius.circular(10)),
               child: Padding(
                 padding: const EdgeInsets.all(6.0),
                 child: Text( textAlign:TextAlign.center,
                        'Ver mas',
                        style: TextStyle(
                          fontSize: 11,
                      
                          color:currentTheme.isDarkMode
                              ? const Color(whiteText)
                              : const Color(whiteText),
                        ),
                            
                     ),
               ),
             ) 
             
             
             
             
             
             ],
          ),
          );


    
  }
}

            
  