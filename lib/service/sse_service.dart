import 'dart:async';
import 'dart:convert';

import 'package:chess_flutter/service_locator.dart';
import 'package:http/http.dart' as http;

class SSEService {
  late http.Client _client;
  static final SSEService _singleton = SSEService._internal();
  factory SSEService() {
    return _singleton;
  }
  SSEService._internal();

  StreamController<String> streamController = StreamController();

  subscribe() async {
    String username = ServiceLocator().username;
    print("sse subs...");
    try {
      _client = http.Client();
      var request =
          http.Request('GET', Uri.parse("http://localhost:3000/api/connect"));
      request.headers["Cache-Controll"] = 'no-Cache';
      // request.headers["Content-Type"] = 'text/plain';
      request.headers["Accept"] = 'text/event-stream';
      request.headers["Connection"] = 'keep-alive';
      request.headers["username"] = username;
      // request.body = json.encode({"username": username});

      Future<http.StreamedResponse> response = _client.send(request);
      response.asStream().listen((event) {
        print(event.statusCode);
        event.stream.listen((value) {
          print(utf8.decode(value));
          streamController.sink.add(utf8.decode(value));
        });
      });
    } catch (e) {
      print("sse error: $e");
    }
  }

  unsubscribe() {
    _client.close();
  }
}
