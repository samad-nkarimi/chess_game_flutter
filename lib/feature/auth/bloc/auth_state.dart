import 'package:chess_flutter/models/enums/auth_filed_type.dart';
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
  final bool isValid;
  final String id;

  FormValidationAuthState(this.isValid, this.id);
  @override
  List<Object?> get props => [isValid, id];
}

///
class FiledValidationAuthState extends AuthState {
  final AuthFiledType filedType;
  final bool isValid;
  final String id;

  FiledValidationAuthState(this.filedType, this.isValid, this.id);
  @override
  List<Object?> get props => [filedType, isValid, id];
}
