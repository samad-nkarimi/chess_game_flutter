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
  final bool isKingInCheck;
  final ChessBox kingBox;

  CharacterClickedState(this.moveOptions, this.isKingInCheck,
      {this.kingBox = const ChessBox(0, 0)});

  @override
  List<Object?> get props => [moveOptions, isKingInCheck, kingBox];
}

class CharacterMovedState extends ChessState {
  final bool isKingInCheck;
  final ChessBox kingBox;
  CharacterMovedState(this.isKingInCheck,
      {this.kingBox = const ChessBox(0, 0)});

  @override
  List<Object?> get props => [isKingInCheck, kingBox];
}
