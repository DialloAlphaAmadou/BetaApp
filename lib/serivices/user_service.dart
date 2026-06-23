import 'package:first_app/dto/user_dto.dart';
import 'package:first_app/providers/provider.dart';
import 'package:first_app/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final api = ref.read(apiClientProvider);
  final storage = ref.read(authStorageProvider);
  return UserRepository(api, storage);
});

final profileProvider = FutureProvider<UserResponse>((ref) async {
  ref.watch(userScopeProvider); // dépendance
  return ref.read(userRepositoryProvider).getProfileAsync();
});