import 'package:chess_flutter/domain/repo/auth_repo.dart';

import '../../models/register_credential.dart';

class AuthRegisterUseCase {
  final AuthRepo authRepo;

  AuthRegisterUseCase(this.authRepo);

  void execute(RegisterCredential registerCredential) {
    authRepo.register(
      registerCredential.email,
      registerCredential.name,
      registerCredential.password,
    );
  }
}
