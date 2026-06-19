import '../entities/otp_session.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<OtpSession> call({required String phoneNumber}) {
    return authRepository.sendOtp(phoneNumber: phoneNumber);
  }
}
