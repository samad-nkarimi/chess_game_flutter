import 'package:chess_flutter/models/play_request.dart';

abstract class PlayRequestStorageRepo {
  Future<bool> saveNewRequest(String username, String score);
  Future<bool> deleteRequest(String username);
  Future<List<PlayRequest>> fetchAllRequests();
}
