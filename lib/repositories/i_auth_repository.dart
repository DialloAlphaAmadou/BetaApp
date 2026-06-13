import 'package:first_app/dto/auth_dto.dart';

abstract class IAuthRepository {
  Future<void> registerAsync(RegisterRequest request);

  //Future<SessionResponse> loginAsync(LoginRequest request);
  Future<void> loginAsync(LoginRequest request);

  //Future<void> logoutAsync(String refreshToken);
  Future<void> logoutAsync();

  //Future<void> logoutAllAsync(String userId);
  Future<void> logoutAllAsync();

  //Future<SessionResponse> refreshSessionAsync(String refreshToken);
  Future<void> refreshSessionAsync();

  //Future<SessionResponse> changePasswordAsync(ChangePasswordRequest request);
  Future<void> changePasswordAsync(ChangePasswordRequest request);

  //ici avec code de confirmation
  Future<void> sendConfirmEmailAsync(EmailRequest request);
  Future<void> confirmAccountAsync(ConfirmAccountRequest request);
  Future<void> resetPasswordAsync(ResetPasswordRequest request);

  //
  //Future<bool> isAuthAsync();
  //Future<TokenInfo?> getCurrentUserAsync();
}