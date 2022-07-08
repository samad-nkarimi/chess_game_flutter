import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/domain/repo/plays_storage_repo.dart';
import 'package:chess_flutter/models/remote_play_model.dart';
import 'package:chess_flutter/storage/remote_plays_storage.dart';

class PlaysStorageRepoImpl extends PlaysStorageRepo {
  final RemotePlaysStorage remotePlaysStorage;

  PlaysStorageRepoImpl(this.remotePlaysStorage);

  @override
  Future<void> saveNewPlay(RemotePlayEntity entity) async {
    RemotePlayModel remotePlayModel = RemotePlayModel.fromEntity(entity);
    await remotePlaysStorage.savePlayWith(remotePlayModel);
  }

  @override
  Future<void> updatePlay(RemotePlayEntity entity) async {
    RemotePlayModel remotePlayModel = RemotePlayModel.fromEntity(entity);
    await remotePlaysStorage.updatePlay(remotePlayModel);
  }

  @override
  Future<void> deletePlay(String username) async {
    await remotePlaysStorage.deletePlay(username);
  }

  @override
  Future<bool> isPlayExists(String username) async {
    return await remotePlaysStorage.isThereAPlaywith(username);
  }

  @override
  Future<List<RemotePlayEntity>> fetchAllPLays() async {
    List<RemotePlayModel> plays = await remotePlaysStorage.loadAllPlays();
    return plays.map((e) => e.toEntity()).toList();
  }
}
