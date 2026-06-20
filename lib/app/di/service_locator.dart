import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/game/data/repositories/free_game_repository_impl.dart';
import '../../features/game/presentation/providers/game_provider.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  if (getIt.isRegistered<AuthRepositoryImpl>()) {
    return;
  }

  getIt.registerLazySingleton<AuthRepositoryImpl>(AuthRepositoryImpl.new);
  getIt.registerLazySingleton<FreeGameRepositoryImpl>(
    FreeGameRepositoryImpl.new,
  );

  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(authRepository: getIt<AuthRepositoryImpl>()),
  );
  getIt.registerFactory<GameProvider>(
    () => GameProvider(freeGameRepository: getIt<FreeGameRepositoryImpl>()),
  );
}
