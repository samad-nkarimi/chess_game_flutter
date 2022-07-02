import 'dart:convert';

import 'package:http/http.dart' as http;

class PlayService {
  void sendPlayRequest(String requestUsername, String targetUsername) async {
    var url = Uri.parse('http://localhost:3000/api/remote-play/request');

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "request_username": requestUsername,
          "target_username": targetUsername,
        }));

    print(response.body);
    // users = User.usersFromJson(jsonDecode(response.body));
    // print(users);
    // return users;
  }
}
