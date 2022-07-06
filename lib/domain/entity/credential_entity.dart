import 'package:chess_flutter/models/enums/auth_type.dart';

class CredentialEntity {
  String username;
  String email;
  String password;
  String confirmPassword;
  AuthType authType;

  CredentialEntity(
    this.username,
    this.email,
    this.password,
    this.confirmPassword, [
    this.authType = AuthType.signup,
  ]);
}
