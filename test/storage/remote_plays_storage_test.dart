import 'dart:math';

import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/models/enums/remote_play_status.dart';
import 'package:chess_flutter/models/remote_play_model.dart';
import 'package:chess_flutter/storage/remote_plays_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  group("plays storage test", () {
    RemotePlaysStorage remotePlaysStorage = RemotePlaysStorage();
    RemotePlayModel remotePlayModel = RemotePlayModel(
        targetUsername: "samad",
        targetScore: "0",
        status: "wating",
        startDate: DateTime.now().toString());
    RemotePlayEntity remotePlayEntity = RemotePlayEntity(
      "negar",
      "0",
      RemotePlayStatus.finished,
      DateTime.now(),
    );
    RemotePlayModel remotePlayModel2 =
        RemotePlayModel.fromEntity(remotePlayEntity);
    test("save play", () async {
      print(1);
      await Hive.initFlutter();
      Box box = await remotePlaysStorage.getBox();
      box.clear();
      await remotePlaysStorage.savePlayWith(remotePlayModel);
      box = await remotePlaysStorage.getBox();
      expect(box.containsKey("samad"), true);
      expect(box.get("samad"), remotePlayModel.toJson());
      expect(box.values.length, 1);
    });
    test("save play from entity", () async {
      print(2);
      await Hive.initFlutter();
      await remotePlaysStorage.savePlayWith(remotePlayModel2);
      Box box = await remotePlaysStorage.getBox();
      expect(box.containsKey("negar"), true);
      expect(box.get("negar"), remotePlayModel2.toJson());
      expect(box.values.length, 2);
    });
    test("load play", () async {
      print(3);
      await Hive.initFlutter();
      RemotePlayModel loadedPlay =
          await remotePlaysStorage.loadPlayWith(remotePlayModel.targetUsername);
      // Box box = await remotePlaysStorage.getBox();
      expect(loadedPlay, remotePlayModel);
      expect(loadedPlay.toEntity(), remotePlayModel.toEntity());
    });
    test("load play from entity", () async {
      print(4);
      await Hive.initFlutter();
      RemotePlayModel loadedPlay = await remotePlaysStorage
          .loadPlayWith(remotePlayModel2.targetUsername);
      // Box box = await remotePlaysStorage.getBox();
      expect(loadedPlay, remotePlayModel2);
      expect(loadedPlay.toEntity(), remotePlayModel2.toEntity());
    });
    test("check if play exists", () async {
      print(5);
      await Hive.initFlutter();
      bool isThere = await remotePlaysStorage.isThereAPlaywith("samad");
      expect(isThere, true);
    });
    test("delete play", () async {
      print(6);
      await Hive.initFlutter();
      await remotePlaysStorage.deletePlayPlaywith("samad");
      Box box = await remotePlaysStorage.getBox();
      expect(box.containsKey("samad"), false);
    });
  });
}
