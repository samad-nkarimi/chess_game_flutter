import 'package:chess_flutter/domain/entity/credential_entity.dart';
import 'package:chess_flutter/models/enums/auth_filed_type.dart';

class CredentialValidationHelper {
  static final CredentialValidationHelper _singleton =
      CredentialValidationHelper._internal();
  factory CredentialValidationHelper() {
    return _singleton;
  }
  CredentialValidationHelper._internal();

  bool singleFiledValidationFor(AuthFiledType filed, CredentialEntity entity) {
    switch (filed) {
      case AuthFiledType.username:
        return nameValidation(entity.username);
      case AuthFiledType.email:
        return emailValidation(entity.email);
      case AuthFiledType.password:
        return passwordValidation(entity.password);
      case AuthFiledType.confirmPassword:
        return confirmPasswordValidation(
            entity.confirmPassword, entity.password);

      default:
        return false;
    }
  }

  bool nameValidation(String name) {
    return name.isNotEmpty && name.length < 20;
  }

  bool emailValidation(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool passwordValidation(String password) {
    if (password.length > 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'))) {
      return true;
    } else {
      return false;
    }
  }

  bool confirmPasswordValidation(String value, String password) {
    if (value == password && passwordValidation(value)) {
      return true;
    } else {
      return false;
    }
  }

  bool isFormValidateForSignUp(CredentialEntity entity) {
    if (emailValidation(entity.email) &&
        passwordValidation(entity.password) &&
        nameValidation(entity.username) &&
        confirmPasswordValidation(entity.confirmPassword, entity.password)) {
      return true;
    } else {
      return false;
    }
  }

  bool isFormValidateForLogin(CredentialEntity entity) {
    if (emailValidation(entity.email) && passwordValidation(entity.password)) {
      return true;
    } else {
      return false;
    }
  }
}
