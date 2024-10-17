import 'package:finniu/domain/entities/pay_out_entity.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubTitlePayOut extends StatelessWidget {
  const SubTitlePayOut({
    super.key,
    required this.status,
  });
  final PayOutStatus status;
  @override
  Widget build(BuildContext context) {
    const String textFailed =
        "Estamos revisando el proceso de tu pago. Te avisaremos pronto con más detalles.";
    const String textPending =
        "Puedes seguir el progreso de tu transacción. Gracias a nuestra alianza con Rextie, lo procesamos de manera segura y automática.";
    const String textSuccess =
        "Gracias a nuestra alianza con Rextie, el pago se ha realizado con éxito. Revisa los detalles del comprobante de pago en el apartado de Mi Calendario";
    Widget getSubtitleStatus(PayOutStatus status) {
      switch (status) {
        case PayOutStatus.failed:
          return const TextPoppins(
            text: textFailed,
            fontSize: 14,
            lines: 4,
            align: TextAlign.center,
          );
        case PayOutStatus.pending:
          return const TextPoppins(
            text: textPending,
            fontSize: 14,
            lines: 4,
            align: TextAlign.center,
          );
        case PayOutStatus.success:
          return const TextPoppins(
            text: textSuccess,
            fontSize: 14,
            lines: 4,
            align: TextAlign.center,
          );
        default:
          return const TextPoppins(
            text: textFailed,
            fontSize: 14,
            lines: 4,
            align: TextAlign.center,
          );
      }
    }

    return getSubtitleStatus(status);
  }
}

class TitlePayOut extends StatelessWidget {
  const TitlePayOut({
    super.key,
    required this.status,
  });
  final PayOutStatus status;

  @override
  Widget build(BuildContext context) {
    const int textDark = 0xffA2E6FA;

    return TextPoppins(
      text: getTitle(status),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      lines: 2,
      textDark: textDark,
    );
  }
}

class IconsRow extends ConsumerWidget {
  const IconsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff03253E;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/rextie_image_${isDarkMode ? "dark" : "light"}.png",
          width: 70,
          height: 45,
        ),
        const SizedBox(
          width: 10,
        ),
        SvgPicture.asset(
          "assets/svg_icons/refresh_icon.svg",
          width: 20,
          height: 20,
          color: isDarkMode ? const Color(iconDark) : const Color(iconLight),
        ),
        const SizedBox(
          width: 10,
        ),
        Image.asset(
          "assets/images/logo_finniu_${isDarkMode ? "dark" : "light"}.png",
          width: 70,
          height: 45,
        ),
      ],
    );
  }
}
