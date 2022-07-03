import 'package:chess_flutter/domain/repo/remote_play_repo.dart';
import 'package:chess_flutter/service/request_play_service.dart';

class RemoteRequestPlayRepoImpl extends RemoteRequestPLayRepo {
  final RequestPlayService playService;

  RemoteRequestPlayRepoImpl(this.playService);
  @override
  void sendPlayRequestTo(String requestUsername, String targetUsername) {
    playService.sendPlayRequest(requestUsername, targetUsername);
  }

  @override
  void acceptPlayRequestFrom(String requestUsername, String targetUsername) {
    playService.acceptPlayRequest(requestUsername, targetUsername);
  }

  @override
  void rejectPlayRequestFrom(String requestUsername, String targetUsername) {
    playService.rejectPlayRequest(requestUsername, targetUsername);
  }
}
