import '../entities/auth_result.dart';
import '../entities/otp_session.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  const AuthRepository();

  Future<OtpSession> sendOtp({required String phoneNumber});

  Future<AuthResult> verifyOtp({
    required String verificationId,
    required String smsCode,
  });

  Future<void> saveUserProfile({
    required String userId,
    required String name,
    required String phoneNumber,
    required String avatarPath,
  });

  Future<UserEntity> getUserProfile(String userId);

  Future<void> logout();
}
