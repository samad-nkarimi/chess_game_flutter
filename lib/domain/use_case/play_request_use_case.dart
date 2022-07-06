import 'package:chess_flutter/domain/repo/remote_play_repo.dart';

class PlayRequestUseCase {
  final RemoteRequestPLayRepo remotePLayRepo;

  PlayRequestUseCase(this.remotePLayRepo);

  Future<bool> sendPlayRequestFromTo(
      String requestUsername, String targetUsername) async {
    return await remotePLayRepo.sendPlayRequestTo(
        requestUsername, targetUsername);
  }

  Future<bool> acceptPlayRequestFrom(
      String requestUsername, String targetUsername) async {
    return await remotePLayRepo.acceptPlayRequestFrom(
        requestUsername, targetUsername);
  }

  Future<bool> rejectPlayRequestFrom(
      String requestUsername, String targetUsername) async {
    return await remotePLayRepo.rejectPlayRequestFrom(
        requestUsername, targetUsername);
  }

  Future<bool> cancellPlay(
      String requestUsername, String targetUsername) async {
    return await remotePLayRepo.cancellPlay(requestUsername, targetUsername);
  }
}
