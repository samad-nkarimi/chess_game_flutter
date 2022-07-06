import 'dart:convert';

import 'package:chess_flutter/core/pre_move_methods.dart';
import 'package:chess_flutter/domain/use_case/remote_play_move_use_case.dart';
import 'package:chess_flutter/feature/chess/bloc/chess/chess_state.dart';

import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/chess_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:chess_flutter/models/chess_player.dart';
import 'package:chess_flutter/models/remote_move_details.dart';
import 'package:chess_flutter/service/sse_service.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:chess_flutter/storage/chess_play_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessCubit extends Cubit<ChessState> {
  ChessCharacter? scc;
  bool isKingInCheck = false;
  //which player can move the char
  Player playerTurn = Player.white;
  List<ChessCharacter> outChars = [];
  ChessBox kingBox = const ChessBox(0, 0);
  bool isCheckMate = false;
  ChessPlayer? winner;
  MoveOptions moveOptions = MoveOptions.emptyMoveOptions();
  bool letsDoCastlingRight = false;
  bool letsDoCastlingLeft = false;
  ChessBox moveFromBox = const ChessBox(0, 0);
  ChessBox moveToBox = const ChessBox(0, 0);
  String competitorUsername = "offline";

  //clean arc
  final RemotePlayMoveUseCase remotePlayMoveUseCase;

  //
  ChessCubit(this.remotePlayMoveUseCase) : super(ChessInitialState());

  //
  void init(bool isOnline, String username) async {
    competitorUsername = username;
    emit(ChessInitialState());

    //TODO
    //load data from data if necessary
    // try {
    //   ChessBoard chessBoard =
    //       await ChessPlayStorage().getBoard(competitorUsername);

    //   PlayerWhite().characters = [];
    //   PlayerBlack().characters = [];

    //   chessBoard.boardMap.forEach(
    //     (key, value) {
    //       if (value.player == Player.white) {
    //         PlayerWhite().characters.add(value);
    //       } else {
    //         PlayerBlack().characters.add(value);
    //       }
    //     },
    //   );
    // } catch (e) {
    //   print("no board saved");
    // }

    //emit state
    emit(ResumePlayState(DateTime.now().microsecondsSinceEpoch.toString()));

    // if (!SSEService().streamController.hasListener && isOnline) {
    if (isOnline) {
      SSEService().streamController.stream.listen((data) {
        print(data);
        try {
          var map = jsonDecode(data) as Map<String, dynamic>;
          print(map);
          if (map.containsKey("type")) {
            if (map["type"] == "move") {
              if (map['request_username'] == competitorUsername) {
                RemoteMoveDetails rmd = RemoteMoveDetails.fromJson(
                    jsonDecode(data) as Map<String, dynamic>);
                handleRemoteMove(
                  rmd.fromBox.columnNumber,
                  rmd.fromBox.rowNumber,
                  rmd.toBox.columnNumber,
                  rmd.toBox.rowNumber,
                );
              }
            }
          }
        } catch (e) {
          print(e);
        }
      });
    }
  }

  //
  void handleRemoteMove(int fromCol, int fromRow, int toCol, int toRow) {
    /**
     turn player
     save board

    
     */
    characterClicked(fromCol, fromRow, true, true);
    print(1);
    if (ChessBoard().hasCharacterAt(toCol, toRow)) {
      characterClicked(toCol, toRow, true, true);

      print(2);
    } else {
      print(3);
      boxClicked(toCol, toRow, true, true);
    }
  }

  //the event when we click on a char
  void characterClicked(
      int col, int row, bool isRomuteMove, bool isOnline) async {
    letsDoCastlingRight = false;
    letsDoCastlingLeft = false;
    if (scc != null) {
      moveFromBox = ChessBox(scc!.columnNumber, scc!.rowNumber);
      moveToBox = ChessBox(col, row);
    }
    if (moveOptions.onShotingBoxes.contains(ChessBox(col, row))) {
      //shot the char
      ChessCharacter shottedChar = ChessBoard().getcharacter(col, row);
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

      emit(CharacterMovedState(
        isKingInCheck,
        moveFromBox,
        moveToBox,
        scc!.player,
        kingBox: kingBox,
      ));
      ChessPlayStorage()
          .addChessBoard(competitorUsername, ChessBoard().toJson());

      //TODO
      //send to server
      if (!isRomuteMove && isOnline) {
        remotePlayMoveUseCase.sendMoveToServer(RemoteMoveDetails(
          ServiceLocator().username,
          competitorUsername,
          moveFromBox,
          moveToBox,
        ));
      }

      //change the turn of the game
      turnThePlayer();
      moveOptions.clear();
    } else {
      //check if the player is in turn or not
      if (playerTurn == ChessBoard().getcharacter(col, row).player) {
        //the clicked char
        scc = ChessBoard().getcharacter(col, row);
        moveOptions = ChessBoard().getcharacter(col, row).preMove();
        if (scc!.isKing) {
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

        moveOptions = moveOptions.verification(scc!.chessPlayer);

        //castling
        if (scc!.isKing) {
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
          // if (scc!.isKing) {
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
          // }
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
  void boxClicked(int col, int row, bool isRemuteMove, bool isOnline) async {
    print("box clicked");
    if (scc != null) {
      moveFromBox = ChessBox(scc!.columnNumber, scc!.rowNumber);
      moveToBox = ChessBox(col, row);
    }

    for (var chessBox in moveOptions.onGoingBoxes) {
      //have we clicked on possible to move chess box??
      if (chessBox.isInCoordinate(col, row)) {
        if (scc!.isKing) {
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
        emit(CharacterMovedState(
          isKingInCheck,
          moveFromBox,
          moveToBox,
          scc!.player,
          kingBox: kingBox,
        ));
        ChessPlayStorage()
            .addChessBoard(competitorUsername, ChessBoard().toJson());

        //TODO
        //send to server
        if (!isRemuteMove && isOnline) {
          remotePlayMoveUseCase.sendMoveToServer(RemoteMoveDetails(
            ServiceLocator().username,
            competitorUsername,
            moveFromBox,
            moveToBox,
          ));
        }

        //change the turn of the game
        turnThePlayer();
        //

        scc = null;
      }
    }
    if (scc == null) {
      moveOptions.clear();
    }
  }

  void turnThePlayer() async {
    await Future.delayed(Duration.zero);
    playerTurn = playerTurn == Player.white ? Player.black : Player.white;
    emit(PlayerTurnedState(playerTurn));
  }

  void moveTheChar(int col, int row) {
    if (scc != null) {
      scc!.move(col, row);
      scc!.isEverMoved = true;

      isKingInCheck = scc!.chessPlayer.getEnemyPlayer().isMyKingInCheck();
      kingBox = ChessBox(
        scc!.chessPlayer
            .getEnemyPlayer()
            .characters
            .singleWhere((char) => char.isKing)
            .columnNumber,
        scc!.chessPlayer
            .getEnemyPlayer()
            .characters
            .singleWhere((char) => char.isKing)
            .rowNumber,
      );
      isCheckMate = scc!.chessPlayer.getEnemyPlayer().isCheckMate(col, row);
      winner = scc!.chessPlayer;
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
