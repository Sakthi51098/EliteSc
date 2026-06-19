import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/service_locator.dart';
import '../../../game/domain/entities/free_game_entity.dart';
import '../../../game/presentation/providers/game_provider.dart';

class GamesState {
  const GamesState({
    this.gameList = const [],
    this.isLoading = true,
    this.isLoadingMore = false,
    this.hasMoreData = true,
    this.errorMessage = '',
  });

  final List<FreeGameEntity> gameList;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMoreData;
  final String errorMessage;

  GamesState copyWith({
    List<FreeGameEntity>? gameList,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMoreData,
    String? errorMessage,
  }) {
    return GamesState(
      gameList: gameList ?? this.gameList,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class GamesScreenController extends StateNotifier<GamesState> {
  GamesScreenController(this.gameProvider) : super(const GamesState());

  final GameProvider gameProvider;
  int currentPage = 1;
  final int pageLimit = 10;

  Future<void> loadGames({bool loadMore = false}) async {
    if (loadMore) {
      if (state.isLoadingMore || !state.hasMoreData) {
        return;
      }

      state = state.copyWith(isLoadingMore: true);
    } else {
      state = state.copyWith(isLoading: true, errorMessage: '');
    }

    try {
      final games = await gameProvider.getFreeGames(
        page: currentPage,
        limit: pageLimit,
      );

      final updatedList = loadMore
          ? [...state.gameList, ...games]
          : List<FreeGameEntity>.from(games);
      final hasMoreData = games.length == pageLimit;

      if (hasMoreData) {
        currentPage++;
      }

      state = state.copyWith(
        gameList: updatedList,
        hasMoreData: hasMoreData,
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (error) {
      state = state.copyWith(
        errorMessage: error.toString().replaceFirst('Exception: ', ''),
        isLoading: false,
        isLoadingMore: false,
      );
    }
  }

  Future<void> refreshGames() async {
    currentPage = 1;
    state = state.copyWith(hasMoreData: true);
    await loadGames();
  }
}

final gamesScreenControllerProvider =
    StateNotifierProvider<GamesScreenController, GamesState>((ref) {
      return GamesScreenController(getIt<GameProvider>());
    });
