import 'dart:io';
import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/helpers/add_image.dart';
import 'package:finniu/presentation/screens/catalog/widgets/blue_gold_card/buttons_card.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<dynamic> addVoucherModal(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    builder: (context) => const BodyVoucher(),
  );
}

class BodyVoucher extends ConsumerWidget {
  const BodyVoucher({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff1A1A1A;
    const int backgroundLight = 0xffFFFFFF;
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const TitleBody(),
                const ColumnBody(),
                ButtonInvestment(
                  text: "Subir voucher",
                  onPressed: () {
                    ref.read(imageBase64Provider.notifier).state = null;
                    ref.read(imagePathProvider.notifier).state = null;
                  },
                ),
              ],
            ),
          ),
          const CloseButtonModal(),
        ],
      ),
    );
  }
}

class ColumnBody extends ConsumerWidget {
  const ColumnBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? imagePath = ref.watch(imagePathProvider);
    List<Widget> notImage = [
      const TextAddImage(),
      const AddImageContainer(),
    ];

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (imagePath != null) const ImageRender() else ...notImage,
        ],
      ),
    );
  }
}

class ImageRender extends ConsumerWidget {
  const ImageRender({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? imagePath = ref.watch(imagePathProvider);
    return imagePath != null
        ? SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextPoppins(
                  text: "Año 2024",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  width: 185,
                  height: 145,
                  child: Expanded(
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const TextPoppins(text: "Adjunta tu voucher", fontSize: 14),
                const SizedBox(
                  height: 5,
                ),
                const Center(
                  child: AddImageContainer(),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}

class AddImageContainer extends ConsumerWidget {
  const AddImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final String? imagePath = ref.watch(imagePathProvider);
    const int backgroundDark = 0xff323232;
    const int backgroundLight = 0xffECECEC;
    return GestureDetector(
      onTap: () {
        addImage(context: context, ref: ref);
      },
      child: Container(
        width: 320,
        height: imagePath != null ? 69 : 112,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Color(isDarkMode ? backgroundDark : backgroundLight),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            "assets/icons/add_image_${isDarkMode ? "dark" : "light"}.png",
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}

class TextAddImage extends ConsumerWidget {
  const TextAddImage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String textAdd =
        'Aún no tienes un voucher guardado, para realizar el seguimiento debes subir tu voucher.';
    return const TextPoppins(
      text: textAdd,
      fontSize: 16,
      lines: 3,
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          "assets/blue_gold/voucher_example.png",
          width: 306,
          height: 260,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class TitleBody extends ConsumerWidget {
  const TitleBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const String textTitle = 'Voucher del pago';
    const int titleDark = 0xffFFFFFF;
    const int titleLight = 0xff0D3A5C;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TextPoppins(
          text: textTitle,
          fontSize: 20,
          fontWeight: FontWeight.w500,
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
    );
  }
}
