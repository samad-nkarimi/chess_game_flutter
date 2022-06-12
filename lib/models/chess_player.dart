import 'package:chess_flutter/constants/constant_images.dart';
import 'package:chess_flutter/models/chess_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/enums/rule.dart';
import 'package:chess_flutter/models/move_options.dart';

abstract class ChessPlayer {
  Map<String, ChessCharacter> characters = {};
  final Player player;
  int _firstColumn = 0;
  int _secondColumn = 0;

  ChessPlayer(this.player) {
    if (player == Player.white) {
      _firstColumn = 8;
      _secondColumn = 7;
    } else {
      _firstColumn = 1;
      _secondColumn = 2;
    }
  }
  void initialize() {
    characters = {
      "pawn1": ChessCharacter(ConstantImages.svgWhitePawn, player,
          rule: Rule.pawn, columnNumber: _secondColumn, rowNumber: 1),
      "pawn2": ChessCharacter(ConstantImages.svgWhitePawn, player,
          rule: Rule.pawn, columnNumber: _secondColumn, rowNumber: 2),
      "pawn3": ChessCharacter(ConstantImages.svgWhitePawn, player,
          rule: Rule.pawn, columnNumber: _secondColumn, rowNumber: 3),
      "pawn4": ChessCharacter(ConstantImages.svgWhitePawn, player,
          rule: Rule.pawn, columnNumber: _secondColumn, rowNumber: 4),
      "pawn5": ChessCharacter(ConstantImages.svgWhitePawn, player,
          rule: Rule.pawn, columnNumber: _secondColumn, rowNumber: 5),
      "pawn6": ChessCharacter(ConstantImages.svgWhitePawn, player,
          rule: Rule.pawn, columnNumber: _secondColumn, rowNumber: 6),
      "pawn7": ChessCharacter(ConstantImages.svgWhitePawn, player,
          rule: Rule.pawn, columnNumber: _secondColumn, rowNumber: 7),
      "pawn8": ChessCharacter(ConstantImages.svgWhitePawn, player,
          rule: Rule.pawn, columnNumber: _secondColumn, rowNumber: 8),
      "rock1": ChessCharacter(ConstantImages.svgWhiteRock, player,
          rule: Rule.rock, columnNumber: _firstColumn, rowNumber: 1),
      "knight1": ChessCharacter(ConstantImages.svgWhiteKnight, player,
          rule: Rule.knight, columnNumber: _firstColumn, rowNumber: 2),
      "bishop1": ChessCharacter(ConstantImages.svgWhiteBishop, player,
          rule: Rule.bishop, columnNumber: _firstColumn, rowNumber: 3),
      "queen": ChessCharacter(ConstantImages.svgWhiteQueen, player,
          rule: Rule.queen, columnNumber: _firstColumn, rowNumber: 4),
      "king": ChessCharacter(ConstantImages.svgWhiteKing, player,
          rule: Rule.king, columnNumber: _firstColumn, rowNumber: 5),
      "bishop2": ChessCharacter(ConstantImages.svgWhiteBishop, player,
          rule: Rule.bishop, columnNumber: _firstColumn, rowNumber: 6),
      "knight2": ChessCharacter(ConstantImages.svgWhiteKnight, player,
          rule: Rule.knight, columnNumber: _firstColumn, rowNumber: 7),
      "rock2": ChessCharacter(ConstantImages.svgWhiteRock, player,
          rule: Rule.rock, columnNumber: _firstColumn, rowNumber: 8),
    };
  }

  int getEntityIndex(int col, int row) {
    int index = 0;
    for (ChessCharacter ch in characters.values) {
      if (ch.columnNumber == col && ch.rowNumber == row) {
        return index;
      }
      index++;
    }
    return -1;
  }

  ChessCharacter getCharacter(int col, int row) {
    for (ChessCharacter ch in characters.values) {
      if (ch.columnNumber == col && ch.rowNumber == row) {
        if (ch.isInGame) {
          return ch;
        }
      }
    }
    return ChessCharacter("photo", Player.white);
  }

  List<ChessBox> getOnShottingMoves() {
    return characters.values
        .where((element) => element.isInGame == true)
        .fold<List<ChessBox>>(<ChessBox>[],
            (List<ChessBox> p, ChessCharacter e) {
      return [...e.preMove().onShotingBoxes, ...p];
    });
  }

  bool isCheckMate(int col, int row) {
    MoveOptions moveOptions = MoveOptions.emptyMoveOptions();
    MoveOptions mo;
    for (var char in characters.values) {
      if (char.isInGame) {
        mo = char.preMove().verification(getPlayer());
        moveOptions.onGoingBoxes.addAll(mo.onGoingBoxes);
        moveOptions.onShotingBoxes.addAll(mo.onShotingBoxes);
      }
    }

    // for (var char in characters.values) {
    //   if (char.isInGame) {
    //     moveOptions.onShotingBoxes
    //         .addAll(char.preMove().verification(getPlayer()).onShotingBoxes);
    //   }
    // }

    print("going: ${moveOptions.onGoingBoxes}");
    print("shotting: ${moveOptions.onShotingBoxes}");
    // MoveOptions mo = MoveOptions(
    //     ChessBox(col, row),
    //     characters.values
    //         .where((element) => element.isInGame == true)
    //         .fold<List<ChessBox>>(<ChessBox>[],
    //             (List<ChessBox> p, SuperChessCharacter e) {
    //       return [...e.preMove().verification(getPlayer()).onGoingBoxes, ...p];
    //     }),
    //     characters.values
    //         .where((element) => element.isInGame == true)
    //         .fold<List<ChessBox>>(<ChessBox>[],
    //             (List<ChessBox> p, SuperChessCharacter e) {
    //       return [
    //         ...e.preMove().verification(getPlayer()).onShotingBoxes,
    //         ...p
    //       ];
    //     }));
    // print("mo: ${mo.onShotingBoxes}");
    return moveOptions.isEmpty();
  }

  ChessPlayer getEnemyPlayer() {
    return player == Player.white ? PlayerBlack() : PlayerWhite();
  }

  ChessPlayer getPlayer() {
    return player == Player.white ? PlayerWhite() : PlayerBlack();
  }

  bool isMyKingInCheck() {
    List<ChessBox> shotting = getEnemyPlayer().getOnShottingMoves();

    for (var chessBox in shotting) {
      if (chessBox.isInCoordinate(
          characters["king"]!.columnNumber, characters["king"]!.rowNumber)) {
        return true;
      }
    }

    return false;
  }
}

//implementation for player white
class PlayerWhite extends ChessPlayer {
  static final PlayerWhite _singleton = PlayerWhite._internal();

  factory PlayerWhite() {
    return _singleton;
  }

  PlayerWhite._internal() : super(Player.white);
}

class PlayerBlack extends ChessPlayer {
  static final PlayerBlack _singleton = PlayerBlack._internal();

  factory PlayerBlack() {
    return _singleton;
  }

  PlayerBlack._internal() : super(Player.black);
}
