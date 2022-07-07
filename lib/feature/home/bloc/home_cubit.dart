import 'dart:convert';

import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/domain/use_case/play_request_use_case.dart';
import 'package:chess_flutter/domain/use_case/play_requests_storage_usa_case.dart';
import 'package:chess_flutter/domain/use_case/plays_storage_use_case.dart';
import 'package:chess_flutter/service/sse_service.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:chess_flutter/storage/chess_play_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/enums/remote_play_status.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  List<RemotePlayEntity> remotePlays = [];
  final PlaysStorageUseCase playsStorageUseCase;
  final PlayRequestsStorageUseCase playRequestsStorageUseCase;
  final PlayRequestUseCase playRequestUseCase;
  HomeCubit(this.playsStorageUseCase, this.playRequestsStorageUseCase,
      this.playRequestUseCase)
      : super(InitialHomeState([], []));

  //
  void init() async {
    remotePlays = await playsStorageUseCase.fetchAllPlays();
    print(remotePlays);
    emit(PlaysListHomeState(remotePlays));
    if (!SSEService().homeStreamController.hasListener) {
      SSEService().homeStreamController.stream.listen((data) async {
        try {
          var map = jsonDecode(data) as Map<String, dynamic>;
          if (map.containsKey("type")) {
            if (map["type"] == "play_request") {
              String requestUsername = map['request_username'];

              switch (map["result"]) {
                case "accepted":
                  RemotePlayEntity remotePlayEntity = remotePlays.firstWhere(
                      (play) => play.targetUsername == requestUsername);
                  remotePlayEntity.status = RemotePlayStatus.active;
                  await playsStorageUseCase.updatePlay(remotePlayEntity);
                  remotePlays = await playsStorageUseCase.fetchAllPlays();
                  emit(PlaysListHomeState(remotePlays));

                  break;
                case "rejected":
                  RemotePlayEntity remotePlayEntity = remotePlays.firstWhere(
                      (play) => play.targetUsername == requestUsername);
                  remotePlayEntity.status = RemotePlayStatus.rejected;
                  await playsStorageUseCase.updatePlay(remotePlayEntity);
                  remotePlays = await playsStorageUseCase.fetchAllPlays();
                  emit(PlaysListHomeState(remotePlays));
                  break;
                case "new_request":
                  //TODO
                  emit(NewRemotePlayHomeState(requestUsername));
                  await playRequestsStorageUseCase.saveNewRequest(
                      requestUsername, "0");
                  // emit(PlayRequestsHomeState(
                  //   remotePlayRequests,
                  //   DateTime.now().millisecondsSinceEpoch.toString(),
                  // ));
                  break;
                case "cancelled":
                  RemotePlayEntity remotePlayEntity = remotePlays.singleWhere(
                      (play) => play.targetUsername == requestUsername);
                  remotePlayEntity.status = RemotePlayStatus.cancelled;
                  await playsStorageUseCase.updatePlay(remotePlayEntity);
                  emit(PlaysListHomeState(remotePlays));
                  // emit(PlayRequestsHomeState(
                  //   remotePlayRequests,
                  //   DateTime.now().millisecondsSinceEpoch.toString(),
                  // ));
                  break;
                default:
              }
            }
          }
        } catch (e) {
          print(e);
        }
      });
    }
  }

  // //
  // void sendPlayRequestsHomeState() {
  //   emit(PlayRequestsHomeState(
  //     remotePlayRequests,
  //     DateTime.now().millisecondsSinceEpoch.toString(),
  //   ));
  // }

  // //what we send to target
  // void addNewRemotePlayRequest(String targetUsername) {
  //   remotePlays.add(RemotePlayEntity(
  //       targetUsername, '0', RemotePlayStatus.wating, DateTime.now()));
  //   // emit(NewRemotePlayHomeState(targetUsername));
  //   emit(PlaysListHomeState(
  //       remotePlays, DateTime.now().millisecondsSinceEpoch.toString()));
  // }

  void deleteRemotePlay(String username) async {
    //send delete to server
    bool isSent = await playRequestUseCase.cancellPlay(
        ServiceLocator().username, username);
    if (isSent) {
      await playsStorageUseCase.deletePlay(username);
      remotePlays.removeWhere((element) => element.targetUsername == username);
      //TODO
      await ChessPlayStorage().deleteBoard(username);
      emit(PlaysListHomeState(remotePlays));
    } else {
      //network problem
    }
  }
}
