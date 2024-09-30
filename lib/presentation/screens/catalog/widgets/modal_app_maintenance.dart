import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void modalMaintenance(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const _BodyMaintenance();
    },
  );
}

class _BodyMaintenance extends ConsumerWidget {
  const _BodyMaintenance();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const String title = "Finniu esta en mantenimiento";
    const String subTitle =
        "Este Domingo 13 de Abril de 00:00 hasta 5:00 am, la app estará en mantenimiento";
    const int iconColorDark = 0xff272727;
    const int iconColorLight = 0xffBFF1FF;
    const int containerDark = 0xff1A1A1A;
    const int containerLight = 0xffF9FAFA;
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 325,
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(containerDark)
              : const Color(containerLight),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(iconColorDark)
                    : const Color(iconColorLight),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/image_maintenance.png",
                  width: 36,
                  height: 36,
                ),
              ),
            ),
            const SizedBox(
              width: 262,
              child: TextPoppins(
                text: title,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                lines: 2,
                align: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 240,
              child: TextPoppins(
                text: subTitle,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                lines: 3,
                align: TextAlign.center,
              ),
            ),
            ButtonInvestment(
              text: "Entendido",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

void modalErrorSendData(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const _BodyErrorSendData();
    },
  );
}

class _BodyErrorSendData extends ConsumerWidget {
  const _BodyErrorSendData();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const String title = "Lo sentimos";
    const String subTitle =
        "No hemos podido realizar tu operación. Estamos para poder solucionar el inconveniente";
    const int iconColorDark = 0xff272727;
    const int iconColorLight = 0xffBFF1FF;
    const int containerDark = 0xff1A1A1A;
    const int containerLight = 0xffF9FAFA;
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 325,
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(containerDark)
              : const Color(containerLight),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(iconColorDark)
                    : const Color(iconColorLight),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/image_error_send.png",
                  width: 36,
                  height: 36,
                ),
                // child: TextPoppins(
                //   text: "🥹",
                //   fontSize: 40,
                // ),
              ),
            ),
            const SizedBox(
              width: 262,
              child: TextPoppins(
                text: title,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                lines: 2,
                align: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 240,
              child: TextPoppins(
                text: subTitle,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                lines: 3,
                align: TextAlign.center,
              ),
            ),
            ButtonInvestment(
              text: "Entendido",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
