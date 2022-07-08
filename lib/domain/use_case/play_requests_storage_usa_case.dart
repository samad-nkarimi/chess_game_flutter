import 'package:chess_flutter/domain/repo/play_requests_storage_repo.dart';
import 'package:chess_flutter/models/play_request.dart';

class PlayRequestsStorageUseCase {
  final PlayRequestStorageRepo playRequestStorageRepo;

  PlayRequestsStorageUseCase(this.playRequestStorageRepo);

  Future<bool> saveNewRequest(String username, String score) async {
    return await playRequestStorageRepo.saveNewRequest(username, score);
  }

  Future<bool> deleteRequest(String username) async {
    return await playRequestStorageRepo.deleteRequest(username);
  }

  Future<List<PlayRequest>> fetchAllRequests() async {
    return await playRequestStorageRepo.fetchAllRequests();
  }
}
