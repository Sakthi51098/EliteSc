import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const fontFamily = 'DMSans';
  static const interFontFamily = 'Inter';

  static const TextStyle themeBody14 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  static const TextStyle themeTitle14Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  static const TextStyle themeHeadline24Bold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  static const TextStyle onboardingTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 34,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle onboardingDescription = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 0,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle loginWelcomeTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle loginWelcomeSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 0,
  );

  static const TextStyle authTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle authSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 0,
  );

  static const TextStyle authCardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle authFieldLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle authFieldHint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 0,
  );

  static const TextStyle authFieldText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle authOtpAction = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle authDisclaimer = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 0,
  );

  static const TextStyle authDisclaimerLink = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.termsHighlight,
    letterSpacing: 0,
  );

  static const TextStyle screenTitle24 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: -0.5,
  );

  static const TextStyle screenSubtitle14 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 0,
  );

  static const TextStyle dashboardHeaderLabel = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColors.white,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle dashboardHeaderName = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle dashboardWalletText = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.14,
  );

  static const TextStyle dashboardHeroTitle = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.goldLight,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle dashboardHeroSubtitle = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle dashboardCaption = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle dashboardSectionTitle = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.goldLight,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle dashboardSectionSubtitle = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle dashboardCategoryLabel = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle dashboardFantasyTitle = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.goldLight,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle homeGameCardTitle = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle dashboardLiveTab = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle dashboardLiveDate = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle dashboardLiveMeta = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle dashboardLiveMetaBold = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle dashboardLiveTeam = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle gameBonusLabel = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.goldLight,
    letterSpacing: 0,
  );

  static const TextStyle gameBonusAmount = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.goldLight,
    letterSpacing: 0,
  );

  static const TextStyle liveMatchTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 0,
  );

  static const TextStyle liveMatchSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 0,
  );

  static const TextStyle bottomNavLabel = TextStyle(
    fontFamily: interFontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.textMuted,
    letterSpacing: 0,
  );
}
