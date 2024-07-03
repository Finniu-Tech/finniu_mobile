import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';

class BlueGlodImage extends StatelessWidget {
  const BlueGlodImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageContainer(
      imageContainer: 'assets/blue_gold/blue_gold_image.png',
      imageFullScreen: 'assets/blue_gold/blue_gold_rotative.png',
    );
  }
}

class ImageContainer extends StatelessWidget {
  final String imageContainer;
  final String imageFullScreen;

  const ImageContainer({
    super.key,
    required this.imageContainer,
    required this.imageFullScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(imageContarnerColor),
      width: MediaQuery.of(context).size.width,
      height: 192,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () => showImageFullScreenAsset(
            context,
            imageFullScreen: imageFullScreen,
          ),
          child: Image.asset(imageContainer, fit: BoxFit.fill),
        ),
      ),
    );
  }
}

Future<dynamic> showImageFullScreenAsset(
  BuildContext context, {
  required String imageFullScreen,
}) {
  return showDialog(
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
