import 'dart:convert';

import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/chess_character.dart';
import 'package:hive/hive.dart';

class ChessPlayStorage {
  static final ChessPlayStorage _singleton = ChessPlayStorage._internal();
  factory ChessPlayStorage() {
    return _singleton;
  }
  ChessPlayStorage._internal();

  final String playsBox = "chess_play_box";

  // String getItemIndex(String id) {
  //   return "play_$id";
  // }

  void createBox() async {
    await Hive.openBox<String>(playsBox);
    await Hive.close();
  }

  Future<Box> getBox() async {
    Box box = await Hive.openBox(playsBox);
    return box;
  }

  void addChessBoard(String competitorUsername, String board) async {
    // print(board);
    Box box = await getBox();
    // box.clear();
    await box.put(competitorUsername, board);
    await box.close();
  }

  Future<void> deleteBoard(String competitorUsername) async {
    print(competitorUsername);
    try {
      // print(board);
      Box box = await getBox();
      // box.clear();
      // await box.delete(competitorUsername);
      print(box.keys);
      await box.close();
    } catch (e) {
      print("no such board");
    }
  }

  Future<ChessBoard> getBoard(String competitorUsername) async {
    Box box = await getBox();
    String boardJson = await box.get(competitorUsername);
    // print(boardJson);
    ChessBoard chessBoard = ChessBoard.fromJson(jsonDecode(boardJson));
    // print(box.keys);
    await box.close();
    return chessBoard;
  }
}
