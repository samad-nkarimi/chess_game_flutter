import 'package:chess_flutter/constants/constant_images.dart';
import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:chess_flutter/models/player.dart';

class PreMoveMethods {
  static MoveOptions preMovePawn(SuperPlayer superPlayer, int col, int row) {
    ChessBox clickedBox = ChessBox(col, row);
    List<ChessBox> onGoingBoxes = [];
    List<ChessBox> onShotingBoxes = [];

    //for white
    int initialPawnCol = 7;
    int nextCol = col - 1;
    int next2Col = col - 2;
    int finalCol = 1;
    bool isThereNextCol = nextCol > 0;
    //for black
    if (superPlayer.player == Player.black) {
      initialPawnCol = 2;
      nextCol = col + 1;
      next2Col = col + 2;
      finalCol = 8;
      isThereNextCol = nextCol < 9;
    }

    bool isInInitialPlace = true;
    if (col != initialPawnCol) {
      isInInitialPlace = false;
    }
    if (row - 1 > 0 && isThereNextCol) {
      if (ChessBoard().isEnemyAt(superPlayer, nextCol, row - 1)) {
        // print("and to shoting");
        onShotingBoxes.add(ChessBox(nextCol, row - 1));
      }
    }
    if (row + 1 < 9 && isThereNextCol) {
      if (ChessBoard().isEnemyAt(superPlayer, nextCol, row + 1)) {
        // print("and to shoting");
        onShotingBoxes.add(ChessBox(nextCol, row + 1));
      }
    }

    if (isThereNextCol) {
      if (!ChessBoard().hasCharacterAt(nextCol, row)) {
        // print("add to ongoing");
        onGoingBoxes.add(ChessBox(nextCol, row));
        if (isInInitialPlace && !ChessBoard().hasCharacterAt(next2Col, row)) {
          // print("add to ongoing");
          onGoingBoxes.add(ChessBox(next2Col, row));
        }
      }
    }
    if (col == finalCol) {
      print("promoted to queen");
      /**
       * promote to queen
       */

      int index = superPlayer.getEntityIndex(col, row);
      String key = superPlayer.characters.keys.toList()[index];
      superPlayer.characters[key] = ChessCharacterQueen(
          ConstantImages.svgWhiteQueen, superPlayer,
          columnNumber: col, rowNumber: row);

      return preMoveQueen(superPlayer, col, row);
    }

    return MoveOptions(clickedBox, onGoingBoxes, onShotingBoxes);
  }

  //
  //
  //
  //
  //
  static MoveOptions preMoveBishop(SuperPlayer superPlayer, int col, int row) {
    return getBishopMoveOptions(8, col, row, superPlayer);
  }

