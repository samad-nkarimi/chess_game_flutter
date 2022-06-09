import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/chess_player.dart';

class MoveOptions {
  final ChessBox clickedBox;
  final List<ChessBox> onGoingBoxes;
  final List<ChessBox> onShotingBoxes;

  MoveOptions(this.clickedBox, this.onGoingBoxes, this.onShotingBoxes);

  MoveOptions.emptyMoveOptions()
      : clickedBox = const ChessBox(0, 0),
        onGoingBoxes = [],
        onShotingBoxes = [];

  void clear() {
    onGoingBoxes.clear();
    onShotingBoxes.clear();
  }

  //when onGoing and onShotting are empty
  bool isEmpty() {
    if (onGoingBoxes.isEmpty && onShotingBoxes.isEmpty) {
      return true;
    }
    return false;
  }

  //we don't want a move that put the king in check
  MoveOptions verification(SuperPlayer superPlayer) {
    MoveOptions moveOptions = MoveOptions(
      clickedBox,
      [],
      [],
    );

    //clicked char
    SuperChessCharacter clickedChar = ChessBoard()
        .getcharacter(clickedBox.columnNumber, clickedBox.rowNumber);

    //for on goings
    for (var chessBox in onGoingBoxes) {
      //temporary move just for test if the king is in check or not
      clickedChar.move(chessBox.columnNumber, chessBox.rowNumber);

      if (!superPlayer.isMyKingInCheck()) {
        moveOptions.onGoingBoxes.add(chessBox);
      }

      //get back the clicked char to main location
      clickedChar.move(clickedBox.columnNumber, clickedBox.rowNumber);
    }

    //for on shottings
    for (var chessBox in onShotingBoxes) {
      //temporary remove the shotted char
      SuperChessCharacter shottedChar = ChessBoard()
          .getcharacter(chessBox.columnNumber, chessBox.rowNumber)
        ..isInGame = false;

      //temporary move just for test if the king is in check or not
      clickedChar.move(chessBox.columnNumber, chessBox.rowNumber);

      if (!superPlayer.isMyKingInCheck()) {
        moveOptions.onShotingBoxes.add(chessBox);
        print("king is  not  in check (${superPlayer.player}) : ${chessBox}");
      } else {
        print("king in check (${superPlayer.player}) : ${chessBox}");
      }

      //get back the clicked char to main location
      clickedChar.move(clickedBox.columnNumber, clickedBox.rowNumber);

      //get back the shotted char to game
      shottedChar.isInGame = true;
      //get back the shotted char to board
      ChessBoard().addToBoardMap(
          chessBox.columnNumber, chessBox.rowNumber, shottedChar);
    }

    return moveOptions;
  }

  bool singleChessBoxVerification(ChessBox chessBox) {
    return false;
  }
}
