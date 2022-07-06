import 'package:equatable/equatable.dart';

abstract class PlayRequestState extends Equatable {}

class InitialPlayRequestState extends PlayRequestState {
  @override
  List<Object?> get props => [];
}

//
class NewPlayRequest extends PlayRequestState {
  final List<String> remotePlayRequest;
  final String id;

  NewPlayRequest(this.remotePlayRequest, this.id);
  @override
  List<Object?> get props => [remotePlayRequest, id];
}
