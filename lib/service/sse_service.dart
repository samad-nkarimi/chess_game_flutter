import 'dart:async';
import 'dart:convert';

import 'package:chess_flutter/config/network_url.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:http/http.dart' as http;

class SSEService {
  late http.Client _client;
  static final SSEService _singleton = SSEService._internal();
  factory SSEService() {
    return _singleton;
  }
  SSEService._internal();

  StreamController<String> remotePlayStreamController = StreamController();
  StreamController<String> homeStreamController = StreamController();

  subscribe() async {
    String username = ServiceLocator().username;
    print("sse subs...");
    try {
      _client = http.Client();
      var request =
          http.Request('GET', Uri.parse("http://$hostIp:3000/api/connect"));
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
          // if (remotePlayStreamController.isClosed) {
          //   remotePlayStreamController = StreamController();
          // } else {}

          remotePlayStreamController.sink.add(utf8.decode(value));
          homeStreamController.sink.add(utf8.decode(value));
        });
      });
    } catch (e) {
      print("sse error: $e");
    }
  }

  unsubscribe() {
    _client.close();
    homeStreamController.close();
    remotePlayStreamController.close();
  }
}
