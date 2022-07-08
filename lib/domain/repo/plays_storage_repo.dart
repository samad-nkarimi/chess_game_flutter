import 'package:chess_flutter/domain/entity/remote_play_entity.dart';

abstract class PlaysStorageRepo {
  Future<void> saveNewPlay(RemotePlayEntity remotePlayEntity);
  Future<void> updatePlay(RemotePlayEntity remotePlayEntity);
  Future<void> deletePlay(String username);
  Future<bool> isPlayExists(String username);
  Future<List<RemotePlayEntity>> fetchAllPLays();
}
