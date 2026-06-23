import 'package:first_app/data/api/api_client.dart';
import 'package:first_app/data/local/auth_storage.dart';
import 'package:first_app/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStorageProvider = Provider<AuthStorage>((ref) {
  return AuthStorage();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.read(authStorageProvider);
  return ApiClient(
    storage: storage,
    onLogout: () async {
      await ref.read(authProvider.notifier).logout();
    } );
});

final userScopeProvider = StateProvider<int>((ref) => 0);

