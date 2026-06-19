import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/service_locator.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/providers/auth_provider.dart' as app_auth;

final homeTabProvider = StateProvider<int>((ref) => 0);

final currentUserProfileProvider = FutureProvider<UserEntity>((ref) async {
  final currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser == null) {
    throw Exception('User not logged in');
  }

  return getIt<app_auth.AuthProvider>().getUserProfile(currentUser.uid);
});
