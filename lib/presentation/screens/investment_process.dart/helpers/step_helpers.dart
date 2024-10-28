import 'dart:convert';
import 'dart:io';

import 'package:finniu/presentation/providers/pre_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/investment_process.dart/widgets/modals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> getImageFromGallery(BuildContext context, WidgetRef ref) async {
  PermissionStatus status = await Permission.photos.status;
  bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

  if (Platform.isIOS) {
    if (status.isGranted || status.isLimited) {
      await _openGallery(context, ref);
    } else if (status.isDenied) {
      status = await Permission.photos.request();
      if (status.isGranted || status.isLimited) {
        // ignore: use_build_context_synchronously
        await _openGallery(context, ref);
      } else {
        _showPermissionDeniedDialog(context, isDarkMode);
      }
    } else if (status.isPermanentlyDenied) {
      _showOpenSettingsDialog(context, isDarkMode);
    }
  } else {
    // Para Android
    if (status.isGranted) {
      await _openGallery(context, ref);
    } else {
      await _openGallery(context, ref);
    }
  }
}

Future<void> _openGallery(context, ref) async {
  try {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      List<String> voucherImageListBase64 = [];
      List<String> voucherImageListPreview = [];
      for (var image in images) {
        final File imageFile = File(image.path);
        final List<int> imageBytes = await imageFile.readAsBytes();
        final base64Image =
            "data:image/jpeg;base64,${base64Encode(imageBytes)}";
        voucherImageListBase64.add(base64Image);
        voucherImageListPreview.add(image.path);
      }
      ref.read(preInvestmentVoucherImagesProvider.notifier).state =
          voucherImageListBase64;
      ref.read(preInvestmentVoucherImagesPreviewProvider.notifier).state =
          voucherImageListPreview;
    }
  } catch (e) {
    bool isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    if (e is PlatformException && e.code == 'photo_access_denied') {
      _showOpenSettingsDialog(context, isDarkMode);
    } else {
      _showPermissionDeniedDialog(context, isDarkMode);
    }
  }
}

void _showPermissionDeniedDialog(context, isDarkMode) {
  showGrantPermissionModal(context, isDarkMode, false);
}

void _showOpenSettingsDialog(context, isDarkMode) {
  showGrantPermissionModal(context, isDarkMode, true);
}
