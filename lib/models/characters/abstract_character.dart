import 'package:chess_flutter/core/pre_move_methods.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/enums/rule.dart';
import 'package:chess_flutter/models/move_options.dart';

abstract class SuperChessCharacter {
  int columnNumber = 1; //not index!
  int rowNumber = 1; //not index!
  bool isInGame = true;
  final String photoId;
  final Player player;
  final Rule rule;

  SuperChessCharacter(
    this.photoId, {
    this.player = Player.white,
    this.columnNumber = 1,
    this.rowNumber = 1,
    this.rule = Rule.none,
  });

  MoveOptions preMove();
  void move(int newCol, int newRow) {
    columnNumber = newCol;
    rowNumber = newRow;
  }

  @override
  String toString() {
    return "(${player.name},${rule.name})";
  }
}

class ChessCharacterNone extends SuperChessCharacter {
  ChessCharacterNone(
    super.photoId, {
    super.player,
    super.columnNumber,
    super.rowNumber,
  }) : super(rule: Rule.none);

  @override
  MoveOptions preMove() {
    // TODO: implement preMove
    print(rule);
    throw UnimplementedError();
  }
}

class ChessCharacterPawn extends SuperChessCharacter {
  ChessCharacterPawn(
    super.photoId, {
    super.player,
    super.columnNumber,
    super.rowNumber,
  }) : super(rule: Rule.pawn);

  @override
  MoveOptions preMove() {
    print(rule);
    return PreMoveMethods.preMovePawn(player, columnNumber, rowNumber);
  }
}

class ChessCharacterRock extends SuperChessCharacter {
  ChessCharacterRock(super.photoId,
      {super.player, super.columnNumber, super.rowNumber})
      : super(rule: Rule.rock);

  @override
  MoveOptions preMove() {
    // TODO: implement preMove
    print(rule);
    throw UnimplementedError();
  }
}

class ChessCharacterBishop extends SuperChessCharacter {
  ChessCharacterBishop(super.photoId,
      {super.player, super.columnNumber, super.rowNumber})
      : super(rule: Rule.bishop);

  @override
  MoveOptions preMove() {
    // TODO: implement preMove
    print(rule);
    throw UnimplementedError();
  }
}

class ChessCharacterKnight extends SuperChessCharacter {
  ChessCharacterKnight(super.photoId,
      {super.player, super.columnNumber, super.rowNumber})
      : super(rule: Rule.knight);

  @override
  MoveOptions preMove() {
    // TODO: implement preMove
    print(rule);
    throw UnimplementedError();
  }
}

class ChessCharacterKing extends SuperChessCharacter {
  ChessCharacterKing(super.photoId,
      {super.player, super.columnNumber, super.rowNumber})
      : super(rule: Rule.king);

  @override
  MoveOptions preMove() {
    // TODO: implement preMove
    print(rule);
    throw UnimplementedError();
  }
}

class ChessCharacterQueen extends SuperChessCharacter {
  ChessCharacterQueen(super.photoId,
      {super.player, super.columnNumber, super.rowNumber})
      : super(rule: Rule.queen);

  @override
  MoveOptions preMove() {
    // TODO: implement preMove
    print(rule);
    throw UnimplementedError();
  }
}
