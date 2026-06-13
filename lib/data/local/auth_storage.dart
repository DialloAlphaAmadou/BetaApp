import 'package:first_app/dto/auth_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveTokensAsync(SessionResponse session) async {
    await _storage.write(key: 'accessToken', value: session.accessToken);
    await _storage.write(key: 'refreshToken', value: session.refreshToken);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: 'refreshToken');
  }

  Future<void> clearSessionAsync() async {
    await _storage.delete(key: 'accessToken');
    await _storage.delete(key: 'refreshToken');
  }

  Future<void> clearAsync() async {
    await _storage.deleteAll();
  }

  //Récupérer les infos du JWT
  Future<TokenInfo?> getTokenInfoAsync() async {
    final token = await getAccessToken();
    if (token == null) return null;
    final decoded = JwtDecoder.decode(token);
    return TokenInfo.fromJwt(decoded);
  }

  //Vérifie si connecté
  Future<bool> isAuthAsync() async {
    final accessToken = await getAccessToken();
    return accessToken != null;
  }

  //Verifier si token a expirer
  Future<bool> isAccessTokenExpiredAsync() async {
    final token = await getAccessToken();
    if (token == null) return true;
    return JwtDecoder.isExpired(token);
  }
  
}