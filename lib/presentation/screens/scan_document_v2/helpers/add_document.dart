import 'dart:convert';
import 'dart:io';
import 'package:finniu/presentation/providers/add_document_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

void addDocumentFront(
    {required BuildContext context, required WidgetRef ref}) async {
  final ImagePicker documentFront = ImagePicker();
  final XFile? image =
      await documentFront.pickImage(source: ImageSource.gallery);
  if (image != null) {
    final File imageFile = File(image.path);
    final List<int> imageBytes = await imageFile.readAsBytes();
    final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";
    ref.read(documentFrontProvider.notifier).state = base64Image;
    ref.read(imagePathFrontProvider.notifier).state = image.path;
  }
}

void addDocumentBack(
    {required BuildContext context, required WidgetRef ref}) async {
  final ImagePicker documentBack = ImagePicker();
  final XFile? image =
      await documentBack.pickImage(source: ImageSource.gallery);
  if (image != null) {
    final File imageFile = File(image.path);
    final List<int> imageBytes = await imageFile.readAsBytes();
    final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";
    ref.read(documentBackProvider.notifier).state = base64Image;
    ref.read(imagePathBackProvider.notifier).state = image.path;
  }
}
