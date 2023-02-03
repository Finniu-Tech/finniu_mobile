import 'package:finniu/constants/colors.dart';
import 'package:finniu/widgets/fonts.dart';
import 'package:finniu/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class SelectRange extends StatefulWidget {
  const SelectRange({super.key});

  @override
  State<SelectRange> createState() => _SelectRangeState();
}

class _SelectRangeState extends State<SelectRange> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffoldReturnLogo(
      body: Center(
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              SizedBox(height: 90),
            ],
          ),
          const TextPoppins(
            text: 'Selecciona tu rango de edad ',
            colorText: primaryDark,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset('assets/investment/star.png'),
          ),
        ]),
      ),
    );

    ;
    ;
  }
}
