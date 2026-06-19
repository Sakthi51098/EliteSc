import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/service_locator.dart';
import '../../domain/entities/auth_result.dart';
import '../models/otp_verification_screen_args.dart';
import 'auth_provider.dart';

class OtpVerificationState {
  const OtpVerificationState({this.isVerifying = false});

  final bool isVerifying;

  OtpVerificationState copyWith({bool? isVerifying}) {
    return OtpVerificationState(isVerifying: isVerifying ?? this.isVerifying);
  }
}

class OtpVerificationController extends StateNotifier<OtpVerificationState> {
  OtpVerificationController(this.authProvider)
    : super(const OtpVerificationState());

  final AuthProvider authProvider;

  Future<AuthResult> verifyOtp({
    required OtpVerificationScreenArgs? args,
    required String otp,
  }) async {
    if (args == null) {
      throw Exception('Please request OTP from login screen first');
    }

    if (otp.trim().length != 6) {
      throw Exception('Enter valid OTP');
    }

    state = state.copyWith(isVerifying: true);

    try {
      authProvider.verificationId = args.verificationId;
      authProvider.phoneNumber = args.phoneNumber;
      final authResult = await authProvider.verifyOtp(otp.trim());
      state = state.copyWith(isVerifying: false);
      return authResult;
    } catch (error) {
      state = state.copyWith(isVerifying: false);
      rethrow;
    }
  }
}

final otpVerificationControllerProvider =
    StateNotifierProvider.autoDispose<
      OtpVerificationController,
      OtpVerificationState
    >((ref) {
      return OtpVerificationController(getIt<AuthProvider>());
    });
