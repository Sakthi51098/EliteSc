import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/network_state_view.dart';
import '../providers/game_webview_controller.dart';

class GameWebViewScreenArgs {
  const GameWebViewScreenArgs({required this.title, required this.url});

  final String title;
  final String url;
}

class GameWebViewScreen extends ConsumerStatefulWidget {
  const GameWebViewScreen({super.key, required this.args});

  final GameWebViewScreenArgs args;

  @override
  ConsumerState<GameWebViewScreen> createState() => GameWebViewScreenState();
}

class GameWebViewScreenState extends ConsumerState<GameWebViewScreen> {
  late final WebViewController webViewController;

  @override
  void initState() {
    super.initState();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            ref.read(gameWebViewControllerProvider.notifier).showLoading();
          },
          onPageFinished: (url) {
            ref.read(gameWebViewControllerProvider.notifier).showLoaded();
          },
          onWebResourceError: (error) {
            ref.read(gameWebViewControllerProvider.notifier).showError();
          },
        ),
      );

    Future.microtask(loadGameUrl);
  }

  Future<void> loadGameUrl() async {
    await ref
        .read(gameWebViewControllerProvider.notifier)
        .loadGameUrl(
          webViewController: webViewController,
          url: widget.args.url,
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(gameWebViewControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          widget.args.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.authCardTitle.copyWith(fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: loadGameUrl,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (state.hasNetworkError)
            NetworkStateView(
              title: 'Unable to open game',
              message: 'Check your internet connection and try again.',
              buttonText: 'Reload',
              onRetry: loadGameUrl,
            )
          else
            WebViewWidget(controller: webViewController),
          if (state.isLoading && !state.hasNetworkError)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.goldPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
