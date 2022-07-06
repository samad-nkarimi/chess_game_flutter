import 'dart:convert';

import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/models/remote_play_model.dart';
import 'package:hive/hive.dart';

class RemotePlaysStorage {
  static final RemotePlaysStorage _singleton = RemotePlaysStorage._internal();
  factory RemotePlaysStorage() {
    return _singleton;
  }
  RemotePlaysStorage._internal();

  final String playsBox = "remote_plays_box";

  void createBox() async {
    await Hive.openBox<String>(playsBox);
    await Hive.close();
  }

  Future<Box> getBox() async {
    Box box = await Hive.openBox(playsBox);
    return box;
  }

  Future<void> savePlayWith(RemotePlayModel remotePlayModel) async {
    Box box = await getBox();
    await box.put(remotePlayModel.targetUsername, remotePlayModel.toJson());
    await box.close();
  }

  Future<void> updatePlay(RemotePlayModel remotePlayModel) async {
    Box box = await getBox();
    await box.put(remotePlayModel.targetUsername, remotePlayModel.toJson());
    await box.close();
  }

  Future<void> deletePlay(String username) async {
    Box box = await getBox();
    bool isTherePlay = box.containsKey(username);
    if (isTherePlay) {
      await box.delete(username);
    }
    await box.close();
  }

  Future<RemotePlayModel> loadPlayWith(String username) async {
    Box box = await getBox();
    String json = await box.get(username);
    print("model: $json");
    RemotePlayModel remotePlayModel =
        RemotePlayModel.fromJson(jsonDecode(json));
    await box.close();
    return remotePlayModel;
  }

  Future<List<RemotePlayModel>> loadAllPlays() async {
    List<RemotePlayModel> plays = [];
    Box box = await getBox();
    plays =
        box.values.map((e) => RemotePlayModel.fromJson(jsonDecode(e))).toList();
    await box.close();
    return plays;
  }

  Future<bool> isThereAPlaywith(String username) async {
    Box box = await getBox();
    bool isTherePlay = box.containsKey(username);
    await box.close();
    return isTherePlay;
  }
}
