import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../auth/domain/entities/user_entity.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user, required this.onLogout});

  final UserEntity user;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 24, right: 20, bottom: 24),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              user.avatarPath,
              width: 96,
              height: 96,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) {
                return Container(
                  width: 96,
                  height: 96,
                  color: AppColors.authCard,
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          Text(
            user.name,
            style: AppTextStyles.authTitle.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            user.phoneNumber,
            style: AppTextStyles.authSubtitle.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: AppColors.authCard,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: AppTextStyles.authTitle.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your login session will stay active until you logout.',
                  style: AppTextStyles.authSubtitle.copyWith(
                    height: 1.5,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          AppButton(text: 'Logout', height: 60, onPressed: onLogout),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
