import 'package:chess_flutter/domain/repo/remote_play_repo.dart';

class PlayRequestUseCase {
  final RemotePLayRepo remotePLayRepo;

  PlayRequestUseCase(this.remotePLayRepo);

  void execute(String requestUsername, String targetUsername) {
    remotePLayRepo.sendPlayRequestTo(requestUsername, targetUsername);
  }
}
