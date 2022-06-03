import 'package:chess_flutter/models/board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/player.dart';

import 'enums/player.dart';

class MoveOptions {
  final ChessBox clickedBox;
  final List<ChessBox> onGoingBoxes;
  final List<ChessBox> onShotingBoxes;

  MoveOptions(this.clickedBox, this.onGoingBoxes, this.onShotingBoxes);

  void clear() {
    onGoingBoxes.clear();
    onShotingBoxes.clear();
  }

  //we don't want a move that put the king in check
  MoveOptions verification(Player player) {
    MoveOptions moveOptions = MoveOptions(
      clickedBox,
      [],
      [],
    );
    print("verification");
    //clicked char
    SuperChessCharacter clickedChar = ChessBoard()
        .getcharacter(clickedBox.columnNumber, clickedBox.rowNumber);
    for (var chessBox in onGoingBoxes) {
      //temporary move just for test if the king is in check or not
      clickedChar.move(chessBox.columnNumber, chessBox.rowNumber);
      if (player == Player.white) {
        print("white");
        if (PlayerWhite().isMyKingInCheck()) {
          print("king in check");
          //remove the chessBox
          // onGoingBoxes.remove(chessBox);
        } else {
          moveOptions.onGoingBoxes.add(chessBox);
        }
      } else {
        if (PlayerBlack().isMyKingInCheck()) {
          //remove the chessBox
          // onGoingBoxes.remove(chessBox);
        } else {
          moveOptions.onGoingBoxes.add(chessBox);
        }
      }

      //get back the clicked char to main location
      clickedChar.move(clickedBox.columnNumber, clickedBox.rowNumber);
    }

    for (var chessBox in onShotingBoxes) {
      //temporary remove the shotted char
      SuperChessCharacter shottedChar = ChessBoard()
          .getcharacter(chessBox.columnNumber, chessBox.rowNumber)
        ..isInGame = false;
      print(shottedChar);
      //temporary move just for test if the king is in check or not
      clickedChar.move(chessBox.columnNumber, chessBox.rowNumber);
      if (player == Player.white) {
        if (PlayerWhite().isMyKingInCheck()) {
          //remove the chessBox
          // onShotingBoxes.remove(chessBox);
        } else {
          moveOptions.onShotingBoxes.add(chessBox);
        }
      } else {
        if (PlayerBlack().isMyKingInCheck()) {
          //remove the chessBox
          // onShotingBoxes.remove(chessBox);
        } else {
          moveOptions.onShotingBoxes.add(chessBox);
        }
      }

      //get back the clicked char to main location
      clickedChar.move(clickedBox.columnNumber, clickedBox.rowNumber);

      //get back the shotted char to game
      shottedChar.isInGame = true;
    }

    // MoveOptions moveOptions = MoveOptions(
    //   clickedBox,
    //   onGoingBoxes,
    //   onShotingBoxes,
    // );

    return moveOptions;
  }

  // List<ChessBox> getShotting(Player player) {
  //   late List<ChessBox> onShottingMoves;
  //   SuperChessCharacter king;
  //   if (player == Player.black) {
  //     king = PlayerBlack().characters["king"]!;
  //     onShottingMoves = PlayerWhite().getOnShottingMoves();
  //   } else {
  //     king = PlayerWhite().characters["king"]!;
  //     onShottingMoves = PlayerBlack().getOnShottingMoves();
  //   }

  //   return onShottingMoves;
  // }
}
