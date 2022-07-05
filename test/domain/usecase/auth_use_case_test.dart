import 'dart:math';

import 'package:chess_flutter/domain/entity/credential_entity.dart';
import 'package:chess_flutter/domain/use_case/auth_register_use_case.dart';
import 'package:chess_flutter/repository/auth_repo_impl.dart';
import 'package:chess_flutter/service/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("auth usecase: ", () {
    CredentialEntity credentialEntity = CredentialEntity(
        "samad", "samad@gmail.com", "Sn123456780", "Sn123456780");
    CredentialEntity credentialEntity1 =
        CredentialEntity("samad", "samad@gmailcom", "Sn12345678", "Sn12345678");
    CredentialEntity credentialEntity2 =
        CredentialEntity("samad", "samadgmail.com", "Sn12345678", "Sn12345678");
    CredentialEntity credentialEntity3 =
        CredentialEntity("samad", "samad@gmail.com", "Sn12345678", "Sn1234567");
    CredentialEntity credentialEntity4 =
        CredentialEntity("samad", "samad@gmail.com", "Sn1234", "Sn1234");
    AuthRegisterUseCase authRegisterUseCase =
        AuthRegisterUseCase(AuthRepoImpl(AuthService()));
    test("sign up credential verification: ", () {
      bool isValid =
          authRegisterUseCase.credentialValidationForSignUp(credentialEntity);
      bool isValid1 =
          authRegisterUseCase.credentialValidationForSignUp(credentialEntity1);
      bool isValid2 =
          authRegisterUseCase.credentialValidationForSignUp(credentialEntity2);
      bool isValid3 =
          authRegisterUseCase.credentialValidationForSignUp(credentialEntity3);
      bool isValid4 =
          authRegisterUseCase.credentialValidationForSignUp(credentialEntity4);
      expect(isValid, true);
      expect(isValid1, false);
      expect(isValid2, false);
      expect(isValid3, false);
      expect(isValid4, false);
    });
    test("login credential verification: ", () {
      bool isValid =
          authRegisterUseCase.credentialValidationForLogin(credentialEntity);
      bool isValid1 =
          authRegisterUseCase.credentialValidationForLogin(credentialEntity1);
      bool isValid2 =
          authRegisterUseCase.credentialValidationForLogin(credentialEntity2);
      bool isValid3 =
          authRegisterUseCase.credentialValidationForLogin(credentialEntity3);
      bool isValid4 =
          authRegisterUseCase.credentialValidationForLogin(credentialEntity4);
      expect(isValid, true);
      expect(isValid1, false);
      expect(isValid2, false);
      expect(isValid3, true);
      expect(isValid4, false);
    });
  });
}
