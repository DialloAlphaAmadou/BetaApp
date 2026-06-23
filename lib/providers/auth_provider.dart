import 'package:first_app/dto/auth_dto.dart';
import 'package:first_app/providers/provider.dart';
import 'package:first_app/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.read(apiClientProvider);
  final storage = ref.read(authStorageProvider);
  return AuthRepository(api, storage);
});

enum AuthStatus {
  loading,
  authenticated,
  unauthenticated,
}

class AuthState {
  final AuthStatus status;
  final TokenInfo? info;

  const AuthState({
    required this.status,
    this.info,
  });

  const AuthState.loading()
      : status = AuthStatus.loading,
        info = null;

  const AuthState.authenticated(this.info)
      : status = AuthStatus.authenticated;

  const AuthState.unauthenticated()
      : status = AuthStatus.unauthenticated,
        info = null;
}


class AuthNotifier extends StateNotifier<AuthState> {

  AuthNotifier(this.ref) : super(const AuthState.loading()) {
    _init();
  }

  final Ref ref;

  Future<void> _init() async {
    final storage = ref.read(authStorageProvider);
    try {

      final token = await storage.getAccessToken();

      if (token == null) {
        state = const AuthState.unauthenticated();
        return;
      }

      final info = await storage.getTokenInfoAsync();

      state = AuthState.authenticated(info);
    } catch (e) {
      await logout();
    }
  }

  Future<void> login(LoginRequest data) async {
    final repo = ref.read(authRepositoryProvider);
    final storage = ref.read(authStorageProvider);

    await repo.loginAsync(data);
    final user = await storage.getTokenInfoAsync();
    state = AuthState.authenticated(user);

    //Reset ALL user data d'un coup
    //ref.read(userScopeProvider.notifier).state++;
  }

  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.logoutAsync();
    state = const AuthState.unauthenticated();
    ref.read(userScopeProvider.notifier).state++;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier(ref));
