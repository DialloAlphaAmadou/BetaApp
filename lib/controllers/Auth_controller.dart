import 'package:first_app/dto/auth_dto.dart';
import 'package:flutter/material.dart';

class AuthFormControllers {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  //Register
  final TextEditingController lastName = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController code = TextEditingController();

  final TextEditingController refreshToken = TextEditingController();
  final TextEditingController newPassword = TextEditingController();

  void dispose() {
    firstName.dispose();
    lastName.dispose();
    userName.dispose();
    password.dispose();
    confirmPassword.dispose();
    email.dispose();
    phoneNumber.dispose();
    code.dispose();
    refreshToken.dispose();
    newPassword.dispose();
  }

  void clear() {
    firstName.clear();
    lastName.clear();
    userName.clear();
    password.clear();
    confirmPassword.clear();
    email.clear();
    phoneNumber.clear();
    code.clear();
  }

  RegisterRequest toRegisterRequest() {
    return RegisterRequest(
      firstName: firstName.text,
      lastName: lastName.text,
      email: email.text,
      phoneNumber: phoneNumber.text,
      userName: userName.text,
      password: password.text,
    );
  }

  LoginRequest toLoginRequest(bool rememberMe) {
    return LoginRequest(
      userName: userName.text,
      password: password.text,
      rememberMe: rememberMe
    );
  }

  EmailRequest toEmailRequest() {
    return EmailRequest(
      email: email.text,
    );
  }

  ConfirmAccountRequest toConfirmAccountRequest() {
    return ConfirmAccountRequest(
      email: email.text,
      code: code.text,
    );
  }

  ResetPasswordRequest toResetPasswordRequest() {
    return ResetPasswordRequest(
      email: email.text,
      code: code.text,
      newPassword: password.text
    );
  }

  ChangePasswordRequest toChangePasswordRequest() {
    return ChangePasswordRequest(
      refreshToken: refreshToken.text,
      password: password.text,
      newPassword: newPassword.text
    );
  }
  
  
}