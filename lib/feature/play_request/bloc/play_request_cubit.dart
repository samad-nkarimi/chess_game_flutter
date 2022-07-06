import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/domain/use_case/play_request_use_case.dart';
import 'package:chess_flutter/domain/use_case/play_requests_storage_usa_case.dart';
import 'package:chess_flutter/domain/use_case/plays_storage_use_case.dart';
import 'package:chess_flutter/feature/play_request/bloc/play_request_state.dart';
import 'package:chess_flutter/models/enums/remote_play_status.dart';
import 'package:chess_flutter/models/play_request.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayRequestCubit extends Cubit<PlayRequestState> {
  final PlayRequestUseCase playRequestUseCase;
  final PlaysStorageUseCase playsStorageUseCase;
  final PlayRequestsStorageUseCase playRequestsStorageUseCase;
  List<PlayRequest> playrequests = [];
  PlayRequestCubit(this.playRequestUseCase, this.playsStorageUseCase,
      this.playRequestsStorageUseCase)
      : super(InitialPlayRequestState());

  void init() async {
    playrequests = await playRequestsStorageUseCase.fetchAllRequests();
    emit(PlayRequestsListState(
        playrequests, DateTime.now().millisecondsSinceEpoch.toString()));
  }

  void acceptRemotePlayRequest(String commingUsername) async {
    //send accept message to server
    bool isSent = await playRequestUseCase.acceptPlayRequestFrom(
        ServiceLocator().username, commingUsername);
    if (isSent) {
      //save play to storage, if sendding was successful
      await playsStorageUseCase.saveNewPlay(RemotePlayEntity(
          commingUsername, '0', RemotePlayStatus.active, DateTime.now()));
      //remove request from list
      await playRequestsStorageUseCase.deleteRequest(commingUsername);
      //notify ui
      playrequests = await playRequestsStorageUseCase.fetchAllRequests();
      emit(AcceptRequestSentState(
          commingUsername, DateTime.now().millisecondsSinceEpoch.toString()));
    }
  }

  //what we get from others
  void rejectRemotePlayRequest(String commingUsername) async {
    //send accept message to server
    bool isSent = await playRequestUseCase.rejectPlayRequestFrom(
        ServiceLocator().username, commingUsername);

    //remove request from list
    if (isSent) {
      playRequestsStorageUseCase.deleteRequest(commingUsername);
    }
  }
}
