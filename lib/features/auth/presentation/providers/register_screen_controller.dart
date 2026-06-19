import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/di/service_locator.dart';
import '../models/register_screen_args.dart';
import 'auth_provider.dart';

class RegisterState {
  const RegisterState({this.selectedAvatar = '', this.isSaving = false});

  final String selectedAvatar;
  final bool isSaving;

  RegisterState copyWith({String? selectedAvatar, bool? isSaving}) {
    return RegisterState(
      selectedAvatar: selectedAvatar ?? this.selectedAvatar,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

class RegisterScreenController extends StateNotifier<RegisterState> {
  RegisterScreenController(this.authProvider) : super(const RegisterState());

  final AuthProvider authProvider;

  void selectAvatar(String avatar) {
    state = state.copyWith(selectedAvatar: avatar);
  }

  Future<void> saveProfile({
    required RegisterScreenArgs? args,
    required String name,
  }) async {
    if (name.trim().isEmpty) {
      throw Exception('Enter your name');
    }

    if (name.trim().length < 3) {
      throw Exception('Name should be at least 3 characters');
    }

    if (state.selectedAvatar.isEmpty) {
      throw Exception('Please select avatar');
    }

    if (args == null) {
      throw Exception('User details not available');
    }

    state = state.copyWith(isSaving: true);

    try {
      await authProvider.saveUser(
        userId: args.userId,
        name: name.trim(),
        phoneNumber: args.phoneNumber,
        avatarPath: state.selectedAvatar,
      );
      state = state.copyWith(isSaving: false);
    } catch (error) {
      state = state.copyWith(isSaving: false);
      rethrow;
    }
  }
}

final registerScreenControllerProvider =
    StateNotifierProvider.autoDispose<RegisterScreenController, RegisterState>((
      ref,
    ) {
      return RegisterScreenController(getIt<AuthProvider>());
    });
