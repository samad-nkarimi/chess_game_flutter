import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/domain/repo/plays_storage_repo.dart';

class PlaysStorageUseCase {
  final PlaysStorageRepo playsStorageRepo;

  PlaysStorageUseCase(this.playsStorageRepo);

  Future<bool> isPlayExists(String username) async {
    return await playsStorageRepo.isPlayExists(username);
  }

  Future<void> saveNewPlay(RemotePlayEntity remotePlayEntity) async {
    await playsStorageRepo.saveNewPlay(remotePlayEntity);
  }
}
