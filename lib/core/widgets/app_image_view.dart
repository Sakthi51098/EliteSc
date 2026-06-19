import 'package:flutter/material.dart';

class AppImageView extends StatelessWidget {
  const AppImageView({
    required this.imagePath,
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = 0,
  });

  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      imagePath,
      height: height,
      width: width,
      fit: fit,
    );

    if (borderRadius <= 0) {
      return image;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: image,
    );
  }
}
