import 'package:chess_flutter/domain/repo/play_requests_storage_repo.dart';
import 'package:chess_flutter/storage/play_requests_storage.dart';

class PlayRequestStorageRepoImpl extends PlayRequestStorageRepo {
  final PlayRequestsStorage playRequestsStorage;

  PlayRequestStorageRepoImpl(this.playRequestsStorage);
  @override
  Future<bool> deleteRequest(String username) async {
    return await playRequestsStorage.deleteRequest(username);
  }

  @override
  Future<void> fetchAllRequests() async {
    playRequestsStorage.fetchAllRequests();
  }

  @override
  Future<bool> saveNewRequest(String username, String score) async {
    return await playRequestsStorage.saveNewRequest(username, score);
  }
}
