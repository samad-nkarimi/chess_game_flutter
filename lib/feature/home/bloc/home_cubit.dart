import 'dart:convert';

import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/domain/use_case/play_request_use_case.dart';
import 'package:chess_flutter/service/sse_service.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/enums/remote_play_status.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final List<RemotePlayEntity> remotePlays = [];
  final List<String> remotePlayRequests = [];
  final PlayRequestUseCase playRequestUseCase;
  HomeCubit(this.playRequestUseCase) : super(InitialHomeState([], []));

  //
  void init() {
    //TODO
    // if (!SSEService().streamController.hasListener) {
    SSEService().streamController.stream.listen((data) {
      print(data);
      try {
        var map = jsonDecode(data) as Map<String, dynamic>;
        if (map.containsKey("type")) {
          print("requestUsername");
          if (map["type"] == "play_request") {
            String requestUsername = map['request_username'];
            print(requestUsername);
            switch (map["result"]) {
              case "accepted":
                RemotePlayEntity remotePlayEntity = remotePlays.firstWhere(
                    (play) => play.targetUsername == requestUsername);
                remotePlayEntity.status = RemotePlayStatus.active;
                emit(PlaysListHomeState(remotePlays,
                    DateTime.now().millisecondsSinceEpoch.toString()));
                print(remotePlayEntity);
                break;
              case "rejected":
                break;
              case "new_request":
                remotePlayRequests.add(requestUsername);
                emit(PlayRequestsHomeState(
                  remotePlayRequests,
                  DateTime.now().millisecondsSinceEpoch.toString(),
                ));
                break;
              default:
            }
          }
        }
      } catch (e) {
        print(e);
      }
    });
    // }
  }

  //
  void sendPlayRequestsHomeState() {
    emit(PlayRequestsHomeState(
      remotePlayRequests,
      DateTime.now().millisecondsSinceEpoch.toString(),
    ));
  }

  //what we send to target
  void addNewRemotePlayRequest(String targetUsername) {
    remotePlays.add(
      RemotePlayEntity(
        targetUsername,
        '0',
        RemotePlayStatus.wating,
        DateTime.now(),
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
      ),
    );
    // emit(NewRemotePlayHomeState(targetUsername));
    emit(PlaysListHomeState(
        remotePlays, DateTime.now().millisecondsSinceEpoch.toString()));
  }

  //what we get from others
  void acceptRemotePlay(String commingUsername) {
    remotePlays.add(
      RemotePlayEntity(
        commingUsername,
        '0',
        RemotePlayStatus.active,
        DateTime.now(),
        DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
      ),
    );
    emit(PlaysListHomeState(
        remotePlays, DateTime.now().millisecondsSinceEpoch.toString()));
    playRequestUseCase.acceptPlayRequestFrom(
        ServiceLocator().username, commingUsername);
  }

  //what we get from others
  void rejectRemotePlay(String commingUsername) {
    //
  }
}
