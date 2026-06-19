import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBackground,
        border: Border(top: BorderSide(color: AppColors.authFieldBorder)),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HomeBottomNavItem(
            index: 0,
            selectedIndex: selectedIndex,
            icon: Icons.home_rounded,
            label: 'Home',
            onTap: onTabChanged,
          ),
          HomeBottomNavItem(
            index: 1,
            selectedIndex: selectedIndex,
            icon: Icons.extension_rounded,
            label: 'Games',
            onTap: onTabChanged,
          ),
          HomeBottomNavItem(
            index: 2,
            selectedIndex: selectedIndex,
            icon: Icons.bar_chart_rounded,
            label: 'Leaderboard',
            onTap: onTabChanged,
          ),
          HomeBottomNavItem(
            index: 3,
            selectedIndex: selectedIndex,
            icon: Icons.person_rounded,
            label: 'Profile',
            onTap: onTabChanged,
          ),
        ],
      ),
    );
  }
}

class HomeBottomNavItem extends StatelessWidget {
  const HomeBottomNavItem({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final IconData icon;
  final String label;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: SizedBox(
        width: 82,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: isSelected ? AppColors.goldLight : AppColors.textMuted,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bottomNavLabel.copyWith(
                color: isSelected ? AppColors.goldLight : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
