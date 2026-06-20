import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';

class RummyScreen extends StatelessWidget {
  const RummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isSmallScreen = screenHeight < 760;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/rummy_bg.png', fit: BoxFit.cover),
          ),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(
                  height: 52,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Positioned(
                        left: 0,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.white,
                            size: 22,
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/images/rummy_name.png',
                        height: 22,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 50)
                    ],
                  ),
                ),
                Container(height: 1, color: AppColors.authFieldBorder),
              ],
            ),
          ),
          Positioned(
            top: isSmallScreen ? 112 : 126,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/rummy_play.png',
              width: 220,
              height: isSmallScreen ? 130 : 150,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: isSmallScreen ? screenHeight * 0.50 : screenHeight * 0.52,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 196,
                padding: const EdgeInsets.only(
                  left: 14,
                  top: 10,
                  right: 14,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.rummyBonusBackground,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.goldLight, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.goldShadow,
                      blurRadius: 14,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text('WELCOME BONES', style: AppTextStyles.gameBonusLabel),
                    const SizedBox(height: 2),
                    Text('₹500', style: AppTextStyles.gameBonusAmount),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: isSmallScreen ? 92 : 104,
            child: Image.asset(
              'assets/images/rummy_feature.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: MediaQuery.paddingOf(context).bottom + 14,
            child: AppButton(
              text: 'Play Rummy Now',
              height: 60,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
