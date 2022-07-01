import 'package:chess_flutter/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  final List<User> users = [];
}

class InitialUserState extends UserState {
  @override
  List<Object?> get props => [];
}

class SearchingUserState extends UserState {
  @override
  List<Object?> get props => [];
}

class ResultUserState extends UserState {
  ResultUserState(users);
  @override
  List<Object?> get props => [users];
}

class ErrorUserState extends UserState {
  @override
  List<Object?> get props => [users];
}
