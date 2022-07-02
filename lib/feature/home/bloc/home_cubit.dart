import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/enums/remote_play_status.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final List<RemotePlayEntity> remotePlays = [];
  HomeCubit() : super(InitialHomeState([]));

  void addNewRemotePlay(String targetUsername) {
    remotePlays.add(
      RemotePlayEntity(
          targetUsername,
          '0',
          RemotePlayStatus.wating,
          DateTime.now(),
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1)),
    );
    // emit(NewRemotePlayHomeState(targetUsername));
    emit(PlaysListHomeState(remotePlays));
  }
}
