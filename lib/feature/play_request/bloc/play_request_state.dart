import 'package:chess_flutter/models/play_request.dart';
import 'package:equatable/equatable.dart';

abstract class PlayRequestState extends Equatable {}

class InitialPlayRequestState extends PlayRequestState {
  @override
  List<Object?> get props => [];
}

//
class PlayRequestsListState extends PlayRequestState {
  final List<PlayRequest> remotePlayRequest;
  final String id;

  PlayRequestsListState(this.remotePlayRequest, this.id);
  @override
  List<Object?> get props => [remotePlayRequest, id];
}

//
class AcceptRequestSentState extends PlayRequestState {
  final String username;
  final String id;

  AcceptRequestSentState(this.username, this.id);
  @override
  List<Object?> get props => [username, id];
}
