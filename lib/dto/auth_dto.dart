class LoginRequest {
  final String userName;
  final String password;
  final bool rememberMe;

  LoginRequest({ required this.userName, required this.password, required this.rememberMe});

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Password': password,
      'RememberMe': rememberMe,
    };
  }
}

class SessionResponse {
  final String accessToken;
  final String refreshToken;

  SessionResponse({required this.accessToken, required this.refreshToken});

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    return SessionResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken']
    );
  }  
}

class RegisterRequest {
  final String email;
  final String password;
  final String userName;
  final String firstName;
  final String lastName;
  final String? phoneNumber;

  RegisterRequest({
    required this.lastName, required this.firstName,
    required this.userName, this.phoneNumber,
    required this.email, required this.password
  });

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'Password': password,
      'UserName': userName,
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
    };
  }
}

class EmailRequest {
  final String email;

  EmailRequest({ required this.email});

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
    };
  }
}

class ConfirmAccountRequest {
  final String email;
  final String code;

  ConfirmAccountRequest({required this.email, required this.code});

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'Code': code,
    };
  }
}

class ResetPasswordRequest {
  final String email;
  final String code;
  final String newPassword;

  ResetPasswordRequest({required this.email, required this.code, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'Email': email,
      'Code': code,
      'NewPassword': newPassword,
    };
  }
}

class ChangePasswordRequest {
  final String refreshToken;
  final String password;
  final String newPassword;

  ChangePasswordRequest({required this.refreshToken, required this.password, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'RefreshToken': refreshToken,
      'Password': password,
      'NewPassword': newPassword,
    };
  }
}

class TokenInfo {
  final String userId;
  final String userName;
  final String email;
  final List<String> roles;

  TokenInfo({required this.userId, required this.userName, required this.email, required this.roles});

  factory TokenInfo.fromJwt(Map<String, dynamic> json) {
    return TokenInfo(
      userId: json['sub'].toString(),
      userName: json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'].toString(),
      email: json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress'].toString(),
      roles: _extractRoles(json['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']),
    );
  }

  static List<String> _extractRoles(dynamic roleClaim) {
    if (roleClaim == null) return [];
    if (roleClaim is String) return [roleClaim];
    if (roleClaim is List) return roleClaim.map((e) => e.toString()).toList();
    return [];
  }
}