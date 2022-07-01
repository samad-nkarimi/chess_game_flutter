import 'package:chess_flutter/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  final List<User> users;

  const UserState([this.users = const []]);
}

class InitialUserState extends UserState {
  const InitialUserState(super.users);
  @override
  List<Object?> get props => [];
}

class SearchingUserState extends UserState {
  const SearchingUserState(super.users);
  @override
  List<Object?> get props => [];
}

class ResultUserState extends UserState {
  const ResultUserState(super.users);
  @override
  List<Object?> get props => [users];
}

class ErrorUserState extends UserState {
  const ErrorUserState(super.users);
  @override
  List<Object?> get props => [users];
}
