import 'dart:io';
import 'package:finniu/presentation/providers/add_document_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/send_proof_button.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:finniu/presentation/screens/catalog/widgets/user_profil_v2/scafold_user_profile.dart';
import 'package:finniu/presentation/screens/complete_details/widgets/app_bar_logo.dart';
import 'package:finniu/presentation/screens/scan_document_v2/helpers/add_document.dart';
import 'package:finniu/presentation/screens/scan_document_v2/widgets/scan_back.dart';
import 'package:finniu/presentation/screens/scan_document_v2/widgets/scan_front.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScanDocumentScreenV2 extends HookConsumerWidget {
  const ScanDocumentScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? imagePathFront = ref.watch(imagePathFrontProvider);
    final String? imagePathBack = ref.watch(imagePathBackProvider);
    void uploadDocuments() {
      print("upload documents");
    }

    void continueLater() {
      print("continue later");
    }

    return ScaffoldUserProfile(
      appBar: const AppBarLogo(),
      bottomNavigationBar: ActionButtonScanDocument(
        uploadDocuments: () => uploadDocuments(),
        continueLater: () => continueLater(),
      ),
      children: [
        const _TitleHeader(),
        const SizedBox(height: 20),
        const _WarningMessage(),
        const SizedBox(height: 20),
        const TextPoppins(
          text: "Cara frontal",
          fontSize: 16,
          isBold: true,
        ),
        const SizedBox(height: 10),
        imagePathFront != null
            ? UploadedImageFront(
                imagePath: imagePathFront,
                onTap: () => addDocumentFront(context: context, ref: ref),
              )
            : ScanFront(
                onTap: () => addDocumentFront(context: context, ref: ref),
              ),
        const SizedBox(height: 20),
        const TextPoppins(
          text: "Cara trasera",
          fontSize: 16,
          isBold: true,
        ),
        const SizedBox(height: 10),
        imagePathBack != null
            ? UploadedImageFront(
                imagePath: imagePathBack,
                onTap: () => addDocumentBack(context: context, ref: ref),
              )
            : ScanBack(
                onTap: () => addDocumentBack(context: context, ref: ref),
              ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class ActionButtonScanDocument extends StatelessWidget {
  const ActionButtonScanDocument({
    super.key,
    required this.uploadDocuments,
    required this.continueLater,
  });
  final VoidCallback? uploadDocuments;
  final VoidCallback? continueLater;

  final int textDark = 0xffB3B3B3;
  final int textLight = 0xff0D3A5C;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonInvestment(
              text: "Guardar mi documento", onPressed: uploadDocuments),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: continueLater,
            child: TextPoppins(
              text: "Continuar más tarde",
              fontSize: 14,
              isBold: true,
              textDark: textDark,
              textLight: textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class UploadedImage extends StatelessWidget {
  const UploadedImage({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(
        imagePath,
      ),
      width: 87,
      height: 55,
    );
  }
}

class _WarningMessage extends ConsumerWidget {
  const _WarningMessage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int backgroundDark = 0xff2C2C2C;
    const int backgroundLight = 0xffE0F8FF;
    const int svgIconDark = 0xffA2E6FA;
    const int svgIconLight = 0xff000000;
    const String text =
        "Para poder validar tu inversión sin problemas necesitamos validar tu identidad y datos personales ";
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? const Color(backgroundDark)
            : const Color(backgroundLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/svg_icons/alert_circle.svg",
            width: 20,
            height: 20,
            color: isDarkMode
                ? const Color(svgIconDark)
                : const Color(svgIconLight),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const TextPoppins(
              text: text,
              fontSize: 12,
              lines: 3,
              isBold: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleHeader extends StatelessWidget {
  const _TitleHeader();

  @override
  Widget build(BuildContext context) {
    return const TextPoppins(
      text: 'Escanea tu documento de identidad',
      fontSize: 20,
      isBold: true,
      lines: 2,
    );
  }
}
