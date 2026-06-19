import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
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
    await getIt<app_auth.AuthProvider>().logout();
    ref.invalidate(currentUserProfileProvider);

    if (!context.mounted) {
      return;
    }

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRouteNames.login, (route) => false);
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
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Text(
                        error.toString().replaceFirst('Exception: ', ''),
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
