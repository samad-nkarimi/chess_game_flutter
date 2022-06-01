import 'package:chess_flutter/models/chess_box.dart';

class MoveOptions {
  final ChessBox clickedBox;
  final List<ChessBox> onGoingBoxes;
  final List<ChessBox> onShotingBoxes;

  MoveOptions(this.clickedBox, this.onGoingBoxes, this.onShotingBoxes);

  void clear() {
    onGoingBoxes.clear();
    onShotingBoxes.clear();
  }
}
