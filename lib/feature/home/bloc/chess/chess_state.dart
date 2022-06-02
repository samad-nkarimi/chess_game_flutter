import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:equatable/equatable.dart';

abstract class ChessState extends Equatable {}

class ChessInitialState extends ChessState {
  @override
  List<Object?> get props => [];
}

class CharacterClickedState extends ChessState {
  final MoveOptions moveOptions;

  CharacterClickedState(this.moveOptions);

  @override
  List<Object?> get props => [moveOptions];
}

class CharacterMovedState extends ChessState {
  CharacterMovedState();

  @override
  List<Object?> get props => [];
}
