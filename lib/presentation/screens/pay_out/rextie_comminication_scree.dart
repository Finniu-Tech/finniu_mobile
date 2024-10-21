import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/pay_out/widgets/title_subtitle_pay.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RextieComminicationScree extends StatelessWidget {
  const RextieComminicationScree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 70,
        child: Column(
          children: [
            ButtonSvgIconInvestment(
              icon: "assets/svg_icons/two_chats_icon.svg",
              text: 'Cuéntanos que te parece',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height,
            child: const ComunicationBody(),
          ),
        ),
      ),
    );
  }
}

class ComunicationBody extends ConsumerWidget {
  const ComunicationBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const String title = '✨ ¡Buenas noticias!';
    const String subTitle = 'Hemos unidos fuerzas con Rextie';
    const String textRich =
        'Gracias a nuestra alianza con Rextie, tus pagos de tus rentabilidades mensuales serán automáticos y procesados más rápidos.';
    const String textSpan =
        '¡Disfruta de la comodidad y la seguridad que esto trae para ti! 💰';

    const int richDart = 0xffFFFFFF;
    const int richLight = 0xff000000;
    const int spanDart = 0xffA2E6FA;
    const int spanLight = 0xff03253E;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const PayOutIconsRow(),
        const SizedBox(
          height: 10,
        ),
        const TextPoppins(
          text: title,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          align: TextAlign.center,
        ),
        const TextPoppins(
          text: subTitle,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          align: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: textRich,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode
                      ? const Color(richDart)
                      : const Color(richLight),
                ),
              ),
              TextSpan(
                text: textSpan,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? const Color(spanDart)
                      : const Color(spanLight),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
