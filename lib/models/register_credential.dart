import 'package:chess_flutter/models/enums/auth_type.dart';

class RegisterCredential {
  final String name;
  final String email;
  final String password;
  final AuthType authType;

  RegisterCredential(this.name, this.email, this.password, this.authType);
}
