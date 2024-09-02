import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RowDownload extends ConsumerWidget {
  const RowDownload({
    super.key,
    required this.title,
    this.onTap,
  });
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const int buttonColor = 0xffA2E6FA;
    const int textButtonColor = 0xff0D3A5C;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextPoppins(text: title, fontSize: 14),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(buttonColor),
                ),
                width: 105,
                height: 30,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_download_outlined,
                      size: 16,
                      color: Color(textButtonColor),
                    ),
                    SizedBox(width: 5),
                    TextPoppins(
                      text: "Descargar",
                      fontSize: 12,
                      isBold: true,
                      textDark: textButtonColor,
                      textLight: textButtonColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
