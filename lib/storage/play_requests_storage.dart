import 'dart:convert';

import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/models/remote_play_model.dart';
import 'package:hive/hive.dart';

class PlayRequestsStorage {
  static final PlayRequestsStorage _singleton = PlayRequestsStorage._internal();
  factory PlayRequestsStorage() {
    return _singleton;
  }
  PlayRequestsStorage._internal();

  final String playsBox = "play_requests_box";

  void createBox() async {
    await Hive.openBox<String>(playsBox);
    await Hive.close();
  }

  Future<Box> getBox() async {
    Box box = await Hive.openBox(playsBox);
    return box;
  }

  Future<bool> saveNewRequest(String username, String score) async {
    try {
      Box box = await getBox();
      await box.put(
          username, jsonEncode({"username": username, "score": score}));
      await box.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteRequest(String username) async {
    try {
      Box box = await getBox();
      await box.delete(username);
      await box.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchAllRequests() async {
    try {
      Box box = await getBox();
      box.values;
      await box.close();
    } catch (e) {
      //
    }
  }
}
