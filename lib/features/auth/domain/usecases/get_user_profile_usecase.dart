import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetUserProfileUseCase {
  const GetUserProfileUseCase(this.authRepository);

  final AuthRepository authRepository;

  Future<UserEntity> call(String userId) {
    return authRepository.getUserProfile(userId);
  }
}
