import 'dart:io';
import 'package:finniu/infrastructure/models/firebase_analytics.entity.dart';
import 'package:finniu/presentation/providers/firebase_provider.dart';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_confirmation/step_2.dart';
import 'package:finniu/presentation/screens/investment_process.dart/helpers/step_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImageStep extends ConsumerWidget {
  const ImageStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voucherPreview = ref.watch(
      preInvestmentVoucherImagesPreviewProvider,
    );
    return voucherPreview.isEmpty ? const AddImageStep() : const ListImage();
  }
}

class AddImageStep extends ConsumerWidget {
  const AddImageStep({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int containerDark = 0xff1D1D1D;
    const int containerLight = 0xffB6EFFF;
    const int iconDark = 0xffA2E6FA;
    const int iconLight = 0xff0D3A5C;

    void questionModal() {
      ref.read(firebaseAnalyticsServiceProvider).logCustomEvent(
        eventName: FirebaseAnalyticsEvents.addVoucher,
        parameters: {},
      );
      photoHelp(context);
    }

    return GestureDetector(
      onTap: () {
        getImageFromGallery(context, ref);
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 73,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(containerDark)
                  : const Color(containerLight),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/svg_icons/gallery_add_icon_v2.svg",
                width: 30,
                height: 30,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () => questionModal(),
              child: SvgPicture.asset(
                "assets/svg_icons/message_question_icon.svg",
                width: 24,
                height: 24,
                color:
                    isDarkMode ? const Color(iconDark) : const Color(iconLight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListImage extends ConsumerWidget {
  const ListImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voucherPreview = ref.watch(
      preInvestmentVoucherImagesPreviewProvider,
    );
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int containerDark = 0xff1D1D1D;
    const int containerLight = 0xffB6EFFF;

    void onTapImage(int index) {
      List<String> voucherImageBase64 =
          ref.watch(preInvestmentVoucherImagesProvider);

      List<String> voucherPreviewImage =
          ref.watch(preInvestmentVoucherImagesPreviewProvider);

      List<String> modifiedVoucherImageBase64 = List.from(voucherImageBase64);

      List<String> modifiedVoucherPreviewImage = List.from(voucherPreviewImage);

      modifiedVoucherImageBase64.removeAt(index);
      modifiedVoucherPreviewImage.removeAt(index);

      ref.read(preInvestmentVoucherImagesProvider.notifier).state =
          modifiedVoucherImageBase64;
      ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state =
          modifiedVoucherPreviewImage;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 73,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(containerDark)
            : const Color(containerLight),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: voucherPreview.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.file(
                        File(voucherPreview[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => onTapImage(index),
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 8,
                          color: Colors.white,
                        ), // Icono de "x"
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
