import 'package:chess_flutter/domain/entity/credential_entity.dart';
import 'package:chess_flutter/domain/helper/credential_validation_helper.dart';
import 'package:chess_flutter/domain/repo/auth_repo.dart';
import 'package:chess_flutter/models/enums/auth_filed_type.dart';

import '../../models/auth_response.dart';

class AuthUseCase {
  final AuthRepo authRepo;

  AuthUseCase(this.authRepo);

  Future<AuthResponse> register(CredentialEntity entity) async {
    return authRepo.register(entity);
  }

  Future<AuthResponse> login(CredentialEntity entity) async {
    return authRepo.login(entity);
  }

  Future<AuthResponse> logout(CredentialEntity entity) async {
    return authRepo.logout(entity);
  }

  bool singleFiledValidationFor(AuthFiledType filed, CredentialEntity entity) {
    return CredentialValidationHelper().singleFiledValidationFor(filed, entity);
  }

  bool credentialValidationForSignUp(CredentialEntity entity) {
    if (CredentialValidationHelper().isFormValidateForSignUp(entity)) {
      return true;
    } else {
      return false;
    }
  }

  bool credentialValidationForLogin(CredentialEntity entity) {
    if (CredentialValidationHelper().isFormValidateForLogin(entity)) {
      return true;
    } else {
      return false;
    }
  }
}
