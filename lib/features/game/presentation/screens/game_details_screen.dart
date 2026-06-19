import 'package:flutter/material.dart';

import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../presentation/models/game_details_screen_args.dart';
import 'game_webview_screen.dart';

class GameDetailsScreen extends StatelessWidget {
  const GameDetailsScreen({super.key, required this.args});

  final GameDetailsScreenArgs args;

  @override
  Widget build(BuildContext context) {
    final game = args.game;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 16,
            top: 12,
            right: 16,
            bottom: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.white,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      game.title,
                      style: AppTextStyles.authTitle.copyWith(fontSize: 24),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  game.thumbnail,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      color: AppColors.authCard,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.textMuted,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  buildInfoChip(game.genre),
                  buildInfoChip(game.platform),
                  buildInfoChip(game.releaseDate),
                ],
              ),
              const SizedBox(height: 22),
              buildInfoCard(
                title: 'About Game',
                child: Text(
                  game.shortDescription,
                  style: AppTextStyles.authSubtitle.copyWith(
                    color: AppColors.white,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              buildInfoCard(
                title: 'Game Details',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoRow('Publisher', game.publisher),
                    const SizedBox(height: 12),
                    buildInfoRow('Developer', game.developer),
                    const SizedBox(height: 12),
                    buildInfoRow('Genre', game.genre),
                    const SizedBox(height: 12),
                    buildInfoRow('Platform', game.platform),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                text: 'Play ${game.title}',
                height: 60,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRouteNames.gameWebView,
                    arguments: GameWebViewScreenArgs(
                      title: game.title,
                      url: game.gameUrl,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.only(left: 14, top: 8, right: 14, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.authCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.authFieldBorder),
      ),
      child: Text(
        text,
        style: AppTextStyles.authFieldHint.copyWith(color: AppColors.white),
      ),
    );
  }

  Widget buildInfoCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.authCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.authFieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.authCardTitle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: AppTextStyles.authFieldHint.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.authFieldText.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
