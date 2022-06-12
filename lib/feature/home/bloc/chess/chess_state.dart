import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:chess_flutter/models/chess_player.dart';
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
  final ChessBox moveFrom;
  final ChessBox moveTo;
  CharacterMovedState(this.isKingInCheck, this.moveFrom, this.moveTo,
      {this.kingBox = const ChessBox(0, 0)});

  @override
  List<Object?> get props => [isKingInCheck, kingBox];
}

//
class CharacterShottedState extends ChessState {
  final List<SuperChessCharacter> _outChars;
  final List<SuperChessCharacter> outCharsWhite;
  final List<SuperChessCharacter> outCharsBlack;
  CharacterShottedState(this._outChars)
      : outCharsWhite =
            _outChars.where((e) => e.player.player == Player.white).toList(),
        outCharsBlack =
            _outChars.where((e) => e.player.player == Player.black).toList();

  @override
  List<Object?> get props => [_outChars];
}

//
class PlayerWonState extends ChessState {
  final SuperPlayer winner;
  PlayerWonState(this.winner);

  @override
  List<Object?> get props => [winner];
}
