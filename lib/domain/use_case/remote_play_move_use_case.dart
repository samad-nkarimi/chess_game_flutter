import 'package:chess_flutter/domain/repo/remote_play_move_repo.dart';
import 'package:chess_flutter/models/remote_move_details.dart';

class RemotePlayMoveUseCase {
  final RemotePlayMoveRepo remotePlayMoveRepo;

  RemotePlayMoveUseCase(this.remotePlayMoveRepo);
  void sendMoveToServer(RemoteMoveDetails remoteMoveDetails) {
    remotePlayMoveRepo.sendMoveToServer(remoteMoveDetails);
  }
}
