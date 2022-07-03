import 'dart:convert';

import 'package:chess_flutter/models/remote_move_details.dart';
import 'package:http/http.dart' as http;

class RemoteMoveService {
  void sendMoveToServer(RemoteMoveDetails remoteMoveDetails) async {
    var url = Uri.parse('http://localhost:3000/api/remote-move');

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "request_username": remoteMoveDetails.requestUsername,
          "terget_username": remoteMoveDetails.targetUsername,
          "move_from_col": remoteMoveDetails.fromBox.columnNumber,
          "move_from_row": remoteMoveDetails.fromBox.rowNumber,
          "move_to_col": remoteMoveDetails.toBox.columnNumber,
          "move_to_row": remoteMoveDetails.toBox.rowNumber,
        }));

    print(response.body);
  }
}
