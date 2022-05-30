import 'package:chess_flutter/models/board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:chess_flutter/models/player.dart';
import 'package:flutter/material.dart';

class PreMoveMethods {
  static MoveOptions preMovePawn(Player player, int col, int row) {
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
    if (player == Player.black) {
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
      if (ChessBoard().isEnemyAt(player, nextCol, row - 1)) {
        print("and to shoting");
        onShotingBoxes.add(ChessBox(nextCol, row - 1));
      }
    }
    if (row + 1 < 9 && isThereNextCol) {
      if (ChessBoard().isEnemyAt(player, nextCol, row + 1)) {
        print("and to shoting");
        onShotingBoxes.add(ChessBox(nextCol, row + 1));
      }
    }

    if (isThereNextCol) {
      if (!ChessBoard().hasCharacterAt(nextCol, row)) {
        print("add to ongoing");
        onGoingBoxes.add(ChessBox(nextCol, row));
        if (isInInitialPlace && !ChessBoard().hasCharacterAt(next2Col, row)) {
          print("add to ongoing");
          onGoingBoxes.add(ChessBox(next2Col, row));
        }
      }
    }
    if (col == finalCol) {
      print("promote to queen");
      /**
       * promote to queen
       */
    }

    return MoveOptions(clickedBox, onGoingBoxes, onShotingBoxes);
  }

  //
  //
  //
  //
  //
  static MoveOptions preMoveBishop(Player player, int col, int row) {
    ChessBox clickedBox = ChessBox(col, row);
    List<ChessBox> onGoingBoxes = [];
    List<ChessBox> onShotingBoxes = [];

    //col+    row+
    for (int i = 1; i <= 8; i++) {
      if (col + i > 8 || row + i > 8) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col + i, row + i)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col + i, row + i));
      } else {
        if (ChessBoard().isEnemyAt(player, col + i, row + i)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col + i, row + i));
          break;
        } else {
          break;
        }
      }
    }

    //col-    row+
    for (int i = 1; i <= 8; i++) {
      if (col - i < 1 || row + i > 8) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col - i, row + i)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col - i, row + i));
      } else {
        if (ChessBoard().isEnemyAt(player, col - i, row + i)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col - i, row + i));
          break;
        } else {
          break;
        }
      }
    }

    //col+    row-
    for (int i = 1; i <= 8; i++) {
      if (col + i > 8 || row - i < 1) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col + i, row - i)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col + i, row - i));
      } else {
        if (ChessBoard().isEnemyAt(player, col + i, row - i)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col + i, row - i));
          break;
        } else {
          break;
        }
      }
    }

    //col-    row-
    for (int i = 1; i <= 8; i++) {
      if (col - i < 1 || row - i < 1) {
        break;
      }
      if (!ChessBoard().hasCharacterAt(col - i, row - i)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col - i, row - i));
      } else {
        if (ChessBoard().isEnemyAt(player, col - i, row - i)) {
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

  //
  //
  //
  //
  //
  static MoveOptions preMoveKnight(Player player, int col, int row) {
    ChessBox clickedBox = ChessBox(col, row);
    List<ChessBox> onGoingBoxes = [];
    List<ChessBox> onShotingBoxes = [];

    //col+2   row+1
    if (col + 2 < 9 && row + 1 < 9) {
      if (!ChessBoard().hasCharacterAt(col + 2, row + 1)) {
        //add to ongoing
        onGoingBoxes.add(ChessBox(col + 2, row + 1));
      } else {
        if (ChessBoard().isEnemyAt(player, col + 2, row + 1)) {
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
        if (ChessBoard().isEnemyAt(player, col + 1, row + 2)) {
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
        if (ChessBoard().isEnemyAt(player, col + 2, row - 1)) {
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
        if (ChessBoard().isEnemyAt(player, col + 1, row - 2)) {
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
        if (ChessBoard().isEnemyAt(player, col - 2, row + 1)) {
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
        if (ChessBoard().isEnemyAt(player, col - 1, row + 2)) {
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
        if (ChessBoard().isEnemyAt(player, col - 2, row - 1)) {
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
        if (ChessBoard().isEnemyAt(player, col - 1, row - 2)) {
          //add to onshoting
          onShotingBoxes.add(ChessBox(col - 1, row - 2));
        }
      }
    }

    return MoveOptions(clickedBox, onGoingBoxes, onShotingBoxes);
  }
}
