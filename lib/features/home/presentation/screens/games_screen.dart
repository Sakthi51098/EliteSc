import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_state_view.dart';
import '../../../game/domain/entities/free_game_entity.dart';
import '../../../game/presentation/models/game_details_screen_args.dart';
import '../providers/games_screen_controller.dart';

class GamesScreen extends ConsumerStatefulWidget {
  const GamesScreen({super.key});

  @override
  ConsumerState<GamesScreen> createState() => GamesScreenState();
}

class GamesScreenState extends ConsumerState<GamesScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
    Future.microtask(() {
      final state = ref.read(gamesScreenControllerProvider);

      if (state.gameList.isEmpty && state.isLoading) {
        ref.read(gamesScreenControllerProvider.notifier).loadGames();
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    final state = ref.read(gamesScreenControllerProvider);

    if (!scrollController.hasClients ||
        state.isLoading ||
        state.isLoadingMore) {
      return;
    }

    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= maxScroll - 160) {
      ref
          .read(gamesScreenControllerProvider.notifier)
          .loadGames(loadMore: true);
    }
  }

  Future<void> refreshGames() async {
    await ref.read(gamesScreenControllerProvider.notifier).refreshGames();
  }

  void openGameDetails(FreeGameEntity game) {
    Navigator.of(context).pushNamed(
      AppRouteNames.gameDetails,
      arguments: GameDetailsScreenArgs(game: game),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gamesScreenControllerProvider);

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
        ),
      );
    }

    if (state.errorMessage.isNotEmpty && state.gameList.isEmpty) {
      return NetworkStateView(
        title: 'Unable to load games',
        message: state.errorMessage,
        buttonText: 'Try Again',
        onRetry: refreshGames,
      );
    }

    final crossAxisCount = MediaQuery.sizeOf(context).width > 700 ? 4 : 2;

    return RefreshIndicator(
      color: AppColors.goldLight,
      backgroundColor: AppColors.authCard,
      onRefresh: refreshGames,
      child: GridView.builder(
        controller: scrollController,
        padding: const EdgeInsets.only(
          left: 20,
          top: 24,
          right: 20,
          bottom: 24,
        ),
        itemCount: state.gameList.length + (state.isLoadingMore ? 2 : 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 18,
          childAspectRatio: 0.72,
        ),
        itemBuilder: (context, index) {
          if (index >= state.gameList.length) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.authCard,
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            );
          }

          final game = state.gameList[index];

          return Container(
            decoration: BoxDecoration(
              color: AppColors.authCard,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.authFieldBorder),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => openGameDetails(game),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            game.thumbnail,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.darkChip,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.textMuted,
                                  size: 32,
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return Container(
                                color: AppColors.darkChip,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 12,
                            top: 12,
                            right: 12,
                            bottom: 12,
                          ),
                          child: Text(
                            game.title,
                            style: AppTextStyles.homeGameCardTitle.copyWith(
                              fontSize: 14,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
