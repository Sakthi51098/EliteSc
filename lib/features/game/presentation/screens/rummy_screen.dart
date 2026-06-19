import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/error_message_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/game_details_entity.dart';
import '../providers/game_provider.dart';
import '../widgets/rummy_live_sports_card.dart';

class RummyScreen extends StatelessWidget {
  const RummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final gameProvider = GameProvider();

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/rummy_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
              right: 16,
              bottom: 20,
            ),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/rummy_name.png',
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 12),
                Container(height: 1, color: AppColors.authFieldBorder),
                SizedBox(height: screenHeight * 0.03),
                Image.asset(
                  'assets/images/rummy_play.png',
                  width: 210,
                  fit: BoxFit.contain,
                ),
                const Spacer(),
                Container(
                  width: 190,
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 12,
                    right: 16,
                    bottom: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.rummyBonusBackground,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.goldLight, width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.goldShadow,
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'WELCOME BONUS',
                        style: AppTextStyles.gameBonusLabel,
                      ),
                      const SizedBox(height: 4),
                      Text('₹500', style: AppTextStyles.gameBonusAmount),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Image.asset(
                  'assets/images/rummy_feature.png',
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.03),
                FutureBuilder<GameDetailsEntity>(
                  future: gameProvider.getGameDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 12, bottom: 12),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.white,
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Text(
                          ErrorMessageHelper.getMessage(snapshot.error),
                          style: AppTextStyles.liveMatchSubtitle,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    final gameDetails = snapshot.data;

                    if (gameDetails == null) {
                      return const SizedBox();
                    }

                    return RummyLiveSportsCard(gameDetails: gameDetails);
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                AppButton(text: 'Play Rummy Now', height: 60, onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
