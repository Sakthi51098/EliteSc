import '../repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<void> call({
    required String userId,
    required String name,
    required String phoneNumber,
    required String avatarPath,
  }) {
    return authRepository.saveUserProfile(
      userId: userId,
      name: name,
      phoneNumber: phoneNumber,
      avatarPath: avatarPath,
    );
  }
}
