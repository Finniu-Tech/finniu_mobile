import 'dart:async';
import 'package:device_orientation/device_orientation.dart';
import 'package:device_orientation/widgets/animated_always_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlueGoldImage extends StatelessWidget {
  const BlueGoldImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageContainer(
      imageContainer: 'assets/blue_gold/factoring_image.png',
      imageFullScreen: 'assets/blue_gold/factoring_image.png',
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
    Key? key,
    required this.imageFullScreen,
  }) : super(key: key);

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
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          dialogClosed = true;
          Navigator.of(context).pop();
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.height * 0.9,
          height: MediaQuery.of(context).size.width * 0.9,
          child: AnimatedAlwaysDown(
            child: InteractiveViewer(
              child: isFullScreen
                  ? Image.asset(
                      widget.imageFullScreen,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      widget.imageFullScreen,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
