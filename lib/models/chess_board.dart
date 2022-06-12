import 'package:chess_flutter/models/chess_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/chess_player.dart';
import 'package:chess_flutter/models/enums/rule.dart';

class ChessBoard {
  static final ChessBoard _singleton = ChessBoard._internal();

  factory ChessBoard() {
    return _singleton;
  }

  ChessBoard._internal();

  final Map<ChessBox, ChessCharacter> boardMap = {};

  void addToBoardMap(int col, int row, ChessCharacter scc) {
    if (boardMap.containsKey(ChessBox(col, row))) {
      boardMap.remove(ChessBox(col, row));
    }
    boardMap[ChessBox(col, row)] = scc;
  }

  void createMap() {
    //
    //you can save all histoy here
    boardMap.clear();
    for (int col = 1; col <= 8; col++) {
      for (int row = 1; row <= 8; row++) {
        late ChessCharacter c;
        //whites
        c = PlayerWhite().getCharacter(col, row);
        if (c.isNone) {
          //blacks
          c = PlayerBlack().getCharacter(col, row);
        }

        if (!c.isNone) {
          boardMap[ChessBox(col, row)] = c;
        }
      }
    }
  }

  void exChange(int col, int row, int newCol, int newRow) {
    ChessCharacter scc = getcharacter(col, row);
    boardMap.removeWhere(
        (key, value) => key.columnNumber == col && key.rowNumber == row);
    addToBoardMap(newCol, newRow, scc);
  }

  ChessCharacter getcharacter(int col, int row) {
    for (var element in boardMap.keys) {
      if (element.isInCoordinate(col, row)) {
        if (boardMap[element]!.isInGame) {
          return boardMap[element]!;
        }
      }
    }
    return ChessCharacter.none();
  }

  bool isEnemyAt(Player player, int col, int row) {
    ChessCharacter char = getcharacter(col, row);
    if (!char.isNone) {
      if (player != char.player) {
        return true;
      }
    }
    return false;
  }

  bool hasCharacterAt(int col, int row) {
    if (!getcharacter(col, row).isNone) {
      return true;
    }
    return false;
  }

  // Player getPlayer(int col, int row) {
  //   return getcharacter(col, row).player;
  // }
}
