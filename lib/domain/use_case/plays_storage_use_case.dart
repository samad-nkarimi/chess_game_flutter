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

  Future<void> updatePlay(RemotePlayEntity remotePlayEntity) async {
    await playsStorageRepo.updatePlay(remotePlayEntity);
  }

  Future<void> deletePlay(String username) async {
    await playsStorageRepo.deletePlay(username);
  }

  Future<List<RemotePlayEntity>> fetchAllPlays() async {
    return await playsStorageRepo.fetchAllPLays();
  }
}
