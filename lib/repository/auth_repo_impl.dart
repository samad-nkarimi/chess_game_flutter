import 'package:chess_flutter/models/auth_response.dart';
import 'package:chess_flutter/models/register_credential.dart';
import 'package:chess_flutter/service/auth_service.dart';

import '../domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;
  AuthRepoImpl(this.authService);

  @override
  Future<AuthResponse> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<AuthResponse> register(RegisterCredential registerCredential) async {
    return authService.register(registerCredential);
  }
}
