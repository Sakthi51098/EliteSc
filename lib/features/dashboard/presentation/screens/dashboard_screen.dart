import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../models/home_category_item.dart';
import '../models/home_game_item.dart';
import '../widgets/game_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.user});

  final UserEntity user;

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  static const double pagePadding = 16;
  static const double sectionGap = 34;

  final bannerController = PageController(
    initialPage: 1,
    viewportFraction: 0.9,
  );

  final categoryList = const [
    HomeCategoryItem(title: 'Card', imagePath: 'assets/images/card_icon.png'),
    HomeCategoryItem(
      title: 'Sports',
      imagePath: 'assets/images/sports_icon.png',
    ),
    HomeCategoryItem(
      title: 'Lottery',
      imagePath: 'assets/images/lottery_icon.png',
    ),
    HomeCategoryItem(
      title: 'Casino',
      imagePath: 'assets/images/casino_icon.png',
    ),
    HomeCategoryItem(
      title: 'Horse',
      imagePath: 'assets/images/harse_race_icon.png',
    ),
  ];

  final gameList = const [
    HomeGameItem(title: 'Game 01', imagePath: 'assets/images/more_slots.png'),
    HomeGameItem(title: 'Game 02', imagePath: 'assets/images/e_game.png'),
    HomeGameItem(
      title: 'Game 03',
      imagePath: 'assets/images/marbles_lobby.png',
    ),
    HomeGameItem(title: 'Game 04', imagePath: 'assets/images/play_now.png'),
    HomeGameItem(
      title: 'Game 05',
      imagePath: 'assets/images/winfinity_icon.png',
    ),
    HomeGameItem(
      title: 'Game 06',
      imagePath: 'assets/images/asiya_game_icon.png',
    ),
    HomeGameItem(title: 'Game 07', imagePath: 'assets/images/ezugi_icon.png'),
    HomeGameItem(title: 'Game 08', imagePath: 'assets/images/vivo_gaming.png'),
  ];

  final bannerList = const [
    'assets/images/banner_1.png',
    'assets/images/banner_2.jpeg',
    'assets/images/banner_3.jpeg',
    'assets/images/banner_4.jpeg',
  ];

  Timer? bannerTimer;
  int currentBannerPage = 1;

  @override
  void initState() {
    super.initState();
    startBannerAutoScroll();
  }

  @override
  void dispose() {
    bannerTimer?.cancel();
    bannerController.dispose();
    super.dispose();
  }

  void startBannerAutoScroll() {
    bannerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!bannerController.hasClients) {
        return;
      }

      if (currentBannerPage == bannerList.length - 1) {
        currentBannerPage = 0;
      } else {
        currentBannerPage++;
      }

      bannerController.animateToPage(
        currentBannerPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void openGameDetails() {
    Navigator.of(context).pushNamed(AppRouteNames.rummy);
  }

  Widget buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: pagePadding, right: pagePadding),
      child: Row(
        children: [
          Image.asset('assets/images/menu_icon.png', width: 35, height: 35),
          const SizedBox(width: 10),
          ClipOval(
            child: Image.asset(
              widget.user.avatarPath,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) {
                return Container(
                  width: 45,
                  height: 45,
                  color: AppColors.authCard,
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome', style: AppTextStyles.dashboardHeaderLabel),
                Text(
                  widget.user.name,
                  style: AppTextStyles.dashboardHeaderName,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/yellow_bg.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/wallet_icon.png',
                  width: 25,
                  height: 25,
                ),
                const SizedBox(width: 8),
                Text('₹200', style: AppTextStyles.dashboardWalletText),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/add_rounded_icon.png',
                  width: 25,
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.only(left: pagePadding, right: pagePadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Elite',
                  style: AppTextStyles.dashboardHeroTitle,
                ),
                const SizedBox(height: 6),
                Text(
                  'One wallet. Endless wins.',
                  style: AppTextStyles.dashboardHeroSubtitle,
                ),
                const SizedBox(height: 2),
                Text(
                  '100% Secure and Trusted Platform...',
                  style: AppTextStyles.dashboardCaption,
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.authCard,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.authFieldBorder),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/app_icon.png',
              scale: 5,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.only(left: pagePadding, right: pagePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categoryList.map((item) {
          return SizedBox(
            width: 58,
            child: Column(
              children: [
                GestureDetector(
                  onTap: openGameDetails,
                  child: Container(
                    height: 82,
                    width: 54,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.termsHighlight,
                        width: 1.2,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                        bottomLeft: Radius.circular(2),
                        bottomRight: Radius.circular(2),
                      ),
                      image: DecorationImage(
                        image: AssetImage(item.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: AppTextStyles.dashboardCategoryLabel,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildBannerSection() {
    return SizedBox(
      height: 188,
      child: PageView.builder(
        controller: bannerController,
        itemCount: bannerList.length,
        onPageChanged: (index) {
          currentBannerPage = index;
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: GestureDetector(
              onTap: openGameDetails,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(bannerList[index], fit: BoxFit.cover),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildWorldOfEliteSection() {
    return Padding(
      padding: const EdgeInsets.only(left: pagePadding, right: pagePadding),
      child: Column(
        children: [
          Text(
            'Enter the World of Elite',
            style: AppTextStyles.dashboardSectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 26),
          GestureDetector(
            onTap: openGameDetails,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/rummy_game.png',
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: openGameDetails,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/cricket_game.png',
                      height: 138,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: openGameDetails,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/lottery_game.png',
                      height: 138,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: openGameDetails,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/horse_race_game.png',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    'Horse Racing',
                    style: AppTextStyles.authTitle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFantasySportsSection() {
    return Padding(
      padding: const EdgeInsets.only(right: pagePadding),
      child: Column(
        children: [
          Text(
            'Fantasy Sports',
            style: AppTextStyles.dashboardFantasyTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Build your team. Play smart. Win real rewards.',
            style: AppTextStyles.dashboardSectionSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 76,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildFantasyBanner('assets/images/fantasy_sport_1.png'),
                const SizedBox(width: 12),
                buildFantasyBanner('assets/images/fantasy_sport_2.png'),
                const SizedBox(width: 12),
                buildFantasyBanner('assets/images/fantasy_sport_3.png'),
                const SizedBox(width: 12),
                buildFantasyBanner('assets/images/fantasy_sport_4.png'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          buildLiveFantasyMatchCard(),
        ],
      ),
    );
  }

  Widget buildLiveFantasyMatchCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.authCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.authFieldBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 58,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: AppColors.authFieldBorder),
                      bottom: BorderSide(color: AppColors.authFieldBorder),
                    ),
                  ),
                  child: Text('Ongoing', style: AppTextStyles.dashboardLiveTab),
                ),
              ),
              Expanded(
                child: Container(
                  height: 58,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.authFieldBorder),
                    ),
                  ),
                  child: Text(
                    'Upcoming',
                    style: AppTextStyles.dashboardLiveTab,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 14,
              top: 16,
              right: 14,
              bottom: 14,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 14,
                top: 24,
                right: 14,
                bottom: 14,
              ),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(24),
                gradient: const RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: [AppColors.authButtonDisabled, AppColors.darkCard],
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -42,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 8,
                          right: 16,
                          bottom: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.darkChip,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          'Monday,15 Dec',
                          style: AppTextStyles.dashboardLiveDate,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: buildTeamColumn(
                              imagePath: 'assets/images/mi_icon.png',
                              teamName: 'MI',
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Match Starting In :',
                                  style: AppTextStyles.dashboardLiveMeta,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '08h : 38m',
                                  style: AppTextStyles.dashboardLiveMetaBold,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: buildTeamColumn(
                              imagePath: 'assets/images/csk_icon.png',
                              teamName: 'CSK',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Center(
                        child: ClipPath(
                          clipper: BottomArrowClipper(),
                          child: Container(
                            width: 84,
                            height: 14,
                            color: AppColors.darkArrow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTeamColumn({
    required String imagePath,
    required String teamName,
  }) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Image.asset(
            imagePath,
            width: 52,
            height: 52,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          teamName,
          style: AppTextStyles.dashboardLiveTeam,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget buildFantasyBanner(String imagePath) {
    return GestureDetector(
      onTap: openGameDetails,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(
          imagePath,
          width: 176,
          height: 76,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildGameCenterSection() {
    return Padding(
      padding: const EdgeInsets.only(left: pagePadding, right: pagePadding),
      child: Column(
        children: [
          Text(
            'Game Center',
            style: AppTextStyles.dashboardSectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Manage everything you need, right here.',
            style: AppTextStyles.dashboardSectionSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 136,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildGameCenterCard('assets/images/game_center_1.png'),
                const SizedBox(width: 14),
                buildGameCenterCard('assets/images/game_center_2.png'),
                const SizedBox(width: 14),
                buildGameCenterCard('assets/images/game_center_4.png'),
                const SizedBox(width: 14),
                buildGameCenterCard('assets/images/game_center_3.png'),
              ],
            ),
          ),
          const SizedBox(height: 22),
          GestureDetector(
            onTap: openGameDetails,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/daily_bonus.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGameCenterCard(String imagePath) {
    return GestureDetector(
      onTap: openGameDetails,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          imagePath,
          width: 112,
          height: 136,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildInstantSection() {
    return Padding(
      padding: const EdgeInsets.only(left: pagePadding, right: pagePadding),
      child: Column(
        children: [
          Text(
            'Pure Luck - Instant results.',
            style: AppTextStyles.dashboardSectionTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            'No strategy. Just spin and see',
            style: AppTextStyles.dashboardSectionSubtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          GridView.builder(
            itemCount: gameList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index) {
              final item = gameList[index];

              return GameCard(
                title: item.title,
                imagePath: item.imagePath,
                width: double.infinity,
                imageHeight: 96,
                onTap: openGameDetails,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTopHeader(),
          const SizedBox(height: 40),
          buildWelcomeSection(),
          const SizedBox(height: 26),
          buildCategorySection(),
          const SizedBox(height: 28),
          buildBannerSection(),
          const SizedBox(height: sectionGap),
          buildWorldOfEliteSection(),
          const SizedBox(height: sectionGap),
          buildFantasySportsSection(),
          const SizedBox(height: sectionGap),
          buildGameCenterSection(),
          const SizedBox(height: sectionGap),
          buildInstantSection(),
        ],
      ),
    );
  }
}

class BottomArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
