import 'package:flutter/material.dart';

import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/congrats_icon.png',
                width: 290,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 52),
              Text(
                'Congratulations!',
                style: AppTextStyles.screenTitle24,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'You have successfully completed the onboarding',
                style: AppTextStyles.screenSubtitle14,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              AppButton(
                text: 'Continue',
                height: 60,
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(AppRouteNames.dashboard);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
