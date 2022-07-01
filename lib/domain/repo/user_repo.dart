import 'package:chess_flutter/models/user.dart';

abstract class UserRepo {
  Future<List<User>> getUsers();
  Future<List<User>> findUserById(String username);
}
