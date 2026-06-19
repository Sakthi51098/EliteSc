import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/entities/game_details_entity.dart';

class RummyLiveSportsCard extends StatelessWidget {
  const RummyLiveSportsCard({super.key, required this.gameDetails});

  final GameDetailsEntity gameDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, top: 14, right: 16, bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.authCard.withValues(alpha: 0.86),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.authFieldBorder),
      ),
      child: Column(
        children: [
          Text(
            gameDetails.league,
            style: AppTextStyles.liveMatchSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '${gameDetails.homeTeam} vs ${gameDetails.awayTeam}',
            style: AppTextStyles.liveMatchTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            '${gameDetails.eventDate}  •  ${gameDetails.eventTime}',
            style: AppTextStyles.liveMatchSubtitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
