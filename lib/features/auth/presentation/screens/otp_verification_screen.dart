import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/error_message_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/auth_result.dart';
import '../models/otp_verification_screen_args.dart';
import '../models/register_screen_args.dart';
import '../providers/otp_verification_controller.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  const OtpVerificationScreen({super.key, this.args});

  final OtpVerificationScreenArgs? args;

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      OtpVerificationScreenState();
}

class OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> verifyOtp() async {
    try {
      final authResult = await ref
          .read(otpVerificationControllerProvider.notifier)
          .verifyOtp(args: widget.args, otp: otpController.text);

      if (!mounted) {
        return;
      }

      goToNextScreen(authResult);
    } catch (error) {
      showMessage(ErrorMessageHelper.getMessage(error));
    }
  }

  void goToNextScreen(AuthResult authResult) {
    if (authResult.isExistingUser) {
      Navigator.of(context).pushReplacementNamed(AppRouteNames.dashboard);
      return;
    }

    Navigator.of(context).pushReplacementNamed(
      AppRouteNames.register,
      arguments: RegisterScreenArgs(
        userId: authResult.userId,
        phoneNumber: authResult.phoneNumber,
      ),
    );
  }

  void showMessage(String message) {
    AppToast.show(message);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = widget.args;
    final state = ref.watch(otpVerificationControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text(
          'OTP Verification',
          style: AppTextStyles.authTitle.copyWith(fontSize: 22),
        ),
        backgroundColor: AppColors.darkBackground,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            top: 24,
            right: 24,
            bottom: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the OTP sent to your mobile number.',
                style: AppTextStyles.authSubtitle.copyWith(
                  color: AppColors.white,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                routeArgs?.phoneNumber ?? '+91XXXXXXXXXX',
                style: AppTextStyles.authTitle.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 28),
              Text('Enter OTP', style: AppTextStyles.authCardTitle),
              const SizedBox(height: 12),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.authFieldBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.authFieldBorder),
                ),
                child: TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  style: AppTextStyles.authFieldText,
                  maxLength: AppConstants.otpLength,
                  decoration: const InputDecoration(
                    hintText: 'Enter OTP',
                    hintStyle: AppTextStyles.authFieldHint,
                    border: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.only(
                      left: 18,
                      top: 18,
                      right: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                routeArgs == null
                    ? 'Open this screen only after requesting OTP from the login screen.'
                    : 'Use the OTP you received on your phone to continue.',
                style: AppTextStyles.authSubtitle.copyWith(height: 1.5),
              ),
              const Spacer(),
              AppButton(
                text: 'Verify OTP',
                onPressed: verifyOtp,
                isLoading: state.isVerifying,
                height: 60,
              ),
              const SizedBox(height: 12),
              AppButton(
                text: 'Back to Login',
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(AppRouteNames.login);
                },
                height: 56,
                gradient: const LinearGradient(
                  colors: [
                    AppColors.authButtonDisabled,
                    AppColors.authButtonDisabled,
                  ],
                ),
                boxShadow: const [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
