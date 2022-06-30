import 'package:chess_flutter/service/auth_service.dart';

import '../domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;
  AuthRepoImpl(this.authService);

  @override
  String login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  void logout() {
    throw UnimplementedError();
  }

  @override
  String register(String email, String name, String password) {
    authService.register();
    throw UnimplementedError();
  }
}
