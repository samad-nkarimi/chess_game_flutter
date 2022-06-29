import 'package:chess_flutter/domain/auth_repo.dart';
import 'package:chess_flutter/service/auth_service.dart';

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
    throw UnimplementedError();
  }
}
