import 'package:chess_flutter/domain/repo/auth_repo.dart';

import '../../models/auth_response.dart';
import '../../models/register_credential.dart';

class AuthRegisterUseCase {
  final AuthRepo authRepo;

  AuthRegisterUseCase(this.authRepo);

  Future<AuthResponse> execute(RegisterCredential registerCredential) async {
    return authRepo.register(registerCredential);
  }
}
