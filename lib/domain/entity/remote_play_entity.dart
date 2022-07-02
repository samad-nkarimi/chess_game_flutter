import 'package:chess_flutter/models/enums/remote_play_status.dart';

class RemotePlayEntity {
  final String targetUsername;
  final String targetScore;
  final RemotePlayStatus status;
  final DateTime startDate;
  final DateTime endDate;

  RemotePlayEntity(
    this.targetUsername,
    this.targetScore,
    this.status,
    this.startDate,
    this.endDate,
  );
}
