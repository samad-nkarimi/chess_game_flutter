import 'dart:convert';

import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/chess_character.dart';
import 'package:hive/hive.dart';

class PlayStorage {
  static final PlayStorage _singleton = PlayStorage._internal();
  factory PlayStorage() {
    return _singleton;
  }
  PlayStorage._internal();

  final String playsBox = "plays_box";

  String getItemIndex(String id) {
    return "play_$id";
  }

  void createBox() async {
    await Hive.openBox<String>(playsBox);
    await Hive.close();
  }

  Future<Box> getBox() async {
    Box box = await Hive.openBox(playsBox);
    return box;
  }

  void addChessBoard(String competitorUsername, String board) async {
    print(board);
    Box box = await getBox();
    // box.clear();
    await box.put(getItemIndex(competitorUsername), board);
    await box.close();
  }

  Future<ChessBoard> getBoard(String playId) async {
    Box box = await getBox();
    String boardJson = await box.get(getItemIndex(playId));
    ChessBoard chessBoard = ChessBoard.fromJson(jsonDecode(boardJson));
    print(box.keys);
    await box.close();
    return chessBoard;
  }
}
