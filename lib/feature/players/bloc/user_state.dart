import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {}

class InitialUserState extends UserState {
  @override
  List<Object?> get props => [];
}
