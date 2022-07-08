import 'dart:convert';

import 'package:chess_flutter/config/network_url.dart';
import 'package:http/http.dart' as http;

class RequestPlayService {
  Future<bool> sendPlayRequest(
      String requestUsername, String targetUsername) async {
    var url = Uri.parse('http://$hostIp:3000/api/remote-play/request');
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "request_username": requestUsername,
            "target_username": targetUsername,
          }));

      print(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  //
  Future<bool> acceptPlayRequest(
      String requestUsername, String targetUsername) async {
    var url = Uri.parse('http://$hostIp:3000/api/remote-play/accept-request');
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "request_username": requestUsername,
            "target_username": targetUsername,
          }));

      print(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  //
  Future<bool> rejectPlayRequest(
      String requestUsername, String targetUsername) async {
    var url = Uri.parse('http://$hostIp:3000/api/remote-play/reject-request');
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "request_username": requestUsername,
            "target_username": targetUsername,
          }));

      print(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> cancellPlay(
      String requestUsername, String targetUsername) async {
    var url = Uri.parse('http://$hostIp:3000/api/remote-play/cancell-play');
    try {
      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "request_username": requestUsername,
            "target_username": targetUsername,
          }));

      print(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }
}
