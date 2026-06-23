import 'package:first_app/data/local/auth_storage.dart';
import 'package:first_app/dto/auth_dto.dart';
import 'package:first_app/data/api/api_client.dart';
import 'package:first_app/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository{

  final ApiClient client;
  final AuthStorage token;

  AuthRepository(this.client, this.token);

  //Enregistrement
  @override
  Future<void> registerAsync(RegisterRequest request) async {
    await client.post('/auth/register', data: request.toJson());
  }

  //Connexion
  @override
  Future<void> loginAsync(LoginRequest request) async {
    final response = await client.post('/auth/login', data: request.toJson());
    final session = SessionResponse.fromJson(response.data);
    await token.saveTokensAsync(session);
  }

  //Deconnexion
  @override
  Future<void> logoutAsync() async {
    try {
      final refreshToken = await token.getRefreshToken();
      if (refreshToken != null) await client.post('/auth/logout', data: {'RefreshToken': refreshToken,});
    } finally {
      await token.clearSessionAsync();
    }
  }

  //Deconnexion du user a tout ces appareilles 
  @override
  Future<void> logoutAllAsync() async {
    try {
      final user = await token.getTokenInfoAsync();
      if (user != null) await client.post('/auth/logout-all', data:  {'UserId': user.userId});
    } finally {
      await token.clearSessionAsync();
    }
  }

  //Actualisation de la session
  @override
  Future<void> refreshSessionAsync() async {
    try {
      final refreshToken = await token.getRefreshToken();
      if (refreshToken == null) throw Exception('No refresh token');
      final response = await client.post('/auth/refresh-session', data:  {'RefreshToken': refreshToken});
      final session = SessionResponse.fromJson(response.data);
      await token.saveTokensAsync(session);
    } finally {
      await token.clearSessionAsync();
    }
  }

  //Envoi du code confirmation a email du user
  @override
  Future<void> sendConfirmEmailAsync(EmailRequest request) async {
    await client.post('/auth/send-confirm-email', data: request.toJson());
  }

  //Confirmation du compte
  @override
  Future<void> confirmAccountAsync(ConfirmAccountRequest request) async {
    await client.post('/auth/confirm-email', data: request.toJson());
  }

  //Modification du password
  @override
  Future<void> resetPasswordAsync(ResetPasswordRequest request) async {
    await client.post('/auth/reset-password', data: request.toJson());
  }

  //Modification du password
  @override
  Future<void> changePasswordAsync(ChangePasswordRequest request) async {
    final response = await client.post('/auth/password', data: request.toJson());
    final session = SessionResponse.fromJson(response.data);
    await token.saveTokensAsync(session);
  }


/*
  //Récupérer les infos du JWT
  @override
  Future<TokenInfo?> getCurrentUserAsync() async {
    final accessToken = await token.getAccessToken();
    if (accessToken == null) return null;
    final decoded = JwtDecoder.decode(accessToken);
    return TokenInfo.fromJwt(decoded);
  }

  //Vérifie si connecté
  @override
  Future<bool> isAuthAsync() async {
    final accessToken = await token.getAccessToken();
    return accessToken != null;
  }
  */
  

}


/*
class AuthRepository {
  final ApiClient api;

  AuthRepository(this.api);

  Future<Map<String, dynamic>> login( String email, String password, ) async {
    final response = await api.dio.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    return response.data;
  }

  Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await api.dio.post(
      '/auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    return response.data;
  }

  Future<void> resetPassword(String email) async {
    await api.dio.post(
      '/auth/reset-password',
      data: {
        'email': email,
      },
    );
  }
}*/