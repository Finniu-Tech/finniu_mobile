import 'dart:convert';
import 'dart:io';
import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

void addImage({required BuildContext context, required WidgetRef ref}) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final File imageFile = File(image.path);
    final int imageSize = await imageFile.length();
    final double imageSizeInMB = imageSize / (1024 * 1024);
    const double maxSizeInMB = 2;

    if (imageSizeInMB > maxSizeInMB) {
      showSnackBarV2(
        context: context,
        title: "Foto muy pesada",
        message: "No pudimos procesar tu foto por que es mayor a 2MB ",
        snackType: SnackType.warning,
      );

      return;
    }

    final List<int> imageBytes = await imageFile.readAsBytes();
    final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";

    ref.read(imageBase64Provider.notifier).state = base64Image;
    ref.read(imagePathProvider.notifier).state = image.path;
  }
}
