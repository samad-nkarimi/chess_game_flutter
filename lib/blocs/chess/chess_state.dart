import 'package:chess_flutter/models/chess_box.dart';
import 'package:equatable/equatable.dart';

abstract class ChessState extends Equatable {}

class ChessInitialState extends ChessState {
  @override
  List<Object?> get props => [];
}

class CharacterClickedState extends ChessState {
  final ChessBox clickedBox;
  final List<ChessBox> onGoingBoxes;
  final List<ChessBox> onShotingBoxes;

  CharacterClickedState(
      this.clickedBox, this.onGoingBoxes, this.onShotingBoxes);

  @override
  List<Object?> get props => [clickedBox, onGoingBoxes, onShotingBoxes];
}
