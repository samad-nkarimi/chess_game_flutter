import 'package:equatable/equatable.dart';

import '../../../models/enums/auth_type.dart';

abstract class AuthState extends Equatable {}

///
class InitialAuthState extends AuthState {
  final AuthType authType;
  InitialAuthState(this.authType);
  @override
  List<Object?> get props => [authType];
}

///
class AuthTypeChangedState extends AuthState {
  final AuthType authType;
  AuthTypeChangedState(this.authType);
  @override
  List<Object?> get props => [authType];
}

///
class WatingForAuthState extends AuthState {
  final AuthType authType;
  WatingForAuthState(this.authType);
  @override
  List<Object?> get props => [authType];
}

///
class AuthErrorState extends AuthState {
  final String message;
  final String id;
  AuthErrorState(this.message, this.id);
  @override
  List<Object?> get props => [message, id];
}

///
class AuthSucceedState extends AuthState {
  @override
  List<Object?> get props => [];
}

///
class FormValidationAuthState extends AuthState {
  final String id;

  FormValidationAuthState(this.id);
  @override
  List<Object?> get props => [id];
}
