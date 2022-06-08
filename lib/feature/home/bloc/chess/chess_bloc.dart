import 'package:chess_flutter/feature/home/bloc/chess/chess_state.dart';
import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:chess_flutter/models/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessCubit extends Cubit<ChessState> {
  SuperChessCharacter? scc;
  bool isKingInCheck = false;
  SuperPlayer shift = PlayerWhite();
  List<SuperChessCharacter> outChars = [];
  ChessBox kingBox = const ChessBox(0, 0);
  bool isCheckMate = false;
  SuperPlayer? winner;
  MoveOptions moveOptions = MoveOptions(const ChessBox(0, 0), [], []);
  ChessCubit() : super(ChessInitialState());
  void characterClicked(int col, int row) async {
    if (moveOptions.onShotingBoxes.contains(ChessBox(col, row))) {
      //shot
      SuperChessCharacter shottedChar = ChessBoard().getcharacter(col, row);
      shottedChar.isInGame = false;
      print("==> $scc shotted $shottedChar");
      if (scc != null) {
        scc!.move(col, row);
        scc!.isEverMoved = true;

        scc!.player.getEnemyPlayer();
        isKingInCheck = scc!.player.getEnemyPlayer().isMyKingInCheck();
        kingBox = ChessBox(
          scc!.player.getEnemyPlayer().characters["king"]!.columnNumber,
          scc!.player.getEnemyPlayer().characters["king"]!.rowNumber,
        );
        isCheckMate = scc!.player.getEnemyPlayer().isCheckMate(col, row);
        winner = scc!.player;
      }
      if (isCheckMate) {
        // send state to show winner
        if (winner != null) {
          print("winner ==> $winner");
          emit(PlayerWonState(winner!));
        }
      }
      outChars.add(shottedChar);
      emit(CharacterShottedState(outChars));
      await Future.delayed(Duration.zero);

      emit(CharacterMovedState(isKingInCheck, kingBox: kingBox));
      shiftPlayer();
      moveOptions.clear();
    } else {
      if (shift == ChessBoard().getcharacter(col, row).player) {
        scc = ChessBoard().getcharacter(col, row);
        moveOptions = ChessBoard()
            .getcharacter(col, row)
            .preMove()
            .verification(scc!.player);
        emit(CharacterClickedState(moveOptions, isKingInCheck,
            kingBox: kingBox));
      }
    }
  }

  void boxClicked(int col, int row) async {
    for (var box in moveOptions.onGoingBoxes) {
      if (box.isInCoordinate(col, row)) {
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
        }
        if (isCheckMate) {
          // send state to show winner
          if (winner != null) {
            print("winner ==> $winner");
            emit(PlayerWonState(winner!));
            await Future.delayed(Duration.zero);
          }
        }
        emit(CharacterMovedState(isKingInCheck, kingBox: kingBox));
        shiftPlayer();
      }
    }

    for (var box in moveOptions.onShotingBoxes) {
      if (box.isInCoordinate(col, row)) {
        /**
        * shot state
        */
      }
    }
    moveOptions.clear();
    scc = null;
  }

  void shiftPlayer() {
    shift = shift.getEnemyPlayer();
  }
}
