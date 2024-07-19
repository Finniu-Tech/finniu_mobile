import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void addImage() async {
  final ImagePicker picker = ImagePicker();
  final List<XFile> images = await picker.pickMultiImage();

  if (images.isNotEmpty) {
    var voucherImageListBase64 = [];
    var voucherImageListPreview = [];
    for (var image in images) {
      final File imageFile = File(image.path);
      final List<int> imageBytes = await imageFile.readAsBytes();
      final base64Image = "data:image/jpeg;base64,${base64Encode(imageBytes)}";
      voucherImageListBase64.add(base64Image);
      voucherImageListPreview.add(image.path);
    }
  }
}
