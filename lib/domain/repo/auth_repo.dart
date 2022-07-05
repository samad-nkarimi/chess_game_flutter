import 'package:chess_flutter/domain/entity/credential_entity.dart';

import '../../models/auth_response.dart';

abstract class AuthRepo {
  Future<AuthResponse> signUp(CredentialEntity entity);
  Future<AuthResponse> login(CredentialEntity entity);
  Future<AuthResponse> logout(CredentialEntity entity);
}
