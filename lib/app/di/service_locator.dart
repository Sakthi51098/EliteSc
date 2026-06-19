import 'package:get_it/get_it.dart';

import '../../core/network/api_client.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/presentation/providers/dashboard_provider.dart';
import '../../features/game/data/repositories/free_game_repository_impl.dart';
import '../../features/game/data/repositories/game_repository_impl.dart';
import '../../features/game/presentation/providers/game_provider.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  if (getIt.isRegistered<ApiClient>()) {
    return;
  }

  getIt.registerLazySingleton<ApiClient>(ApiClient.new);
  getIt.registerLazySingleton<AuthRepositoryImpl>(AuthRepositoryImpl.new);
  getIt.registerLazySingleton<DashboardRepositoryImpl>(
    DashboardRepositoryImpl.new,
  );
  getIt.registerLazySingleton<GameRepositoryImpl>(
    () => GameRepositoryImpl(apiClient: getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<FreeGameRepositoryImpl>(
    FreeGameRepositoryImpl.new,
  );

  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(authRepository: getIt<AuthRepositoryImpl>()),
  );
  getIt.registerFactory<DashboardProvider>(
    () => DashboardProvider(
      dashboardRepository: getIt<DashboardRepositoryImpl>(),
    ),
  );
  getIt.registerFactory<GameProvider>(
    () => GameProvider(
      gameRepository: getIt<GameRepositoryImpl>(),
      freeGameRepository: getIt<FreeGameRepositoryImpl>(),
    ),
  );
}
