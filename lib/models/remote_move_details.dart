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

  RemoteMoveDetails.fromJson()
      : requestUsername = "",
        targetUsername = "",
        fromBox = ChessBox(0, 0),
        toBox = ChessBox(0, 0);

  // toJson(RemoteMoveDetails remoteMoveDetails) {
  //   {
  //     "from_box":remoteMoveDetails.fromBox
  //   }

  // }
}
