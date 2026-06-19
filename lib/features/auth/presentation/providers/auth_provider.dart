import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';

class AuthProvider {
  AuthProvider({AuthRepositoryImpl? authRepository}) {
    this.authRepository = authRepository ?? AuthRepositoryImpl();
    loginUseCase = LoginUseCase(this.authRepository);
    verifyOtpUseCase = VerifyOtpUseCase(this.authRepository);
    registerUseCase = RegisterUseCase(this.authRepository);
    getUserProfileUseCase = GetUserProfileUseCase(this.authRepository);
  }

  late final AuthRepositoryImpl authRepository;
  late final LoginUseCase loginUseCase;
  late final VerifyOtpUseCase verifyOtpUseCase;
  late final RegisterUseCase registerUseCase;
  late final GetUserProfileUseCase getUserProfileUseCase;

  String verificationId = '';
  String phoneNumber = '';

  Future<void> sendOtp(String rawPhoneNumber) async {
    final session = await loginUseCase.call(phoneNumber: rawPhoneNumber);
    verificationId = session.verificationId;
    phoneNumber = session.phoneNumber;
  }

  Future<AuthResult> verifyOtp(String otp) {
    return verifyOtpUseCase.call(verificationId: verificationId, smsCode: otp);
  }

  Future<void> saveUser({
    required String userId,
    required String name,
    required String phoneNumber,
    required String avatarPath,
  }) {
    return registerUseCase.call(
      userId: userId,
      name: name,
      phoneNumber: phoneNumber,
      avatarPath: avatarPath,
    );
  }

  Future<UserEntity> getUserProfile(String userId) {
    return getUserProfileUseCase.call(userId);
  }

  Future<void> logout() {
    return authRepository.logout();
  }
}
