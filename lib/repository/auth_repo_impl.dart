import 'package:chess_flutter/domain/entity/credential_entity.dart';
import 'package:chess_flutter/models/auth_response.dart';
import 'package:chess_flutter/models/credential_model.dart';
import 'package:chess_flutter/service/auth_service.dart';

import '../domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;
  AuthRepoImpl(this.authService);

  @override
  Future<AuthResponse> register(CredentialEntity entity) async {
    CredentialModel credentialModel = CredentialModel.fromEntity(entity);
    return authService.register(credentialModel);
  }

  @override
  Future<AuthResponse> login(CredentialEntity entity) {
    CredentialModel credentialModel = CredentialModel.fromEntity(entity);
    return authService.login(credentialModel);
  }

  @override
  Future<AuthResponse> logout(CredentialEntity entity) {
    CredentialModel credentialModel = CredentialModel.fromEntity(entity);
    return authService.logout(credentialModel);
  }
}
