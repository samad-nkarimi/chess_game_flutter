import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/player.dart';

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
      print('object');
    }
    boardMap[ChessBox(col, row)] = scc;
  }

  void createMap(PlayerWhite pw, PlayerBlack pb) {
    //you can save all histoy here
    boardMap.clear();
    for (int col = 1; col <= 8; col++) {
      for (int row = 1; row <= 8; row++) {
        late SuperChessCharacter c;
        //whites
        c = pw.getCharacter(col, row);
        if (c is ChessCharacterNone) {
          //blacks
          c = pb.getCharacter(col, row);
        }

        if (c is! ChessCharacterNone) {
          boardMap[ChessBox(col, row)] = c;
        }
      }
    }
  }

  SuperChessCharacter getcharacter(int col, int row) {
    for (var element in boardMap.keys) {
      if (element.isInCoordinate(col, row)) {
        if (boardMap[element]!.isInGame) {
          return boardMap[element]!;
        }
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
