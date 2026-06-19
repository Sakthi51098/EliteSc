import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class NetworkStateView extends StatelessWidget {
  const NetworkStateView({
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onRetry,
    super.key,
  });

  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 48,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.authTitle.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: AppTextStyles.authSubtitle.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: onRetry,
              child: Text(
                buttonText,
                style: AppTextStyles.buttonText.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
