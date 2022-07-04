import 'dart:convert';

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

  String toJson() {
    return jsonEncode({
      "col_and_row": '$columnNumber$rowNumber',
    });
  }

  String toKey() {
    return '$columnNumber$rowNumber';
  }

  ChessBox.fromJson(Map<String, String> json)
      : columnNumber = int.parse(json['col_and_row']!.substring(0, 1)),
        rowNumber = int.parse(json['col_and_row']!.substring(1));

  ChessBox.fromKey(String key)
      : columnNumber = int.parse(key.substring(0, 1)),
        rowNumber = int.parse(key.substring(1));

  @override
  List<Object?> get props => [columnNumber, rowNumber];
}
