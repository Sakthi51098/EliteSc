import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/app_toast.dart';
import '../../../../core/utils/error_message_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/auth_result.dart';
import '../models/register_screen_args.dart';
import '../providers/login_screen_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneController.addListener(onPhoneChanged);
    otpController.addListener(onOtpChanged);
  }

  @override
  void dispose() {
    phoneController.removeListener(onPhoneChanged);
    otpController.removeListener(onOtpChanged);
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void onPhoneChanged() {
    ref
        .read(loginScreenControllerProvider.notifier)
        .updatePhoneNumber(phoneController.text);
  }

  void onOtpChanged() {
    ref
        .read(loginScreenControllerProvider.notifier)
        .updateOtp(otpController.text);
  }

  Future<void> sendOtp() async {
    FocusScope.of(context).unfocus();

    try {
      await ref.read(loginScreenControllerProvider.notifier).sendOtp();
      showMessage('OTP sent successfully');
    } catch (error) {
      showMessage(ErrorMessageHelper.getMessage(error));
    }
  }

  Future<void> login() async {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      final authResult = await ref
          .read(loginScreenControllerProvider.notifier)
          .login();

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

  Widget buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/app_icon.png',
          width: 188,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 10),
        Image.asset(
          'assets/images/app_name.png',
          width: 160,
          fit: BoxFit.contain,
        ),
      ],
    );
  }

  Widget buildPhoneField() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.authFieldBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.authFieldBorder),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Image.asset(
            'assets/images/mobile_icon.png',
            width: 24,
            height: 24,
            color: AppColors.textMuted,
          ),
          const SizedBox(width: 14),
          Text('91+', style: AppTextStyles.authFieldHint),
          Container(
            width: 1,
            height: 28,
            margin: const EdgeInsets.only(left: 14, right: 14),
            color: AppColors.authFieldBorder,
          ),
          Expanded(
            child: TextFormField(
              controller: phoneController,
              style: AppTextStyles.authFieldText,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              validator: (value) {
                if ((value ?? '').trim().isEmpty) {
                  return 'Enter phone number';
                }

                if ((value ?? '').trim().length != 10) {
                  return 'Enter valid 10 digit number';
                }

                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Phone Number',
                hintStyle: AppTextStyles.authFieldHint,
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget buildOtpField(LoginState state) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.authFieldBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.authFieldBorder),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Image.asset(
            'assets/images/otp_icon.png',
            width: 26,
            height: 26,
            color: AppColors.textMuted,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: TextFormField(
              controller: otpController,
              enabled: state.otpSent,
              style: AppTextStyles.authFieldText,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(AppConstants.otpLength),
              ],
              validator: (value) {
                if (!state.otpSent) {
                  return null;
                }

                if ((value ?? '').trim().isEmpty) {
                  return 'Enter OTP';
                }

                if ((value ?? '').trim().length != AppConstants.otpLength) {
                  return 'Enter valid OTP';
                }

                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter OTP',
                hintStyle: AppTextStyles.authFieldHint,
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          GestureDetector(
            onTap: state.canSendOtp ? sendOtp : null,
            child: Container(
              height: 46,
              padding: const EdgeInsets.only(left: 24, right: 24),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: AppColors.authButtonDisabled,
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: state.isSendingOtp
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    )
                  : Text(
                      state.otpSent ? 'Resend OTP' : 'Get OTP',
                      style: AppTextStyles.authOtpAction.copyWith(
                        color: state.canSendOtp
                            ? AppColors.white
                            : AppColors.textMuted,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTermsText() {
    return RichText(
      text: const TextSpan(
        style: AppTextStyles.authDisclaimer,
        children: [
          TextSpan(
            text:
                'By clicking this button you confirm that you have read and agree to the ',
          ),
          TextSpan(
            text: 'Terms and Conditions',
            style: AppTextStyles.authDisclaimerLink,
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'privacy policy',
            style: AppTextStyles.authDisclaimerLink,
          ),
          TextSpan(text: ' of the company and confirm that you are legal age.'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginScreenControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                buildLogo(),
                const SizedBox(height: 48),
                Text(
                  'Welcome Dealer !',
                  style: AppTextStyles.loginWelcomeTitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: Text(
                    'Manage your lottery business, tickets, and customers in one place',
                    style: AppTextStyles.loginWelcomeSubtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 38),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.675,
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 34,
                    right: 16,
                    bottom: 22,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.authCard,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      topLeft: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'OTP Login',
                        style: AppTextStyles.authCardTitle,
                      ),
                      const SizedBox(height: 20),
                      buildPhoneField(),
                      const SizedBox(height: 18),
                      buildOtpField(state),
                      const SizedBox(height: 132),
                      AppButton(
                        text: 'Login',
                        height: 60,
                        isLoading: state.isLoggingIn,
                        onPressed: state.isLoggingIn ? null : login,
                      ),
                      const SizedBox(height: 24),
                      buildTermsText(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
