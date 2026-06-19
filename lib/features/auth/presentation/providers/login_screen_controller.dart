import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/service_locator.dart';
import '../../../../core/utils/network_helper.dart';
import '../../domain/entities/auth_result.dart';
import 'auth_provider.dart';

class LoginState {
  const LoginState({
    this.phoneNumber = '',
    this.otp = '',
    this.isSendingOtp = false,
    this.isLoggingIn = false,
    this.otpSent = false,
  });

  final String phoneNumber;
  final String otp;
  final bool isSendingOtp;
  final bool isLoggingIn;
  final bool otpSent;

  bool get isPhoneValid => phoneNumber.trim().length == 10;
  bool get isOtpValid => otp.trim().length == 6;
  bool get canSendOtp => isPhoneValid && !isSendingOtp;

  LoginState copyWith({
    String? phoneNumber,
    String? otp,
    bool? isSendingOtp,
    bool? isLoggingIn,
    bool? otpSent,
  }) {
    return LoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      isSendingOtp: isSendingOtp ?? this.isSendingOtp,
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
      otpSent: otpSent ?? this.otpSent,
    );
  }
}

class LoginScreenController extends StateNotifier<LoginState> {
  LoginScreenController(this.authProvider) : super(const LoginState());

  final AuthProvider authProvider;

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  void updateOtp(String value) {
    state = state.copyWith(otp: value);
  }

  Future<void> sendOtp() async {
    if (!state.isPhoneValid) {
      throw Exception('Enter a valid phone number');
    }

    final hasInternet = await NetworkHelper.hasInternet();

    if (!hasInternet) {
      throw Exception('No internet connection');
    }

    state = state.copyWith(isSendingOtp: true);

    try {
      await authProvider.sendOtp('+91${state.phoneNumber.trim()}');
      state = state.copyWith(isSendingOtp: false, otpSent: true);
    } catch (error) {
      state = state.copyWith(isSendingOtp: false);
      rethrow;
    }
  }

  Future<AuthResult> login() async {
    if (!state.otpSent) {
      throw Exception('Please get OTP first');
    }

    if (!state.isOtpValid) {
      throw Exception('Enter valid OTP');
    }

    final hasInternet = await NetworkHelper.hasInternet();

    if (!hasInternet) {
      throw Exception('No internet connection');
    }

    state = state.copyWith(isLoggingIn: true);

    try {
      final authResult = await authProvider.verifyOtp(state.otp.trim());
      state = state.copyWith(isLoggingIn: false);
      return authResult;
    } catch (error) {
      state = state.copyWith(isLoggingIn: false);
      rethrow;
    }
  }
}

final loginScreenControllerProvider =
    StateNotifierProvider.autoDispose<LoginScreenController, LoginState>((ref) {
      return LoginScreenController(getIt<AuthProvider>());
    });
