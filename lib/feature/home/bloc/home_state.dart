import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class InitialHomeState extends HomeState {
  final List<RemotePlayEntity> remotePlays;
  final List<String> playRequests;

  InitialHomeState(this.remotePlays, this.playRequests);
  @override
  List<Object?> get props => [remotePlays, playRequests];
}

//
class NewRemotePlayHomeState extends HomeState {
  final String targetUsername;

  NewRemotePlayHomeState(this.targetUsername);
  @override
  List<Object?> get props => [targetUsername];
}

//
class PlaysListHomeState extends HomeState {
  final List<RemotePlayEntity> remotePlays;
  final String id;

  PlaysListHomeState(this.remotePlays, this.id);
  @override
  List<Object?> get props => [remotePlays, id];
}

//
class PlayRequestsHomeState extends HomeState {
  final List<String> remotePlayRequest;
  final String id;

  PlayRequestsHomeState(this.remotePlayRequest, this.id);
  @override
  List<Object?> get props => [
        remotePlayRequest,
        id,
      ];
}
