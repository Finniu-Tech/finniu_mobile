import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';

void showErrorGetDetail(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const TextPoppins(
                  text: "Error al solicitar inversion",
                  fontSize: 24,
                ),
                ButtonInvestment(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  text: "Presionar para Mis inversiones",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });
}

void showNotVoucherOrContract(BuildContext context, bool isVoucher) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextPoppins(
                text: "${isVoucher ? "voucher" : "contrato"} no disponible",
                fontSize: 24,
              ),
              ButtonInvestment(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Presionar  para cerrar",
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
