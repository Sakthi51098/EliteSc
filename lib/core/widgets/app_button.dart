import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.height = 60,
    this.borderRadius = 14,
    this.textStyle,
    this.gradient,
    this.boxShadow,
    this.isLoading = false,
    this.disabledColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double borderRadius;
  final TextStyle? textStyle;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final bool isLoading;
  final Color? disabledColor;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: isEnabled
              ? null
              : disabledColor ?? AppColors.authButtonDisabled,
          gradient: isEnabled
              ? gradient ??
                    const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.goldLight,
                        AppColors.goldPrimary,
                        AppColors.goldDark,
                      ],
                    )
              : null,
          boxShadow: isEnabled
              ? boxShadow ??
                    const [
                      BoxShadow(
                        color: AppColors.goldShadow,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ]
              : null,
        ),
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.transparent,
            shadowColor: AppColors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
              : Text(text, style: textStyle ?? AppTextStyles.buttonText),
        ),
      ),
    );
  }
}
