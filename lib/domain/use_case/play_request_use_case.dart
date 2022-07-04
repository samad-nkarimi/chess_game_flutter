import 'package:chess_flutter/domain/repo/remote_play_repo.dart';

class PlayRequestUseCase {
  final RemoteRequestPLayRepo remotePLayRepo;

  PlayRequestUseCase(this.remotePLayRepo);

  void sendPlayRequestTo(String requestUsername, String targetUsername) {
    remotePLayRepo.sendPlayRequestTo(requestUsername, targetUsername);
  }

  void acceptPlayRequestFrom(String requestUsername, String targetUsername) {
    remotePLayRepo.acceptPlayRequestFrom(requestUsername, targetUsername);
  }

  void rejectPlayRequestFrom(String requestUsername, String targetUsername) {
    remotePLayRepo.rejectPlayRequestFrom(requestUsername, targetUsername);
  }
}
