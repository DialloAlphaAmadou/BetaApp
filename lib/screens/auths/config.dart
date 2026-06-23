enum SendType {
  confirmAccount,
  resetPassword,
  //resetEmail,
}

extension SendTypeExtension on SendType {
  String get title {
    switch (this) {
      case SendType.confirmAccount:
        return "Confirmation du mail";

      case SendType.resetPassword:
        return "Réinitialisation du mot de passe";
        
    }
  }
}