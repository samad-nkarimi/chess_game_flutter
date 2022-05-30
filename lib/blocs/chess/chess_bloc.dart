import 'package:chess_flutter/blocs/chess/chess_state.dart';
import 'package:chess_flutter/models/board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/move_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessCubit extends Cubit<ChessState> {
  ChessCubit() : super(ChessInitialState());
  void characterClicked(int col, int row) {
    print("clicked");
    MoveOptions moveOptions = ChessBoard().getcharacter(col, row).preMove();
    print(moveOptions.clickedBox);
    print(moveOptions.onGoingBoxes);
    print(moveOptions.onShotingBoxes);
    print(col);
    print(row);
    print(ChessBoard().getcharacter(col, row) is ChessCharacterPawn);
    emit(CharacterClickedState(moveOptions));
  }
}
