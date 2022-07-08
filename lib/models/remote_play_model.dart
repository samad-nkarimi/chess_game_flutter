import 'dart:convert';

import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/models/enums/remote_play_status.dart';
import 'package:equatable/equatable.dart';

class RemotePlayModel extends Equatable {
  final String targetUsername;
  final String targetScore;
  final String status;
  final String startDate;
  final bool amIHost;

  const RemotePlayModel({
    required this.targetUsername,
    required this.targetScore,
    required this.status,
    required this.startDate,
    required this.amIHost,
  });

  RemotePlayEntity toEntity() {
    return RemotePlayEntity(targetUsername, targetScore, getPlayStatus(status),
        DateTime.parse(startDate), amIHost);
  }

  RemotePlayModel.fromEntity(RemotePlayEntity entity)
      : targetUsername = entity.targetUsername,
        targetScore = entity.targetScore,
        status = getStringifyPlayStatus(entity.status),
        startDate = entity.startDate.toString(),
        amIHost = entity.amIHost;

  RemotePlayModel.fromJson(Map<String, dynamic> json)
      : targetUsername = json["targetUsername"],
        targetScore = json["targetScore"],
        status = json["status"],
        startDate = json["startDate"],
        amIHost = json['host'];

  String toJson() {
    return jsonEncode({
      "targetUsername": targetUsername,
      "targetScore": targetScore,
      "status": status,
      "startDate": startDate,
      'host': amIHost,
    });
  }

  static String getStringifyPlayStatus(RemotePlayStatus status) {
    switch (status) {
      case RemotePlayStatus.active:
        return RemotePlayStatus.active.name;
      case RemotePlayStatus.cancelled:
        return RemotePlayStatus.cancelled.name;
      case RemotePlayStatus.wating:
        return RemotePlayStatus.wating.name;
      case RemotePlayStatus.finished:
        return RemotePlayStatus.finished.name;
      case RemotePlayStatus.rejected:
        return RemotePlayStatus.rejected.name;

      default:
        return RemotePlayStatus.wating.name;
    }
  }

  static RemotePlayStatus getPlayStatus(String status) {
    switch (status) {
      case "active":
        return RemotePlayStatus.active;
      case "cancelled":
        return RemotePlayStatus.cancelled;
      case "wating":
        return RemotePlayStatus.wating;
      case "finished":
        return RemotePlayStatus.finished;
      case "rejected":
        return RemotePlayStatus.rejected;

      default:
        return RemotePlayStatus.wating;
    }
  }

  @override
  List<Object?> get props => [targetUsername, targetScore, status, startDate];
}
