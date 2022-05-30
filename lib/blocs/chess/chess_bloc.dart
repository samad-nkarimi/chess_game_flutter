import 'package:chess_flutter/blocs/chess/chess_state.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessCubit extends Cubit<ChessState> {
  ChessCubit() : super(ChessInitialState());
  void characterClicked(int col, int row) {
    emit(CharacterClickedState(
        ChessBox(col, row), [ChessBox(3, 3)], [ChessBox(4, 4)]));
  }
}
