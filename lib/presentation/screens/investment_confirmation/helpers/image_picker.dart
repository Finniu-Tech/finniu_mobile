import 'dart:convert';
import 'dart:io';
import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> imagePicker(BuildContext context, WidgetRef ref) async {
  try {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();

    if (images.isNotEmpty) {
      var voucherImageListBase64 = [];
      var voucherImageListPreview = [];

      for (var image in images) {
        final File imageFile = File(image.path);
        final List<int> imageBytes = await imageFile.readAsBytes();
        final base64Image =
            "data:image/jpeg;base64,${base64Encode(imageBytes)}";
        voucherImageListBase64.add(base64Image);
        voucherImageListPreview.add(image.path);
      }

      ref.read(preInvestmentVoucherImagesProvider.notifier).state =
          List.from(voucherImageListBase64);
      ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state =
          List.from(voucherImageListPreview);
    }
  } catch (e) {
    CustomSnackbar.show(context, e.toString(), 'error');
  }
}

void removeImage(WidgetRef ref, int index) {
  List<String> voucherImageBase64 = ref.watch(
    preInvestmentVoucherImagesProvider,
  );
  List<String> voucherPreviewImage = ref.watch(
    preInvestmentVoucherImagesPreviewProvider,
  );
  List<String> modifiedVoucherImageBase64 = List.from(
    voucherImageBase64,
  );

  List<String> modifiedVoucherPreviewImage = List.from(
    voucherPreviewImage,
  );

  modifiedVoucherImageBase64.removeAt(index);
  modifiedVoucherPreviewImage.removeAt(index);
  ref.read(preInvestmentVoucherImagesProvider.notifier).state =
      modifiedVoucherImageBase64;
  ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state =
      modifiedVoucherPreviewImage;
}
