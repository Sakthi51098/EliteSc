import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/utils/network_helper.dart';

class GameWebViewState {
  const GameWebViewState({this.isLoading = true, this.hasNetworkError = false});

  final bool isLoading;
  final bool hasNetworkError;

  GameWebViewState copyWith({bool? isLoading, bool? hasNetworkError}) {
    return GameWebViewState(
      isLoading: isLoading ?? this.isLoading,
      hasNetworkError: hasNetworkError ?? this.hasNetworkError,
    );
  }
}

class GameWebViewController extends StateNotifier<GameWebViewState> {
  GameWebViewController() : super(const GameWebViewState());

  void showLoading() {
    state = state.copyWith(isLoading: true, hasNetworkError: false);
  }

  void showLoaded() {
    state = state.copyWith(isLoading: false, hasNetworkError: false);
  }

  void showError() {
    state = state.copyWith(isLoading: false, hasNetworkError: true);
  }

  Future<void> loadGameUrl({
    required WebViewController webViewController,
    required String url,
  }) async {
    final hasInternet = await NetworkHelper.hasInternet();

    if (!hasInternet) {
      state = state.copyWith(isLoading: false, hasNetworkError: true);
      return;
    }

    state = state.copyWith(isLoading: true, hasNetworkError: false);
    await webViewController.loadRequest(Uri.parse(url));
  }
}

final gameWebViewControllerProvider =
    StateNotifierProvider.autoDispose<GameWebViewController, GameWebViewState>((
      ref,
    ) {
      return GameWebViewController();
    });
