import 'dart:convert';

import 'package:chess_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  var url = Uri.parse('http://localhost:3000/api/players/find-all');
  var token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwbGF5ZXJfaWQiOjEsImVtYWlsIjoic2FtYWQubmthcmltaUBnbWFpbC5jb20iLCJpYXQiOjE2NTY1MzAzNDcsImV4cCI6MTY1NjU0ODM0N30.KMEgPo31XiCKxKIjnwvjR5ov618XXXiyVgKpGUAfgPA";
  Future<List<User>> fetchUsers() async {
    List<User> users = [];
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    users = User.usersFromJson(jsonDecode(response.body));
    return users;
  }

  //
  Future<List<User>> findUsersById(String username) async {
    var url = Uri.parse('http://localhost:3000/api/players/find-all/$username');
    List<User> users = [];
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    print(response.body);
    users = User.usersFromJson(jsonDecode(response.body));
    print(users);
    return users;
  }
}
