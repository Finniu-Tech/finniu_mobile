import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showChangePassword(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(
      content: _EmailContainer(),
    ),
  );
}

class _EmailContainer extends ConsumerWidget {
  const _EmailContainer();

  final String title = "Te enviamos un correo";
  final String subTitle =
      "Enviamos un correo para que puedas cambiar tu contraseña";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff272727;
    const int backgroundLight = 0xffBFF1FF;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 325,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(backgroundDark)
                  : const Color(backgroundLight),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.all(15.0),
            width: 70,
            height: 70,
            child: Image.asset(
              "assets/images/email_image.png",
              width: 40,
              height: 40,
            ),
          ),
          TextPoppins(
            text: title,
            fontSize: 20,
            isBold: true,
          ),
          TextPoppins(
            text: subTitle,
            fontSize: 14,
            isBold: false,
            lines: 2,
            align: TextAlign.center,
          ),
          ButtonInvestment(
            text: "Entendido",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
