import 'dart:convert';

import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/models/enums/remote_play_status.dart';

class RemotePlayModel {
  final String targetUsername;
  final String targetScore;
  final String status;
  final String startDate;

  RemotePlayModel({
    required this.targetUsername,
    required this.targetScore,
    required this.status,
    required this.startDate,
  });

  RemotePlayEntity toEntity() {
    return RemotePlayEntity(targetUsername, targetScore, getPlayStatus(status),
        DateTime.parse(startDate));
  }

  RemotePlayModel.fromEntity(RemotePlayEntity entity)
      : targetUsername = entity.targetUsername,
        targetScore = entity.targetScore,
        status = getStringifyPlayStatus(entity.status),
        startDate = entity.startDate.toString();

  RemotePlayModel.fromJson(Map<String, dynamic> json)
      : targetUsername = json["targetUsername"],
        targetScore = json["targetScore"],
        status = getStringifyPlayStatus(json["status"]),
        startDate = json["startDate"];

  String toJson() {
    return jsonEncode({
      "targetUsername": targetUsername,
      "targetScore": targetScore,
      "status": status,
      "startDate": startDate,
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
}
