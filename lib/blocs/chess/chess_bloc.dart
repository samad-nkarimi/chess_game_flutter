import 'package:chess_flutter/blocs/chess/chess_state.dart';
import 'package:chess_flutter/models/board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessCubit extends Cubit<ChessState> {
  SuperChessCharacter? scc;
  MoveOptions moveOptions = MoveOptions(ChessBox(0, 0), [], []);
  ChessCubit() : super(ChessInitialState());
  void characterClicked(int col, int row) {
    print("clicked");
    scc = ChessBoard().getcharacter(col, row);
    moveOptions = ChessBoard().getcharacter(col, row).preMove();
    emit(CharacterClickedState(moveOptions));
  }

  boxClicked(int col, int row) {
    for (var box in moveOptions.onGoingBoxes) {
      if (box.isInCoordinate(col, row)) {
        if (scc != null) {
          scc!.move(col, row);
        }
        emit(CharacterMovedState());
      }
    }

    for (var box in moveOptions.onShotingBoxes) {
      if (box.isInCoordinate(col, row)) {
        /**
        * shot state
        */
      }
    }
    moveOptions = MoveOptions(ChessBox(0, 0), [], []);
    scc = null;
  }
}
