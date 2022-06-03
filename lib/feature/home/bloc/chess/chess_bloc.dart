import 'package:chess_flutter/feature/home/bloc/chess/chess_state.dart';
import 'package:chess_flutter/models/board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:chess_flutter/models/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessCubit extends Cubit<ChessState> {
  SuperChessCharacter? scc;
  bool isKingInCheck = false;
  ChessBox kingBox = const ChessBox(0, 0);
  MoveOptions moveOptions = MoveOptions(const ChessBox(0, 0), [], []);
  ChessCubit() : super(ChessInitialState());
  void characterClicked(int col, int row) {
    if (moveOptions.onShotingBoxes.contains(ChessBox(col, row))) {
      //shot
      SuperChessCharacter shottedChar = ChessBoard().getcharacter(col, row);
      shottedChar.isInGame = false;
      print("==> $scc shotted $shottedChar");
      if (scc != null) {
        scc!.move(col, row);
        if (scc!.player == Player.black) {
          isKingInCheck = PlayerWhite().isMyKingInCheck();
          kingBox = ChessBox(
            PlayerWhite().characters["king"]!.columnNumber,
            PlayerWhite().characters["king"]!.rowNumber,
          );
        } else {
          isKingInCheck = PlayerBlack().isMyKingInCheck();
          kingBox = ChessBox(
            PlayerWhite().characters["king"]!.columnNumber,
            PlayerWhite().characters["king"]!.rowNumber,
          );
        }
      }
      emit(CharacterMovedState(isKingInCheck, kingBox: kingBox));
      moveOptions.clear();
    } else {
      scc = ChessBoard().getcharacter(col, row);
      moveOptions = ChessBoard()
          .getcharacter(col, row)
          .preMove()
          .verification(ChessBoard().getPlayer(col, row));
      emit(CharacterClickedState(moveOptions, isKingInCheck, kingBox: kingBox));
    }
  }

  void boxClicked(int col, int row) {
    for (var box in moveOptions.onGoingBoxes) {
      if (box.isInCoordinate(col, row)) {
        if (scc != null) {
          scc!.move(col, row);
          if (scc!.player == Player.black) {
            isKingInCheck = PlayerWhite().isMyKingInCheck();
            kingBox = ChessBox(
              PlayerWhite().characters["king"]!.columnNumber,
              PlayerWhite().characters["king"]!.rowNumber,
            );
          } else {
            isKingInCheck = PlayerBlack().isMyKingInCheck();
            kingBox = ChessBox(
              PlayerWhite().characters["king"]!.columnNumber,
              PlayerWhite().characters["king"]!.rowNumber,
            );
          }
        }
        emit(CharacterMovedState(isKingInCheck, kingBox: kingBox));
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
}
