import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainerSlide extends HookConsumerWidget {
  const ContainerSlide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    final selectedIndex = useState(0);
    final PageController pageController = PageController();
    const int containerSelectedDark = 0xffA2E6FA;
    const int containerSelectedLight = 0xff0D3A5C;
    const int containerUnselectedDark = 0xff2F2F2F;
    const int containerUnselectedLight = 0xffA2E6FA;
    return HookBuilder(
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    selectedIndex.value = index;
                  },
                  children: const [
                    UploadDocument(),
                    DataSecurity(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedIndex.value == 0
                            ? isDarkMode
                                ? const Color(containerSelectedDark)
                                : const Color(containerSelectedLight)
                            : isDarkMode
                                ? const Color(containerUnselectedDark)
                                : const Color(containerUnselectedLight),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedIndex.value == 1
                            ? isDarkMode
                                ? const Color(containerSelectedDark)
                                : const Color(containerSelectedLight)
                            : isDarkMode
                                ? const Color(containerUnselectedDark)
                                : const Color(containerUnselectedLight),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UploadDocument extends StatelessWidget {
  const UploadDocument({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/document_front_image.png",
                width: 114,
                height: 75,
              ),
              const SizedBox(width: 20),
              Image.asset(
                "assets/images/document_back_image.png",
                width: 114,
                height: 75,
              ),
            ],
          ),
          const SizedBox(height: 20),
          const TextPoppins(
            text: "Sube una Foto de tu DNI",
            fontSize: 16,
            isBold: true,
            align: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const TextPoppins(
            text:
                "Necesitamos una foto clara de ambas caras tu DNI. Asegúrate de que toda la información sea legible.",
            fontSize: 14,
            isBold: false,
            lines: 3,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class DataSecurity extends ConsumerWidget {
  const DataSecurity({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int textDark = 0xffFFFFFF;
    const int textLight = 0xff000000;
    const int textRichDark = 0xffA2E6FA;
    const int textRichLight = 0xff0D3A5C;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/data_security.png",
                width: 186,
                height: 100,
              ),
            ],
          ),
          const SizedBox(height: 10),
          const TextPoppins(
            text: "Protección de tus Datos",
            fontSize: 16,
            isBold: true,
            align: TextAlign.center,
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text:
                      'Tus datos de tu DNI solo se usará para validación de identidad, no lo usaremos para compartir tus datos. Tu privacidad es nuestra prioridad. Respaldamos la ',
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 14,
                    color: isDarkMode
                        ? const Color(textDark)
                        : const Color(textLight),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'ley N.º 29733, Ley de Protección de Datos Personales',
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 14,
                    color: isDarkMode
                        ? const Color(textRichDark)
                        : const Color(textRichLight),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
