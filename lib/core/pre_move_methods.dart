import 'package:chess_flutter/constants/constant_images.dart';
import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/chess_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/enums/rule.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:chess_flutter/models/chess_player.dart';

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
    ChessPlayer chessPlayer = PlayerWhite();
    //for black
    if (player == Player.black) {
      initialPawnCol = 2;
      nextCol = col + 1;
      next2Col = col + 2;
      finalCol = 8;
      isThereNextCol = nextCol < 9;
      chessPlayer = PlayerBlack();
    }

    bool isInInitialPlace = true;
    if (col != initialPawnCol) {
      isInInitialPlace = false;
    }
    if (row - 1 > 0 && isThereNextCol) {
      if (ChessBoard().isEnemyAt(player, nextCol, row - 1)) {
        // print("and to shoting");
        onShotingBoxes.add(ChessBox(nextCol, row - 1));
      }
    }
    if (row + 1 < 9 && isThereNextCol) {
      if (ChessBoard().isEnemyAt(player, nextCol, row + 1)) {
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

      int index = chessPlayer.getEntityIndex(col, row);
      String key = chessPlayer.characters.keys.toList()[index];
      chessPlayer.characters[key] = ChessCharacter(
        ConstantImages.svgWhiteQueen,
        player,
        rule: Rule.queen,
        columnNumber: col,
        rowNumber: row,
      );

      return preMoveQueen(player, col, row);
    }

    return MoveOptions(clickedBox, onGoingBoxes, onShotingBoxes);
  }

  //
  //
  //
  //
  //
  static MoveOptions preMoveBishop(Player player, int col, int row) {
    return getBishopMoveOptions(8, col, row, player);
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

  //
  //
  //
  //
  //
  static MoveOptions preMoveRock(Player player, int col, int row) {
    return getRockMoveOptions(8, col, row, player);
  }

  //
  //
  //
  //
  //
  static MoveOptions preMoveQueen(Player player, int col, int row) {
    ChessBox clickedBox = ChessBox(col, row);

    MoveOptions moBishop = getBishopMoveOptions(8, col, row, player);
    MoveOptions moRock = getRockMoveOptions(8, col, row, player);

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
  static MoveOptions preMoveKing(Player player, int col, int row) {
    ChessBox clickedBox = ChessBox(col, row);

    MoveOptions moBishop = getBishopMoveOptions(1, col, row, player);
    MoveOptions moRock = getRockMoveOptions(1, col, row, player);
    MoveOptions kingMoveOptions = MoveOptions(
      clickedBox,
      [...moBishop.onGoingBoxes, ...moRock.onGoingBoxes],
      [...moBishop.onShotingBoxes, ...moRock.onShotingBoxes],
    );

    return kingMoveOptions;
  }

  static bool castlingFromLeft(Player player, int col, int row,
      MoveOptions verifiedKingMoveOptions, bool isTheKingInCheck) {
    //check if the king has never moved
    //must be -> false
    bool hasTheKingMoved = ChessBoard().getcharacter(col, row).isEverMoved;
    if (hasTheKingMoved) {
      return false;
    }

    //check if the destination of left rock is in check
    //must be -> false
    bool isLeftRockDestInCheck =
        !verifiedKingMoveOptions.onGoingBoxes.contains(ChessBox(col, row - 1));
    if (isLeftRockDestInCheck) {
      return false;
    }

    //check if the destination of right rock is in check
    //must be -> false
    bool isLeftDestOfTheKingInCheck =
        !verifiedKingMoveOptions.onGoingBoxes.contains(ChessBox(col, row - 2));
    if (isLeftDestOfTheKingInCheck) {
      return false;
    }

    //check if king is in check -> if it is, we cant do Castling
    //must be -> false
    // bool isTheKingInCheck = player.isMyKingInCheck();
    if (isTheKingInCheck) {
      return false;
    }

    //check if the left rock has never moved
    //must be -> false
    bool hasTheLeftRockMoved = ChessBoard().getcharacter(col, 1).isEverMoved;
    if (hasTheLeftRockMoved) {
      return false;
    }
    return true;
  }

  static bool castlingFromRight(Player player, int col, int row,
      MoveOptions verifiedKingMoveOptions, bool isTheKingInCheck) {
    //check if the king has never moved
    //must be -> false
    bool hasTheKingMoved = ChessBoard().getcharacter(col, row).isEverMoved;
    if (hasTheKingMoved) {
      return false;
    }

    //check if the destination of right rock is in check
    //must be -> false
    bool isRightRockDestInCheck =
        !verifiedKingMoveOptions.onGoingBoxes.contains(ChessBox(col, row + 1));
    if (isRightRockDestInCheck) {
      return false;
    }

    //check if the destination of king from right is in check
    //must be -> false
    bool isRightDestOfTheKingInCheck =
        !verifiedKingMoveOptions.onGoingBoxes.contains(ChessBox(col, row + 2));
    if (isRightDestOfTheKingInCheck) {
      return false;
    }

    //!!
    //check if king is in check -> if it is, we can't do Castling
    //must be -> false
    // bool isTheKingInCheck = player.isMyKingInCheck();
    if (isTheKingInCheck) {
      return false;
    }

    //check if the right rock has never moved
    //must be -> false
    bool hasTheRightRockMoved = ChessBoard().getcharacter(col, 8).isEverMoved;
    if (hasTheRightRockMoved) {
      return false;
    }

    return true;
  }

  static MoveOptions getBishopMoveOptions(
    int count,
    int col,
    int row,
    Player player,
  ) {
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
    for (int i = 1; i <= count; i++) {
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
    for (int i = 1; i <= count; i++) {
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
    for (int i = 1; i <= count; i++) {
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

  static getRockMoveOptions(int count, int col, int row, Player player) {
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
        if (ChessBoard().isEnemyAt(player, col - i, row)) {
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
        if (ChessBoard().isEnemyAt(player, col + i, row)) {
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
        if (ChessBoard().isEnemyAt(player, col, row + i)) {
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
        if (ChessBoard().isEnemyAt(player, col, row - i)) {
          onShotingBoxes.add(ChessBox(col, row - i));
          break;
        }
        break;
      }
    }

    return MoveOptions(clickedBox, onGoingBoxes, onShotingBoxes);
  }
}
