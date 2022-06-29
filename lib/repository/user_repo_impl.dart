import 'package:chess_flutter/domain/user_repo.dart';
import 'package:chess_flutter/models/user.dart';
import 'package:chess_flutter/service/user_service.dart';
import 'package:http/http.dart';

class UserRepoImpl implements UserRepo {
  final UserService userService;

  final String url = "";

  UserRepoImpl(this.userService);

  @override
  List<User> findUserById() {
    post(Uri.parse(url));
    throw Exception();
  }

  @override
  Future<List<User>> getUsers() async {
    return userService.fetchUsers();
  }
}