  //
  //
  //
  //
  //
  static MoveOptions preMoveKnight(SuperPlayer superPlayer, int col, int row) {
    ChessBox clickedBox = ChessBox(col, row);
    List<ChessBox> onGoingBoxes = [];
    List<ChessBox> onShotingBoxes = [];

    //col+2   row+1
    if (col + 2 < 9 && row + 1 < 9) {
      if (!ChessBoard().hasCharacterAt(col + 2, row + 1)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col + 2, row + 1));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col + 2, row + 1)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col + 2, row + 1));
        }
      }
    }

    //col+1   row+2
    if (col + 1 < 9 && row + 2 < 9) {
      if (!ChessBoard().hasCharacterAt(col + 1, row + 2)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col + 1, row + 2));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col + 1, row + 2)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col + 1, row + 2));
        }
      }
    }

    //
    //col+2   row-1
    if (col + 2 < 9 && row - 1 > 0) {
      if (!ChessBoard().hasCharacterAt(col + 2, row - 1)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col + 2, row - 1));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col + 2, row - 1)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col + 2, row - 1));
        }
      }
    }

    //col+1   row-2
    if (col + 1 < 9 && row - 2 > 0) {
      if (!ChessBoard().hasCharacterAt(col + 1, row - 2)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col + 1, row - 2));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col + 1, row - 2)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col + 1, row - 2));
        }
      }
    }

    //
    //col-2   row+1
    if (col - 2 > 0 && row + 1 < 9) {
      if (!ChessBoard().hasCharacterAt(col - 2, row + 1)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col - 2, row + 1));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col - 2, row + 1)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col - 2, row + 1));
        }
      }
    }

    //col-1   row+2
    if (col - 1 > 0 && row + 2 < 9) {
      if (!ChessBoard().hasCharacterAt(col - 1, row + 2)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col - 1, row + 2));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col - 1, row + 2)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col - 1, row + 2));
        }
      }
    }

    //
    //col-2   row-1
    if (col - 2 > 0 && row - 1 > 0) {
      if (!ChessBoard().hasCharacterAt(col - 2, row - 1)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col - 2, row - 1));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col - 2, row - 1)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col - 2, row - 1));
        }
      }
    }

    //col-1   row-2
    if (col - 1 > 0 && row - 2 > 0) {
      if (!ChessBoard().hasCharacterAt(col - 1, row - 2)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col - 1, row - 2));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col - 1, row - 2)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col - 1, row - 2));
        }
      }
    }

    return MoveOptions(clickedBox, onGoingBoxes, onShotingBoxes);
  }

  //
  //
  //
  //
  //
  static MoveOptions preMoveRock(SuperPlayer superPlayer, int col, int row) {
    return getRockMoveOptions(8, col, row, superPlayer);
  }

  //
  //
  //
  //
  //
  static MoveOptions preMoveQueen(SuperPlayer superPlayer, int col, int row) {
    ChessBox clickedBox = ChessBox(col, row);

    MoveOptions moBishop = getBishopMoveOptions(8, col, row, superPlayer);
    MoveOptions moRock = getRockMoveOptions(8, col, row, superPlayer);

    return MoveOptions(
      clickedBox,
      [...moBishop.onGoingBoxes, ...moRock.onGoingBoxes],
      [...moBishop.onShotingBoxes, ...moRock.onShotingBoxes],
    );
  }

  //
  //
  //
  //
  //
  static MoveOptions preMoveKing(SuperPlayer superPlayer, int col, int row) {
    ChessBox clickedBox = ChessBox(col, row);

    MoveOptions moBishop = getBishopMoveOptions(1, col, row, superPlayer);
    MoveOptions moRock = getRockMoveOptions(1, col, row, superPlayer);
    MoveOptions kingMoveOptions = MoveOptions(
      clickedBox,
      [...moBishop.onGoingBoxes, ...moRock.onGoingBoxes],
      [...moBishop.onShotingBoxes, ...moRock.onShotingBoxes],
    );

    //check for king-rock move -> right rock -> king row < rock row
    //right rock row = 8
    //the col is constant
    //check if there is a character between king and rock -> form (row +1) to  (8-1)
    for (int i = row + 1; i < 8; i++) {
      ChessBoard().hasCharacterAt(col, i);
    }
    //check for king-rock move -> left rock -> king row > rock row

    return kingMoveOptions;
  }

  static MoveOptions getBishopMoveOptions(
      int count, int col, int row, SuperPlayer superPlayer) {
    ChessBox clickedBox = ChessBox(col, row);
    List<ChessBox> onGoingBoxes = [];
    List<ChessBox> onShotingBoxes = [];

    //col+    row+
    for (int i = 1; i <= count; i++) {
      if (col + i > 8 || row + i > 8) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col + i, row + i)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col + i, row + i));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col + i, row + i)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col + i, row + i));
          break;
        } else {
          break;
        }
      }
    }

    //col-    row+
    for (int i = 1; i <= count; i++) {
      if (col - i < 1 || row + i > 8) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col - i, row + i)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col - i, row + i));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col - i, row + i)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col - i, row + i));
          break;
        } else {
          break;
        }
      }
    }

    //col+    row-
    for (int i = 1; i <= count; i++) {
      if (col + i > 8 || row - i < 1) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col + i, row - i)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col + i, row - i));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col + i, row - i)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col + i, row - i));
          break;
        } else {
          break;
        }
      }
    }

    //col-    row-
    for (int i = 1; i <= count; i++) {
      if (col - i < 1 || row - i < 1) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col - i, row - i)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col - i, row - i));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col - i, row - i)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col - i, row - i));
          break;
        } else {
          break;
        }
      }
    }

    return MoveOptions(clickedBox, onGoingBoxes, onShotingBoxes);
  }

  static getRockMoveOptions(
      int count, int col, int row, SuperPlayer superPlayer) {
    ChessBox clickedBox = ChessBox(col, row);
    List<ChessBox> onGoingBoxes = [];
    List<ChessBox> onShotingBoxes = [];

    //col-   row
    for (int i = 1; i <= count; i++) {
      if (col - i < 1) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col - i, row)) {
        onGoingBoxes.add(ChessBox(col - i, row));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col - i, row)) {
          onShotingBoxes.add(ChessBox(col - i, row));
          break;
        }
        break;
      }
    }

    //col+   row
    for (int i = 1; i <= count; i++) {
      if (col + i > 8) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col + i, row)) {
        onGoingBoxes.add(ChessBox(col + i, row));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col + i, row)) {
          onShotingBoxes.add(ChessBox(col + i, row));
          break;
        }
        break;
      }
    }

    //col   row+
    for (int i = 1; i <= count; i++) {
      if (row + i > 8) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col, row + i)) {
        onGoingBoxes.add(ChessBox(col, row + i));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col, row + i)) {
          onShotingBoxes.add(ChessBox(col, row + i));
          break;
        }
        break;
      }
    }

    //col   row-
    for (int i = 1; i <= count; i++) {
      if (row - i < 1) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col, row - i)) {
        onGoingBoxes.add(ChessBox(col, row - i));
      } else {
        if (ChessBoard().isEnemyAt(superPlayer, col, row - i)) {
          onShotingBoxes.add(ChessBox(col, row - i));
          break;
        }
        break;
      }
    }

    return MoveOptions(clickedBox, onGoingBoxes, onShotingBoxes);
  }
}
