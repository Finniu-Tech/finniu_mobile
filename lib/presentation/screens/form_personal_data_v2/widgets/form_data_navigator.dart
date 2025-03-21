import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/cupertino.dart';

class FormDataNavigator extends StatelessWidget {
  const FormDataNavigator({
    super.key,
    required this.addData,
    required this.continueLater,
    this.continueLaterBool = true,
    this.finishBool = false,
  });
  final VoidCallback? addData;
  final VoidCallback? continueLater;
  final bool continueLaterBool;
  final bool finishBool;
  final int textDark = 0xffB3B3B3;
  final int textLight = 0xff0D3A5C;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonInvestment(
            text: finishBool ? "Terminar" : "Siguente",
            onPressed: addData,
          ),
          const SizedBox(height: 10),
          continueLaterBool
              ? GestureDetector(
                  onTap: continueLater,
                  child: TextPoppins(
                    text: "Continuar más tarde",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textDark: textDark,
                    textLight: textLight,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
