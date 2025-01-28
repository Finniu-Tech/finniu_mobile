import 'package:finniu/constants/colors/home_v4_colors.dart';
import 'package:finniu/domain/entities/rates_entity.dart';
import 'package:finniu/presentation/providers/rates_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ChangeContainer extends ConsumerWidget {
  const ChangeContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratesAsync = ref.watch(ratesProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      child: ratesAsync.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
        data: (ratesResponse) {
          final sunatRate = ratesResponse.rates.firstWhere((rate) => rate.source == "SUNAT");
          final rextieRate = ratesResponse.rates.firstWhere((rate) => rate.source == "REXTIE");

          return Column(
            children: [
              TitleChange(
                timestamp: ratesResponse.timestamp,
              ),
              const SizedBox(height: 10),
              ChangeSunat(rate: sunatRate),
              ChangeRextie(rate: rextieRate),
            ],
          );
        },
      ),
    );
  }
}

class ChangeSunat extends ConsumerWidget {
  final RateEntity rate;
  const ChangeSunat({super.key, required this.rate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Color(isDarkMode ? HomeV4Colors.sunatContainerDark : HomeV4Colors.sunatContainerLight),
        border: Border.all(
          width: 1.0,
          color: isDarkMode ? const Color(HomeV4Colors.changeBorderDark) : const Color(HomeV4Colors.changeBorderLight),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/home_v4/sunat_logo_${isDarkMode ? "dark" : "light"}.png",
            width: 64,
            height: 35,
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextPoppins(
                text: "Compra",
                fontSize: 7,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.sunatTextDark,
                textLight: HomeV4Colors.sunatTextLight,
              ),
              TextPoppins(
                text: rate.buyRate.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.sunatTextDark,
                textLight: HomeV4Colors.sunatTextLight,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextPoppins(
                text: "Venta",
                fontSize: 7,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.sunatTextDark,
                textLight: HomeV4Colors.sunatTextLight,
              ),
              TextPoppins(
                text: rate.sellRate.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.sunatTextDark,
                textLight: HomeV4Colors.sunatTextLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChangeRextie extends ConsumerWidget {
  final RateEntity rate;
  const ChangeRextie({super.key, required this.rate});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color:
            isDarkMode ? const Color(HomeV4Colors.rextieContainerDark) : const Color(HomeV4Colors.rextieContainerLight),
        border: Border.all(
          width: 1.0,
          color: isDarkMode
              ? const Color(HomeV4Colors.rextieContainerDark)
              : const Color(HomeV4Colors.rextieContainerLight),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/home_v4/rextie_logo_${isDarkMode ? "dark" : "light"}.png",
            width: 64,
            height: 35,
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextPoppins(
                text: "Compra",
                fontSize: 7,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.rextieTextDark,
                textLight: HomeV4Colors.rextieTextLight,
              ),
              TextPoppins(
                text: rate.buyRate.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.rextieBuyDark,
                textLight: HomeV4Colors.rextieBuyLight,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextPoppins(
                text: "Venta",
                fontSize: 7,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.rextieTextDark,
                textLight: HomeV4Colors.rextieTextLight,
              ),
              TextPoppins(
                text: rate.sellRate.toString(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textDark: HomeV4Colors.rextieTextDark,
                textLight: HomeV4Colors.rextieTextLight,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => {
                // Navigator.pushNamed(context, '/v4/push_to_url', arguments: 'www.rextie.com'),
                // Navigator.pushNamed(context, '/v4/push_to_url', arguments: 'https://rextie.com/')
                // launchUrl(Uri.parse('https://rextie.com/'))
                launchUrl(Uri.parse('https://rextie.com/'))
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(HomeV4Colors.rextieButtonDark)
                      : const Color(HomeV4Colors.rextieButtonDark),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: TextPoppins(
                    text: "Cambia ya!",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textDark: HomeV4Colors.rextieButtonTextDark,
                    textLight: HomeV4Colors.rextieButtonTextLight,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TitleChange extends ConsumerWidget {
  final DateTime timestamp;
  const TitleChange({
    super.key,
    required this.timestamp,
  });
  String getFormattedTimeAgo(DateTime timestamp) {
    try {
      // Asegurarnos que ambas fechas estén en UTC
      final utcTimestamp = timestamp.toUtc();
      final nowUtc = DateTime.now().toUtc();

      // Asegurarnos de calcular la diferencia en la dirección correcta
      final difference = utcTimestamp.difference(nowUtc).abs();
      print('diferencia en minutos: ${difference.inMinutes}');

      // Formatear el tiempo
      if (difference.inMinutes < 60) {
        return '${difference.inMinutes} min';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hrs';
      } else {
        return '${difference.inDays} días';
      }
    } catch (e) {
      print('Error calculando tiempo: $e');
      return '-- min'; // valor por defecto en caso de error
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeAgo = getFormattedTimeAgo(timestamp);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TextPoppins(
          text: "Tipo de cambio hoy!",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          textDark: HomeV4Colors.changeTitleDark,
          textLight: HomeV4Colors.changeTitleLight,
        ),
        Row(
          children: [
            const Icon(Icons.access_time_outlined, size: 15),
            const SizedBox(width: 5),
            TextPoppins(
              text: "Actualizado  $timeAgo",
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ],
    );
  }
}
