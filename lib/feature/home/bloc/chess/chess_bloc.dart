import 'package:chess_flutter/core/pre_move_methods.dart';
import 'package:chess_flutter/feature/home/bloc/chess/chess_state.dart';
import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:chess_flutter/models/chess_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessCubit extends Cubit<ChessState> {
  SuperChessCharacter? scc;
  bool isKingInCheck = false;
  //which player can move the char
  SuperPlayer playerTurn = PlayerWhite();
  List<SuperChessCharacter> outChars = [];
  ChessBox kingBox = const ChessBox(0, 0);
  bool isCheckMate = false;
  SuperPlayer? winner;
  MoveOptions moveOptions = MoveOptions.emptyMoveOptions();
  bool letsDoCastlingRight = false;
  bool letsDoCastlingLeft = false;

  //
  ChessCubit() : super(ChessInitialState());

  //the event when we click on a char
  void characterClicked(int col, int row) async {
    letsDoCastlingRight = false;
    letsDoCastlingLeft = false;
    if (moveOptions.onShotingBoxes.contains(ChessBox(col, row))) {
      //shot the char
      SuperChessCharacter shottedChar = ChessBoard().getcharacter(col, row);
      shottedChar.isInGame = false;
      print("==> $scc shotted $shottedChar");
      //move the char
      moveTheChar(col, row);
      await Future.delayed(Duration.zero);
      //add shotted char to out ones
      outChars.add(shottedChar);
      //emit to show out chars
      emit(CharacterShottedState(outChars));
      //wait for prevent conflict states
      await Future.delayed(Duration.zero);

      emit(CharacterMovedState(isKingInCheck, kingBox: kingBox));
      //change the turn of the game
      turnThePlayer();
      moveOptions.clear();
    } else {
      //check if the player is in turn or not
      if (playerTurn == ChessBoard().getcharacter(col, row).player) {
        //the clicked char
        scc = ChessBoard().getcharacter(col, row);
        moveOptions = ChessBoard().getcharacter(col, row).preMove();
        if (scc is ChessCharacterKing) {
          //check for Castling  -> right rock -> king row < rock row
          //right rock row = 8
          //the col is constant
          //check if there is a character between king and rock -> form (row +1) to  (8-1)
          //must be -> false
          bool isAnyCharInBetweenFormRight = false;
          for (int i = row + 1; i < 8; i++) {
            isAnyCharInBetweenFormRight = ChessBoard().hasCharacterAt(col, i);
            if (isAnyCharInBetweenFormRight) break;
          }
          if (!isAnyCharInBetweenFormRight) {
            moveOptions.onGoingBoxes.add(ChessBox(col, row + 2));
          }
          //check for Castling  -> left rock -> king row > rock row
          //left rock row = 1
          //check if there is a character between king and rock -> form (1+1) to  (row-1)
          //must be -> false
          bool isAnyCharInBetweenFromLeft = false;
          for (int i = 1 + 1; i < row; i++) {
            isAnyCharInBetweenFromLeft = ChessBoard().hasCharacterAt(col, i);
            if (isAnyCharInBetweenFromLeft) break;
          }
          if (!isAnyCharInBetweenFromLeft) {
            moveOptions.onGoingBoxes.add(ChessBox(col, row - 2));
          }
        }

        moveOptions = moveOptions.verification(scc!.player);

        //castling
        if (scc is ChessCharacterKing) {
          bool cfl = PreMoveMethods.castlingFromLeft(
            ChessBoard().getcharacter(col, row).player,
            col,
            row,
            moveOptions,
            isKingInCheck,
          );
          if (!cfl) {
            moveOptions.onGoingBoxes.remove(ChessBox(col, row - 2));
          } else {
            letsDoCastlingLeft = true;
          }
          print("cfl: $cfl");
          if (scc is ChessCharacterKing) {
            bool rfl = PreMoveMethods.castlingFromRight(
              ChessBoard().getcharacter(col, row).player,
              col,
              row,
              moveOptions,
              isKingInCheck,
            );
            if (!rfl) {
              moveOptions.onGoingBoxes.remove(ChessBox(col, row + 2));
            } else {
              letsDoCastlingRight = true;
            }
            print("rfl: $rfl");
          }
        }
        //emit clicked state to show preview of possible moves
        emit(CharacterClickedState(moveOptions, isKingInCheck,
            kingBox: kingBox));
      } else {
        //you cant move, its not your turn
      }
    }
  }

  //the event when we click on an empty box
  void boxClicked(int col, int row) async {
    print("box clicked");

    for (var chessBox in moveOptions.onGoingBoxes) {
      //have we clicked on possible to move chess box??
      if (chessBox.isInCoordinate(col, row)) {
        if (scc is ChessCharacterKing) {
          if (letsDoCastlingRight && chessBox.rowNumber == scc!.rowNumber + 2) {
            ChessBoard().getcharacter(col, 8)
              ..move(col, row - 1)
              ..isEverMoved = true;
          }
          if (letsDoCastlingLeft && chessBox.rowNumber == scc!.rowNumber - 2) {
            ChessBoard().getcharacter(col, 1)
              ..move(col, row + 1)
              ..isEverMoved = true;
          }
        }
        moveTheChar(col, row);
        await Future.delayed(Duration.zero);
        emit(CharacterMovedState(isKingInCheck, kingBox: kingBox));
        //change the turn of the game
        turnThePlayer();
      }
    }
    moveOptions.clear();
  }

  void turnThePlayer() {
    playerTurn = playerTurn.getEnemyPlayer();
  }

  void moveTheChar(int col, int row) {
    if (scc != null) {
      scc!.move(col, row);
      scc!.isEverMoved = true;

      isKingInCheck = scc!.player.getEnemyPlayer().isMyKingInCheck();
      kingBox = ChessBox(
        scc!.player.getEnemyPlayer().characters["king"]!.columnNumber,
        scc!.player.getEnemyPlayer().characters["king"]!.rowNumber,
      );
      isCheckMate = scc!.player.getEnemyPlayer().isCheckMate(col, row);
      winner = scc!.player;

      //

      scc = null;
    }
    if (isCheckMate) {
      // send state to show winner
      if (winner != null) {
        print("winner ==> $winner");
        emit(PlayerWonState(winner!));
      }
    }
  }
}
