import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void showPayModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const _ModalBody();
    },
  );
}

class _ModalBody extends ConsumerWidget {
  const _ModalBody({
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.read(settingsNotifierProvider).isDarkMode;
    const String title = "Fecha del pago de mi capital";
    const String text =
        "La fecha del pago del capital se define según el día que haya adjuntado la constancia de transferencia cuando realizaste tu inversión ";
    const int tableTitleDark = 0xffA2E6FA;
    const int tableTitleLight = 0xff08273F;
    const int tableTitleTextDark = 0xff000000;
    const int tableTitleTextLight = 0xffFFFFFF;
    const int dayTitleDark = 0xff1A1A1A;
    const int dayTitleLight = 0xffD6F6FF;
    const int dayTitleTextDark = 0xff000000;
    const int dayTitleTextLight = 0xff000000;
    const int borderDark = 0xffA2E6FA;
    const int borderLight = 0xff0D3A5C;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 376,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: CloseButton(),
            ),
            const TextPoppins(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 10),
            const TextPoppins(
              text: text,
              fontSize: 14,
              lines: 3,
              align: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(tableTitleDark)
                          : const Color(tableTitleLight),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: const TextPoppins(
                      text: "Día de transferencia",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textDark: tableTitleTextDark,
                      textLight: tableTitleTextLight,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? const Color(tableTitleDark)
                          : const Color(tableTitleLight),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: const TextPoppins(
                      text: "Pago de capital",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textDark: tableTitleTextDark,
                      textLight: tableTitleTextLight,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: isDarkMode
                              ? const Color(borderDark)
                              : const Color(borderLight),
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: isDarkMode
                              ? const Color(borderDark)
                              : const Color(borderLight),
                        ),
                      ),
                      color: isDarkMode
                          ? const Color(dayTitleDark)
                          : const Color(dayTitleLight),
                    ),
                    child: const TextPoppins(
                      text: "Día 13 al 27",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textDark: dayTitleTextDark,
                      textLight: dayTitleTextLight,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: isDarkMode
                              ? const Color(borderDark)
                              : const Color(borderLight),
                        ),
                      ),
                      color: isDarkMode
                          ? const Color(dayTitleDark)
                          : const Color(dayTitleLight),
                    ),
                    child: const TextPoppins(
                      text: "Día 30",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textDark: dayTitleTextDark,
                      textLight: dayTitleTextLight,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      ),
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: isDarkMode
                              ? const Color(borderDark)
                              : const Color(borderLight),
                        ),
                      ),
                      color: isDarkMode
                          ? const Color(dayTitleDark)
                          : const Color(dayTitleLight),
                    ),
                    child: const TextPoppins(
                      text: "Día 28 al 12",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textDark: dayTitleTextDark,
                      textLight: dayTitleTextLight,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                      ),
                      color: isDarkMode
                          ? const Color(dayTitleDark)
                          : const Color(dayTitleLight),
                    ),
                    child: const TextPoppins(
                      text: "Día 15",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textDark: dayTitleTextDark,
                      textLight: dayTitleTextLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
