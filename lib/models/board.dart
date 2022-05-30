import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';

class ChessBoard {
  static final ChessBoard _singleton = ChessBoard._internal();

  factory ChessBoard() {
    return _singleton;
  }

  ChessBoard._internal();

  final Map<ChessBox, SuperChessCharacter> boardMap = {};

  void addToBoardMap(int col, int row, SuperChessCharacter scc) {
    if (boardMap.containsKey(ChessBox(col, row))) {
      boardMap.remove(ChessBox(col, row));
    }
    boardMap[ChessBox(col, row)] = scc;
    // for (var element in boardMap.keys) {
    //   if (element.isInCoordinate(col, row)) {
    //     boardMap.remove(element);
    //     boardMap[ChessBox(col, row)] = scc;
    //   }
    // }
  }

  SuperChessCharacter getcharacter(int col, int row) {
    for (var element in boardMap.keys) {
      if (element.isInCoordinate(col, row)) {
        return boardMap[element]!;
      }
    }
    return ChessCharacterNone("photoId");
  }

  bool isEnemyAt(Player player, int col, int row) {
    SuperChessCharacter char = getcharacter(col, row);
    if (char is! ChessCharacterNone) {
      if (player != char.player) {
        return true;
      }
    }
    return false;
  }

  bool hasCharacterAt(int col, int row) {
    if (getcharacter(col, row) is! ChessCharacterNone) {
      return true;
    }
    return false;
  }
}
