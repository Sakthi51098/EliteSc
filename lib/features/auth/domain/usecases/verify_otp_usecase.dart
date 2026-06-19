import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  const VerifyOtpUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<AuthResult> call({
    required String verificationId,
    required String smsCode,
  }) {
    return authRepository.verifyOtp(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }
}
