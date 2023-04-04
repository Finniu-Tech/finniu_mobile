import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';
class InvestmentProcess extends StatelessWidget {
  const InvestmentProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
      
      
        body: SingleChildScrollView(
          
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                
                 
                SizedBox(
                  child: Text(
                            'Mis inversiones',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(Theme.of(context).colorScheme.secondary.value),
                            ),
                          ),
                ),
                ],
                ),
            ),
            ),
            );
              }
              }