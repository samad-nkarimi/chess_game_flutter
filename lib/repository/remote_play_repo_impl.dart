import 'package:chess_flutter/domain/repo/remote_play_repo.dart';
import 'package:chess_flutter/service/request_play_service.dart';

class RemoteRequestPlayRepoImpl extends RemoteRequestPLayRepo {
  final RequestPlayService playService;

  RemoteRequestPlayRepoImpl(this.playService);
  @override
  Future<bool> sendPlayRequestTo(
      String requestUsername, String targetUsername) async {
    return await playService.sendPlayRequest(requestUsername, targetUsername);
  }

  @override
  Future<bool> acceptPlayRequestFrom(
      String requestUsername, String targetUsername) async {
    return await playService.acceptPlayRequest(requestUsername, targetUsername);
  }

  @override
  Future<bool> rejectPlayRequestFrom(
      String requestUsername, String targetUsername) async {
    return await playService.rejectPlayRequest(requestUsername, targetUsername);
  }

  @override
  Future<bool> cancellPlay(
      String requestUsername, String targetUsername) async {
    return await playService.cancellPlay(requestUsername, targetUsername);
  }
}
