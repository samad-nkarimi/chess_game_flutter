import 'package:chess_flutter/models/remote_move_details.dart';

abstract class RemotePlayMoveRepo {
  void sendMoveToServer(RemoteMoveDetails remoteMoveDetails);
}
