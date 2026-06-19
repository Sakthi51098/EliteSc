import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    required this.title,
    required this.imagePath,
    super.key,
    this.width = 88,
    this.imageHeight = 110,
    this.onTap,
  });

  final String title;
  final String imagePath;
  final double width;
  final double imageHeight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          children: [
            Container(
              height: imageHeight,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.cardBorder, width: 1.5),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: AppTextStyles.homeGameCardTitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
