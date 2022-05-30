import 'package:flutter/cupertino.dart';

class ChessBox {
  final int columnNumber;
  final int rowNumber;
  // final Color color;

  ChessBox(this.columnNumber, this.rowNumber);

  bool isInCoordinate(int col, int row) {
    if (columnNumber == col && rowNumber == row) {
      return true;
    }
    return false;
  }
}
