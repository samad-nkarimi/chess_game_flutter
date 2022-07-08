import 'package:chess_flutter/models/user.dart';
import 'package:chess_flutter/service/user_service.dart';
import 'package:http/http.dart';

import '../domain/repo/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final UserService userService;

  final String url = "";

  UserRepoImpl(this.userService);

  @override
  Future<List<User>> getUsers() async {
    return userService.fetchUsers();
  }

  @override
  Future<List<User>> findUserById(String username) {
    return userService.findUsersById(username);
  }
}
