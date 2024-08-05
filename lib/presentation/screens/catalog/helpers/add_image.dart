import 'dart:convert';
import 'dart:io';

import 'package:finniu/presentation/providers/add_voucher_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

void addImage({required BuildContext context, required WidgetRef ref}) async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final File imageFile = File(image.path);
    final List<int> imageBytes = await imageFile.readAsBytes();
    final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";

    ref.read(imageBase64Provider.notifier).state = base64Image;
    ref.read(imagePathProvider.notifier).state = image.path;
  }
}
