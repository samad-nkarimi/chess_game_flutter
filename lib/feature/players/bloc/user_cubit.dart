import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/domain/use_case/auth_register_use_case.dart';
import 'package:chess_flutter/domain/use_case/find_username_use_case.dart';
import 'package:chess_flutter/domain/use_case/play_request_use_case.dart';
import 'package:chess_flutter/domain/use_case/plays_storage_use_case.dart';
import 'package:chess_flutter/feature/players/bloc/user_state.dart';
import 'package:chess_flutter/models/enums/remote_play_status.dart';
import 'package:chess_flutter/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/register_credential.dart';

class UserCubit extends Cubit<UserState> {
  final FindUsernameUseCase findUsernameUseCase;
  final PlayRequestUseCase playRequestUseCase;
  final PlaysStorageUseCase playsStorageUseCase;
  UserCubit({
    required this.findUsernameUseCase,
    required this.playRequestUseCase,
    required this.playsStorageUseCase,
  }) : super(const InitialUserState([]));

  //
  void searchForFeed(String feed) async {
    print(feed);
    emit(const SearchingUserState([]));
    await Future.delayed(const Duration(seconds: 2)); //TODO remove
    try {
      List<User> users = await findUsernameUseCase.execute(feed);
      emit(ResultUserState(users));
      print(users);
    } catch (e) {
      emit(const ErrorUserState([]));
    }
  }

  //
  void sendPlayRequestTo(
      String requestUsername, String targetUsername, String score) async {
    bool playAlreadyExist =
        await playsStorageUseCase.isPlayExists(targetUsername);
    if (playAlreadyExist) {
      print("already have a play");
    } else {
      playRequestUseCase.sendPlayRequestFromTo(requestUsername, targetUsername);
      //TODO, if failed, do not save it
      playsStorageUseCase.saveNewPlay(RemotePlayEntity(
        targetUsername,
        score,
        RemotePlayStatus.wating,
        DateTime.now(),
      ));
    }
  }
}
