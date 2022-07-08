import 'package:chess_flutter/models/enums/remote_play_status.dart';
import 'package:equatable/equatable.dart';

class RemotePlayEntity extends Equatable {
  final String targetUsername;
  final String targetScore;
  RemotePlayStatus status;
  final DateTime startDate;
  final bool amIHost;

  RemotePlayEntity(
    this.targetUsername,
    this.targetScore,
    this.status,
    this.startDate,
    this.amIHost,
  );

  @override
  List<Object?> get props =>
      [targetUsername, targetScore, status, startDate, amIHost];
}
