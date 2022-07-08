import 'package:chess_flutter/domain/repo/remote_play_move_repo.dart';
import 'package:chess_flutter/models/remote_move_details.dart';
import 'package:chess_flutter/service/remote_move_service.dart';

class RemotePlayMoveRepoImpl extends RemotePlayMoveRepo {
  final RemoteMoveService _remoteMoveService;

  RemotePlayMoveRepoImpl(this._remoteMoveService);
  @override
  void sendMoveToServer(RemoteMoveDetails remoteMoveDetails) {
    _remoteMoveService.sendMoveToServer(remoteMoveDetails);
  }
}
