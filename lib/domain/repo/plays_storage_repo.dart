import 'package:chess_flutter/domain/entity/remote_play_entity.dart';

abstract class PlaysStorageRepo {
  Future<void> saveNewPlay(RemotePlayEntity remotePlayEntity);
  Future<bool> isPlayExists(String username);
}
