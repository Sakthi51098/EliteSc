import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/error_message_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../models/register_screen_args.dart';
import '../providers/register_screen_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key, this.args});

  final RegisterScreenArgs? args;

  @override
  ConsumerState<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final avatarList = const [
    'assets/images/avatar_1.png',
    'assets/images/avatar_2.png',
    'assets/images/avatar_3.png',
  ];

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> saveProfile() async {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      await ref
          .read(registerScreenControllerProvider.notifier)
          .saveProfile(args: widget.args, name: nameController.text);

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushReplacementNamed(AppRouteNames.congratulations);
    } catch (error) {
      showMessage(ErrorMessageHelper.getMessage(error));
    }
  }

  void showMessage(String message) {
    AppToast.show(message);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerScreenControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            top: 24,
            right: 20,
            bottom: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 90),
                Image.asset(
                  'assets/images/name_icon.png',
                  width: 150,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 34),
                Text(
                  'You’re all set to Play!',
                  style: AppTextStyles.screenTitle24,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    'Set up your profile to get started. Choose a name and avatar to personalize your gaming experience.',
                    style: AppTextStyles.screenSubtitle14,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 42),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter Your Name',
                    style: AppTextStyles.authFieldLabel,
                  ),
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: nameController,
                  hintText: 'Praveen',
                  textInputAction: TextInputAction.done,
                  textStyle: AppTextStyles.authFieldText,
                  hintStyle: AppTextStyles.authFieldHint,
                  filled: true,
                  fillColor: AppColors.darkBackground,
                  borderColor: AppColors.authFieldBorder,
                  focusedBorderColor: AppColors.authFieldBorder,
                  borderRadius: 16,
                  contentPadding: const EdgeInsets.only(
                    left: 18,
                    top: 22,
                    right: 18,
                    bottom: 22,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                  ],
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'Enter your name';
                    }

                    if ((value ?? '').trim().length < 3) {
                      return 'Name should be at least 3 characters';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Avatar',
                    style: AppTextStyles.authFieldLabel,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: avatarList.map((avatar) {
                    final isSelected = state.selectedAvatar == avatar;

                    return GestureDetector(
                      onTap: () {
                        ref
                            .read(registerScreenControllerProvider.notifier)
                            .selectAvatar(avatar);
                      },
                      child: Container(
                        width: 78,
                        height: 78,
                        margin: const EdgeInsets.only(right: 18),
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.termsHighlight
                                : AppColors.transparent,
                            width: 2.5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(avatar, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 74),
                AppButton(
                  text: 'Save Name',
                  height: 60,
                  isLoading: state.isSaving,
                  onPressed: state.isSaving ? null : saveProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
