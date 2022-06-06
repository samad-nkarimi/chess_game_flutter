import 'package:equatable/equatable.dart';

class ChessBox extends Equatable {
  final int columnNumber;
  final int rowNumber;
  // final Color color;

  const ChessBox(this.columnNumber, this.rowNumber);

  bool isInCoordinate(int col, int row) {
    if (columnNumber == col && rowNumber == row) {
      return true;
    }
    return false;
  }

  @override
  List<Object?> get props => [columnNumber, rowNumber];
}
