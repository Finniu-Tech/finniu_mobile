import 'package:finniu/constants/colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmptyHistoryMessage extends ConsumerWidget {
  bool is_history_screen;
  EmptyHistoryMessage({super.key, required this.is_history_screen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            child: Row(
              children: [
                Text(
                  ' Mis inversiones 💸 ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(Theme.of(context).colorScheme.secondary.value),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/calendar_page');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/icons/calendar.png',
                      width: 20,
                      height: 20,
                      color: currentTheme.isDarkMode
                          ? const Color(primaryLight)
                          : const Color(primaryDark),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        if (is_history_screen) ...[
          const HistorialButtons()
        ] else ...[
          const RentabilidadButtons()
        ],
        const SizedBox(
          height: 26,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const ContainerHome(),
        ),
      ],
    );
  }
}

class ContainerHome extends ConsumerWidget {
  const ContainerHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Container(
        height: MediaQuery.of(context).size.height * 0.29,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/layerblur.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 180,
            constraints: const BoxConstraints(
              maxWidth: 390,
              maxHeight: 180,
            ),
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                  ? const Color(primaryLightAlternative)
                  : const Color(0xffFFEEDD),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Image.asset(
                    'assets/images/bomb.png',
                    width: 98,
                    height: 98,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Comienza a multiplicar tu dinero con nosotros',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(blackText),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Visita nuestros planes de inversión',
                          style:
                              TextStyle(fontSize: 11, color: Color(blackText)),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              // Button action
                              Navigator.pushNamed(context, '/plan_list');
                            },
                            child: const Text('Ver Planes'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class RentabilidadButtons extends ConsumerWidget {
  const RentabilidadButtons({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/process_investment');
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 40,
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                  ? const Color(primaryLight)
                  : const Color(primaryDark),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "Rentabilidad",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: currentTheme.isDarkMode
                      ? const Color(primaryDark)
                      : const Color(whiteText),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/investment_history');
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 40,
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(primaryLightAlternative),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "Mi historial",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(primaryDark),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HistorialButtons extends ConsumerWidget {
  const HistorialButtons({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentTheme = ref.watch(settingsNotifierProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/process_investment');
            Navigator.pop(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 40,
            decoration: BoxDecoration(
              color: currentTheme.isDarkMode
                  ? const Color(primaryDark)
                  : const Color(primaryLightAlternative),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "Rentabilidad",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: currentTheme.isDarkMode
                      ? const Color(whiteText)
                      : const Color(primaryDark),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 40,
          decoration: BoxDecoration(
            color: currentTheme.isDarkMode
                ? const Color(primaryLight)
                : const Color(primaryDark),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Center(
            child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, '/investment_history');
                },
                child: Text(
                  "Mi historial",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: currentTheme.isDarkMode
                        ? const Color(primaryDark)
                        : const Color(whiteText),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
