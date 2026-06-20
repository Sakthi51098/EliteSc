import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/error_message_helper.dart';
import '../../../auth/presentation/providers/auth_provider.dart' as app_auth;
import 'games_screen.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../providers/home_providers.dart';
import 'leaderboard_screen.dart';
import 'profile_screen.dart';
import '../widgets/home_bottom_nav_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> logout(BuildContext context, WidgetRef ref) async {
    ref.invalidate(currentUserProfileProvider);
    await getIt<app_auth.AuthProvider>().logout();

    if (!context.mounted) {
      return;
    }

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRouteNames.login, (route) => false);
  }

  bool needsLogin(dynamic error) {
    final message = error.toString().toLowerCase();
    return message.contains('user data not found') ||
        message.contains('user not logged in');
  }

  Future<void> sendToLogin(BuildContext context, WidgetRef ref) async {
    if (!context.mounted) {
      return;
    }

    ref.invalidate(currentUserProfileProvider);
    await getIt<app_auth.AuthProvider>().logout();

    if (!context.mounted) {
      return;
    }

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRouteNames.login, (route) => false);

    AppToast.show('Please login again to save your profile details.');
  }

  Widget buildBody(
    int selectedTab,
    dynamic user,
    BuildContext context,
    WidgetRef ref,
  ) {
    return IndexedStack(
      index: selectedTab,
      children: [
        DashboardScreen(user: user),
        const GamesScreen(),
        const LeaderboardScreen(),
        ProfileScreen(user: user, onLogout: () => logout(context, ref)),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(homeTabProvider);
    final userData = ref.watch(currentUserProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: userData.when(
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.white,
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  if (needsLogin(error)) {
                    final isRedirecting = ref.read(homeLoginRedirectProvider);

                    if (!isRedirecting) {
                      ref.read(homeLoginRedirectProvider.notifier).state = true;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        sendToLogin(context, ref);
                      });
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    );
                  }

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Text(
                        ErrorMessageHelper.getMessage(error),
                        style: AppTextStyles.authSubtitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                data: (user) {
                  return buildBody(selectedTab, user, context, ref);
                },
              ),
            ),
            HomeBottomNavBar(
              selectedIndex: selectedTab,
              onTabChanged: (index) {
                ref.read(homeTabProvider.notifier).state = index;
              },
            ),
          ],
        ),
      ),
    );
  }
}
