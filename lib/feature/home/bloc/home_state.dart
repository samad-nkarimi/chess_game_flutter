import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class InitialHomeState extends HomeState {
  final int playCount;

  InitialHomeState(this.playCount);
  @override
  List<Object?> get props => [playCount];
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
  final int playCount;

  PlaysListHomeState(this.playCount);
  @override
  List<Object?> get props => [playCount];
}
