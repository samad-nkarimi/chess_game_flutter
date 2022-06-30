import 'package:chess_flutter/models/register_credential.dart';

import '../../models/auth_response.dart';

abstract class AuthRepo {
  Future<AuthResponse> register(RegisterCredential registerCredential);
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> logout();
}
