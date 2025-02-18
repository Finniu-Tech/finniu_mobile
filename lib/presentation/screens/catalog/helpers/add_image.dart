import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:finniu/presentation/screens/catalog/widgets/snackbar/snackbar_v2.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> addImage({required BuildContext context, required WidgetRef ref}) async {
  try {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      // Tomamos solo la primera imagen ya que solo necesitamos una
      final XFile selectedImage = images.first;

      final File imageFile = File(selectedImage.path);
      final int imageSize = await imageFile.length();
      final double imageSizeInMB = imageSize / (1024 * 1024);
      const double maxSizeInMB = 5;

      if (imageSizeInMB > maxSizeInMB) {
        if (context.mounted) {
          showSnackBarV2(
            context: context,
            title: "Foto muy pesada",
            message: "La imagen debe ser menor a 5MB",
            snackType: SnackType.warning,
          );
        }
        return;
      }

      final List<int> imageBytes = await imageFile.readAsBytes();
      final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";

      if (context.mounted) {
        ref.read(imageBase64Provider.notifier).state = base64Image;
        ref.read(imagePathProvider.notifier).state = selectedImage.path;
      }
    }
  } catch (e) {
    print('Error al seleccionar imagen: $e');
    if (context.mounted) {
      showSnackBarV2(
        context: context,
        title: "Error",
        message: "No se pudo procesar la imagen",
        snackType: SnackType.error,
      );
    }
  }
}

// void addImage({required BuildContext context, required WidgetRef ref}) async {
//   final ImagePicker picker = ImagePicker();
//   final XFile? image = await picker.pickImage(
//     source: ImageSource.gallery,
//     imageQuality: 80,
//   );

//   if (image != null) {
//     final File imageFile = File(image.path);
//     final int imageSize = await imageFile.length();
//     final double imageSizeInMB = imageSize / (1024 * 1024);
//     const double maxSizeInMB = 5;

//     if (imageSizeInMB > maxSizeInMB) {
//       showSnackBarV2(
//         context: context,
//         title: "Foto muy pesada",
//         message: "No pudimos procesar tu foto por que es mayor a 5MB ",
//         snackType: SnackType.warning,
//       );

//       return;
//     }

//     final List<int> imageBytes = await imageFile.readAsBytes();
//     final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";

//     ref.read(imageBase64Provider.notifier).state = base64Image;
//     ref.read(imagePathProvider.notifier).state = image.path;
//   }
// }
