import 'dart:convert';

import 'package:chess_flutter/core/pre_move_methods.dart';
import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/enums/rule.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:chess_flutter/models/chess_player.dart';

class ChessCharacter {
  int columnNumber = 1; //not index!
  int rowNumber = 1; //not index!
  bool isInGame = true;
  final String photoId;
  final Player player;
  final Rule rule;
  bool isEverMoved = false;
  ChessPlayer chessPlayer = PlayerWhite();

  ChessCharacter(
    this.photoId,
    this.player, {
    this.columnNumber = 1,
    this.rowNumber = 1,
    this.rule = Rule.none,
  }) {
    if (player == Player.black) {
      chessPlayer = PlayerBlack();
    }
  }

  ChessCharacter.none()
      : photoId = "",
        player = Player.white,
        rule = Rule.none;

  String toJson() {
    return jsonEncode({
      "col": columnNumber,
      "row": rowNumber,
      "is_in_game": isInGame,
      "photo_id": photoId,
      "player": player.name,
      "rule": rule.name,
      "is_ever_moved": isEverMoved,
    });
  }

  ChessCharacter.fromJson(Map<dynamic, dynamic> json)
      : columnNumber = json["col"],
        isEverMoved = json["is_ever_moved"],
        rowNumber = json["row"],
        isInGame = json["is_in_game"],
        photoId = json["photo_id"],
        player = json["player"] == "white" ? Player.white : Player.black,
        rule = getRuleFromString(json["rule"].toString()),
        chessPlayer = json["player"] == "white" ? PlayerWhite() : PlayerBlack();

  static Rule getRuleFromString(String ruleName) {
    switch (ruleName) {
      case "pawn":
        return Rule.pawn;
      case "rock":
        return Rule.rock;
      case "bishop":
        return Rule.bishop;
      case "knight":
        return Rule.knight;
      case "king":
        return Rule.king;
      case "queen":
        return Rule.queen;

      default:
        return Rule.none;
    }
  }

  bool get isNone {
    if (rule == Rule.none) return true;
    return false;
  }

  bool get isKing {
    if (rule == Rule.king) return true;
    return false;
  }

  MoveOptions preMove() {
    switch (rule) {
      case Rule.pawn:
        return PreMoveMethods.preMovePawn(player, columnNumber, rowNumber);
      case Rule.rock:
        return PreMoveMethods.preMoveRock(player, columnNumber, rowNumber);
      case Rule.knight:
        return PreMoveMethods.preMoveKnight(player, columnNumber, rowNumber);
      case Rule.bishop:
        return PreMoveMethods.preMoveBishop(player, columnNumber, rowNumber);
      case Rule.queen:
        return PreMoveMethods.preMoveQueen(player, columnNumber, rowNumber);
      case Rule.king:
        return PreMoveMethods.preMoveKing(player, columnNumber, rowNumber);
      default:
        throw UnimplementedError();
    }
  }

  void move(int newCol, int newRow) {
    ChessBoard().exChange(columnNumber, rowNumber, newCol, newRow);
    columnNumber = newCol;
    rowNumber = newRow;
  }

  @override
  String toString() {
    return "(${player.name},${rule.name})";
  }
}



// class ChessCharacterPawn extends ChessCharacter {
//   ChessCharacterPawn(
//     super.photoId,
//     super.player, {
//     super.columnNumber,
//     super.rowNumber,
//   }) : super(rule: Rule.pawn);

//   @override
//   MoveOptions preMove() {
//     // print(rule);
//     return PreMoveMethods.preMovePawn(player, columnNumber, rowNumber);
//   }
// }

// class ChessCharacterRock extends ChessCharacter {
//   ChessCharacterRock(super.photoId, super.player,
//       {super.columnNumber, super.rowNumber})
//       : super(rule: Rule.rock);

//   @override
//   MoveOptions preMove() {
//     // print(rule);
//     return PreMoveMethods.preMoveRock(player, columnNumber, rowNumber);
//   }
// }

// class ChessCharacterBishop extends ChessCharacter {
//   ChessCharacterBishop(super.photoId, super.player,
//       {super.columnNumber, super.rowNumber})
//       : super(rule: Rule.bishop);

//   @override
//   MoveOptions preMove() {
//     // print(rule);
//     return PreMoveMethods.preMoveBishop(player, columnNumber, rowNumber);
//   }
// }

// class ChessCharacterKnight extends ChessCharacter {
//   ChessCharacterKnight(super.photoId, super.player,
//       {super.columnNumber, super.rowNumber})
//       : super(rule: Rule.knight);

//   @override
//   MoveOptions preMove() {
//     // print(rule);
//     return PreMoveMethods.preMoveKnight(player, columnNumber, rowNumber);
//   }
// }

// class ChessCharacterKing extends ChessCharacter {
//   ChessCharacterKing(super.photoId, super.player,
//       {super.columnNumber, super.rowNumber})
//       : super(rule: Rule.king);

//   @override
//   MoveOptions preMove() {
//     // print(rule);
//     return PreMoveMethods.preMoveKing(player, columnNumber, rowNumber);
//   }
// }

// class ChessCharacterQueen extends ChessCharacter {
//   ChessCharacterQueen(super.photoId, super.player,
//       {super.columnNumber, super.rowNumber})
//       : super(rule: Rule.queen);

//   @override
//   MoveOptions preMove() {
//     // print(rule);
//     return PreMoveMethods.preMoveQueen(player, columnNumber, rowNumber);
//   }
// }
