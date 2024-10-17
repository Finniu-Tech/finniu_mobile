import 'package:finniu/presentation/screens/profile_v2/widgets/image_profile.dart';
import 'package:flutter/material.dart';

class ImageProfil extends StatelessWidget {
  const ImageProfil({
    super.key,
    required this.imageProfileUrl,
  });

  final String? imageProfileUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: imageProfileUrl == "" || imageProfileUrl == null
            ? const UserImageHelp()
            : Image.network(
                imageProfileUrl!,
                width: 10,
                height: 10,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const UserImageHelp();
                  }
                },
                errorBuilder: (context, error, stackTrace) =>
                    const UserImageHelp(),
              ),
      ),
    );
  }
}
