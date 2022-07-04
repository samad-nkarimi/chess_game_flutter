import 'package:chess_flutter/models/chess_box.dart';
import 'package:equatable/equatable.dart';

class RemoteMoveDetails extends Equatable {
  final String requestUsername;
  final String targetUsername;
  final ChessBox fromBox;
  final ChessBox toBox;

  const RemoteMoveDetails(
    this.requestUsername,
    this.targetUsername,
    this.fromBox,
    this.toBox,
  );

  @override
  List<Object?> get props => [fromBox, toBox];

  RemoteMoveDetails.fromJson(Map<String, dynamic> json)
      : requestUsername = "",
        targetUsername = "",
        fromBox = ChessBox((9 - json["move_from_col"]).toInt(),
            (9 - json["move_from_row"]).toInt()),
        toBox = ChessBox((9 - json["move_to_col"]).toInt(),
            (9 - json["move_to_row"]).toInt());

  // toJson(RemoteMoveDetails remoteMoveDetails) {
  //   {
  //     "from_box":remoteMoveDetails.fromBox
  //   }

  // }

  int reverseCol(int col) {
    return 9 - col;
  }

  int reverseRow(int row) {
    return 9 - row;
  }
}
