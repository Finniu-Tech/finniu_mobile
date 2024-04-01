import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/widgets/buttons.dart';
import 'package:flutter/material.dart';

class SimulationCardWidget extends StatelessWidget {
  const SimulationCardWidget({
    super.key,
    required this.currentTheme,
  });

  final SettingsProviderState currentTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      // height: ,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              constraints: const BoxConstraints(maxWidth: 330, maxHeight: 147),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: currentTheme.isDarkMode
                    ? const Color(primaryLightAlternative)
                    : const Color(primaryLightAlternative),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 144,
                width: 141,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/home/person.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 320,
                height: 147,
                padding: const EdgeInsets.only(
                  left: 60,
                  top: 20,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Simula tu inversión aquí",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(primaryDark),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Descubre como simular el",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(grayText2),
                      ),
                    ),
                    Text(
                      "retorno de tu inversión",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(grayText2),
                      ),
                    ),
                    CustomButtonRoundedDark(
                      pushName: '/calculator_tool',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
