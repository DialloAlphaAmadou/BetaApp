import 'package:first_app/dto/auth_dto.dart';
import 'package:flutter/material.dart';

class AuthFormControllers {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();

  // Register
  final TextEditingController lastName = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  void dispose() {
    firstName.dispose();
    lastName.dispose();
    userName.dispose();
    password.dispose();
    email.dispose();
    phoneNumber.dispose();
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
  
  
}