import 'dart:async';
import 'package:finniu/presentation/screens/catalog/widgets/device_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class BlueGoldImage extends StatelessWidget {
  const BlueGoldImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageContainer(
      imageContainer: 'assets/blue_gold/factoring_image.png',
      imageFullScreen: 'assets/blue_gold/factoring_image_vertical.png',
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
      color: Colors.transparent,
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
    builder: (context) => ImageDialog(
      imageFullScreen: imageFullScreen,
    ),
  );
}

class ImageDialog extends StatefulWidget {
  const ImageDialog({
    super.key,
    required this.imageFullScreen,
  });

  final String imageFullScreen;

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  bool isFullScreen = false;
  bool dialogClosed = false;
  late StreamSubscription<DeviceOrientation> orientationSubscription;

  @override
  void initState() {
    super.initState();
    orientationSubscription = deviceOrientation$.listen((orientation) {
      if (!dialogClosed) {
        if (orientation == DeviceOrientation.portraitUp) {
          if (isFullScreen) {
            dialogClosed = true;
            Navigator.of(context).pop();
          }
        } else if (orientation == DeviceOrientation.landscapeLeft ||
            orientation == DeviceOrientation.landscapeRight) {
          setState(() {
            isFullScreen = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    orientationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        dialogClosed = true;
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InteractiveViewer(
          child: Image.asset(
            widget.imageFullScreen,
          ),
        ),
      ),
    );
  }
}
