import 'package:chess_flutter/domain/entity/credential_entity.dart';

class CredentialModel {
  final String username;
  final String email;
  final String password;

  CredentialModel(this.username, this.email, this.password);

  CredentialModel.fromEntity(CredentialEntity entity)
      : username = entity.username,
        email = entity.email,
        password = entity.password;
}
