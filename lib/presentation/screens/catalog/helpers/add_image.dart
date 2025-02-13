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
    // Verificar permisos según la versión de Android
    if (Platform.isAndroid) {
      if (await DeviceInfoPlugin().androidInfo.then((info) => info.version.sdkInt) >= 33) {
        final photosStatus = await Permission.photos.status;
        if (!photosStatus.isGranted) {
          final result = await Permission.photos.request();
          if (result.isDenied) {
            if (context.mounted) {
              showSnackBarV2(
                context: context,
                title: "Permiso requerido",
                message: "Necesitamos acceso a tus galería para continuar",
                snackType: SnackType.warning,
              );
            }
            return;
          }
        }
      } else {
        final storageStatus = await Permission.storage.status;
        if (!storageStatus.isGranted) {
          final result = await Permission.storage.request();
          if (result.isDenied) {
            if (context.mounted) {
              showSnackBarV2(
                context: context,
                title: "Permiso requerido",
                message: "Necesitamos acceso a tu galería para continuar",
                snackType: SnackType.warning,
              );
            }
            return;
          }
        }
      }
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null && context.mounted) {
      final File imageFile = File(image.path);

      if (!await imageFile.exists()) {
        throw Exception('No se pudo acceder al archivo seleccionado');
      }

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

      try {
        final List<int> imageBytes = await imageFile.readAsBytes();
        final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";

        ref.read(imageBase64Provider.notifier).state = base64Image;
        ref.read(imagePathProvider.notifier).state = image.path;
      } catch (e) {
        if (context.mounted) {
          showSnackBarV2(
            context: context,
            title: "Error",
            message: "No pudimos procesar la imagen",
            snackType: SnackType.error,
          );
        }
        print('Error al procesar la imagen: $e');
      }
    }
  } catch (e) {
    if (context.mounted) {
      showSnackBarV2(
        context: context,
        title: "Error",
        message: "Ocurrió un error al seleccionar la imagen",
        snackType: SnackType.error,
      );
    }
    print('Error general: $e');
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
