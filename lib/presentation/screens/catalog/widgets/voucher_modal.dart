import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<dynamic> voucherModal(
  BuildContext context, {
  required String urlImage,
}) async {
  showModalBottomSheet(
    context: context,
    builder: (context) => BodyVoucher(
      urlImage: urlImage,
    ),
  );
}

class BodyVoucher extends ConsumerWidget {
  const BodyVoucher({
    super.key,
    required this.urlImage,
  });
  final String urlImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
    const String textTitle = 'Voucher del pago';
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff0D3A5C;
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          Dialog(
            insetPadding: const EdgeInsets.all(20.0),
            backgroundColor: isDarkMode
                ? const Color(backgroundDark)
                : const Color(backgroundLight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextPoppins(
                      text: textTitle,
                      fontSize: 20,
                      isBold: true,
                      textDark: titleDark,
                      textLight: titleLight,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/blue_gold/voucher_receipt_icon_${isDarkMode ? "dark" : "light"}.png",
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () =>
                      expandedImage(context, imageFullScreen: urlImage),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width - 40,
                    height: 260,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        urlImage,
                        width: 306,
                        height: 260,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const CloseButtonModal(),
        ],
      ),
    );
  }

  Future<dynamic> expandedImage(
    BuildContext context, {
    required String imageFullScreen,
  }) =>
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: InteractiveViewer(
              child: Image.asset(
                imageFullScreen,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      );
}
