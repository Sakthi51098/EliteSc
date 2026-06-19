import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_image_view.dart';
import '../../domain/entities/onboarding_item.dart';
import '../providers/onboarding_page_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => OnboardingScreenState();
}

class OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController pageController = PageController();
  double dragStartX = 0;
  double dragEndX = 0;

  final List<OnboardingItem> pages = const [
    OnboardingItem(
      imageType: OnboardingImageType.collage,
      title: 'Play Smart.\nWin Real Money.',
      description:
          'Pick your favorite game, enter the contest, and place your bet with confidence. Simple, fast, and secure.',
    ),
    OnboardingItem(
      imageType: OnboardingImageType.single,
      imagePath: 'assets/images/game_horse_race.png',
      title: 'Play Smart.\nWin Real Money.',
      description:
          'Pick your favorite game, enter the contest, and place your bet with confidence. Simple, fast, and secure.',
    ),
    OnboardingItem(
      imageType: OnboardingImageType.single,
      imagePath: 'assets/images/game_football.png',
      title: 'Play Smart.\nWin Real Money.',
      description:
          'Pick your favorite game, enter the contest, and place your bet with confidence. Simple, fast, and secure.',
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> onNextPressed() async {
    final currentPage = ref.read(onboardingPageProvider);

    if (currentPage == pages.length - 1) {
      Navigator.of(context).pushReplacementNamed(AppRouteNames.login);
      return;
    }

    await goToPage(currentPage + 1);
  }

  Future<void> goToPage(int index) async {
    await pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> goToPreviousPage() async {
    final currentPage = ref.read(onboardingPageProvider);

    await pageController.animateToPage(
      currentPage - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void handleSwipeStart(DragStartDetails details) {
    dragStartX = details.globalPosition.dx;
    dragEndX = details.globalPosition.dx;
  }

  void handleSwipeUpdate(DragUpdateDetails details) {
    dragEndX = details.globalPosition.dx;
  }

  void handleSwipeEnd(DragEndDetails details) {
    final currentPage = ref.read(onboardingPageProvider);
    final velocity = details.primaryVelocity ?? 0;
    final distance = dragStartX - dragEndX;

    if ((distance > 40 || velocity < -250) && currentPage < pages.length - 1) {
      goToPage(currentPage + 1);
    }

    if ((distance < -40 || velocity > 250) && currentPage > 0) {
      goToPreviousPage();
    }
  }

  Widget buildImageSection(BuildContext context, OnboardingItem page) {
    final size = MediaQuery.sizeOf(context);
    final isSmallScreen = size.height < 760;

    if (page.imageType == OnboardingImageType.collage) {
      final imageHeight = isSmallScreen ? 480.0 : 550.0;
      final topImageHeight = isSmallScreen ? 166.0 : 188.0;
      final middleImageHeight = isSmallScreen ? 178.0 : 200.0;
      final bottomImageHeight = isSmallScreen ? 166.0 : 188.0;

      return SizedBox(
        height: imageHeight,
        child: Column(
          children: [
            AppImageView(
              height: topImageHeight,
              width: double.infinity,
              imagePath: 'assets/images/onboarding_1.png',
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 12),
            AppImageView(
              height: middleImageHeight,
              width: double.infinity,
              imagePath: 'assets/images/onboarding_2.png',
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 12),
            AppImageView(
              height: bottomImageHeight,
              width: double.infinity,
              imagePath: 'assets/images/onboarding_3.png',
              fit: BoxFit.fill,
            ),
          ],
        ),
      );
    }

    final imageHeight = isSmallScreen ? 640.0 : 720.0;

    return SizedBox(
      height: imageHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppImageView(
            imagePath: page.imagePath ?? '',
            height: imageHeight,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.transparent,
                  AppColors.transparent,
                  AppColors.imageShade,
                  AppColors.darkBackground,
                ],
                stops: [0, 1, 1, 1],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator(int currentPage) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        pages.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: index == pages.length - 1 ? 0 : 6),
          height: 8,
          width: currentPage == index ? 30 : 8,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(onboardingPageProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragStart: handleSwipeStart,
        onHorizontalDragUpdate: handleSwipeUpdate,
        onHorizontalDragEnd: handleSwipeEnd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: PageView.builder(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: pages.length,
                        onPageChanged: (index) {
                          ref.read(onboardingPageProvider.notifier).state =
                              index;
                        },
                        itemBuilder: (context, index) {
                          return buildImageSection(context, pages[index]);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pages[currentPage].title,
                          style: AppTextStyles.onboardingTitle,
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            pages[currentPage].description,
                            style: AppTextStyles.onboardingDescription,
                          ),
                        ),
                        const SizedBox(height: 15),
                        buildPageIndicator(currentPage),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.paddingOf(context).bottom + 22,
              ),
              child: AppButton(
                text: 'Next',
                height: 60,
                onPressed: onNextPressed,
                textStyle: AppTextStyles.buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
