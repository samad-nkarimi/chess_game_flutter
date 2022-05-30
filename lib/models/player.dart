import 'package:chess_flutter/constants/constant_images.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/enums/player.dart';

// class SuperPlayer {
//   final Map<String, SuperChessCharacter> characters = {};
// }

// class PlayerWhite {
//   // Map<String, dynamic> characters = {
//   //   "pawns": PawnsBunch(ConstantImages.svgWhitePawn),
//   //   "bishops": BishopsPair(ConstantImages.svgWhiteBishop),
//   //   "rocks": RocksPair(ConstantImages.svgWhiteRock),
//   //   "knights": KnightsPair(ConstantImages.svgWhiteKnight),
//   //   "queen": ChessCharacterQueen(ConstantImages.svgWhiteQueen),
//   //   "king": ChessCharacterKing(ConstantImages.svgWhiteKing),
//   // };

//   PawnsBunch pawns = PawnsBunch(ConstantImages.svgWhitePawn);

//   Pair rocks = Pair<ChessCharacterRock>(
//     ChessCharacterRock(ConstantImages.svgWhiteRock),
//     ChessCharacterRock(ConstantImages.svgWhiteRock),
//   );
//   Pair knights = Pair<ChessCharacterKnight>(
//     ChessCharacterKnight(ConstantImages.svgWhiteKnight),
//     ChessCharacterKnight(ConstantImages.svgWhiteKnight),
//   );
//   Pair bishops = Pair<ChessCharacterBishop>(
//     ChessCharacterBishop(ConstantImages.svgWhiteBishop),
//     ChessCharacterBishop(ConstantImages.svgWhiteBishop),
//   );
//   ChessCharacterQueen queen = ChessCharacterQueen(ConstantImages.svgWhiteQueen);
//   ChessCharacterKing king = ChessCharacterKing(ConstantImages.svgWhiteKing);

//   PlayerWhite();

//   PlayerWhite.initialize() {
//     pawns = PawnsBunch(ConstantImages.svgWhitePawn, col: 7, rowStart: 1);

//     rocks = Pair<ChessCharacterRock>(
//       ChessCharacterRock(ConstantImages.svgWhiteRock,
//           columnNumber: 8, rowNumber: 1),
//       ChessCharacterRock(ConstantImages.svgWhiteRock,
//           columnNumber: 8, rowNumber: 8),
//     );
//     knights = Pair<ChessCharacterKnight>(
//       ChessCharacterKnight(ConstantImages.svgWhiteKnight,
//           columnNumber: 8, rowNumber: 2),
//       ChessCharacterKnight(ConstantImages.svgWhiteKnight,
//           columnNumber: 8, rowNumber: 7),
//     );
//     bishops = Pair<ChessCharacterBishop>(
//       ChessCharacterBishop(ConstantImages.svgWhiteBishop,
//           columnNumber: 8, rowNumber: 3),
//       ChessCharacterBishop(ConstantImages.svgWhiteBishop,
//           columnNumber: 8, rowNumber: 6),
//     );
//     queen = ChessCharacterQueen(ConstantImages.svgWhiteQueen,
//         columnNumber: 8, rowNumber: 4);
//     king = ChessCharacterKing(ConstantImages.svgWhiteKing,
//         columnNumber: 8, rowNumber: 5);
//   }
// }

// class PawnsBunch {
//   late ChessCharacterPawn pawn1;
//   late ChessCharacterPawn pawn2;
//   late ChessCharacterPawn pawn3;
//   late ChessCharacterPawn pawn4;
//   late ChessCharacterPawn pawn5;
//   late ChessCharacterPawn pawn6;
//   late ChessCharacterPawn pawn7;
//   late ChessCharacterPawn pawn8;
//   PawnsBunch(String photoId, {int col = 1, int rowStart = 1}) {
//     pawn1 = ChessCharacterPawn(photoId, columnNumber: col, rowNumber: rowStart);
//     pawn2 =
//         ChessCharacterPawn(photoId, columnNumber: col, rowNumber: rowStart + 1);
//     pawn3 =
//         ChessCharacterPawn(photoId, columnNumber: col, rowNumber: rowStart + 2);
//     pawn4 =
//         ChessCharacterPawn(photoId, columnNumber: col, rowNumber: rowStart + 3);
//     pawn5 =
//         ChessCharacterPawn(photoId, columnNumber: col, rowNumber: rowStart + 4);
//     pawn6 =
//         ChessCharacterPawn(photoId, columnNumber: col, rowNumber: rowStart + 5);
//     pawn7 =
//         ChessCharacterPawn(photoId, columnNumber: col, rowNumber: rowStart + 6);
//     pawn8 =
//         ChessCharacterPawn(photoId, columnNumber: col, rowNumber: rowStart + 7);
//   }
// }

// // class BishopsPair {
// //   late ChessCharacterBishop right;
// //   late ChessCharacterBishop left;
// //   BishopsPair(String photoId) {
// //     right = ChessCharacterBishop(photoId);
// //     left = ChessCharacterBishop(photoId);
// //   }
// // }

// // class RocksPair {
// //   late ChessCharacterRock right;
// //   late ChessCharacterRock left;

// //   RocksPair(String photoId) {
// //     right = ChessCharacterRock(photoId);
// //     left = ChessCharacterRock(photoId);
// //   }
// // }

// // class KnightsPair {
// //   late ChessCharacterKnight right;
// //   late ChessCharacterKnight left;

// //   KnightsPair(String photoId) {
// //     right = ChessCharacterKnight(photoId);
// //     left = ChessCharacterKnight(photoId);
// //   }
// // }

// class Pair<T> {
//   late T right;
//   late T left;

//   Pair(T right, T left) {
//     right = right;
//     left = left;
//   }
// }

enum Rules { pawn, rock, knight, bishop, queen, king }

class PlayerWhite {
  Map<String, SuperChessCharacter> characters = {};
  PlayerWhite.initialize() {
    characters = {
      "pawn1": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          columnNumber: 7, rowNumber: 1),
      "pawn2": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          columnNumber: 7, rowNumber: 2),
      "pawn3": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          columnNumber: 7, rowNumber: 3),
      "pawn4": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          columnNumber: 7, rowNumber: 4),
      "pawn5": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          columnNumber: 7, rowNumber: 5),
      "pawn6": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          columnNumber: 7, rowNumber: 6),
      "pawn7": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          columnNumber: 7, rowNumber: 7),
      "pawn8": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          columnNumber: 7, rowNumber: 8),
      "rock1": ChessCharacterRock(ConstantImages.svgWhiteRock,
          columnNumber: 8, rowNumber: 1),
      "knight1": ChessCharacterKnight(ConstantImages.svgWhiteKnight,
          columnNumber: 8, rowNumber: 2),
      "bishop1": ChessCharacterBishop(ConstantImages.svgWhiteBishop,
          columnNumber: 8, rowNumber: 3),
      "queen": ChessCharacterQueen(ConstantImages.svgWhiteQueen,
          columnNumber: 8, rowNumber: 4),
      "king": ChessCharacterKing(ConstantImages.svgWhiteKing,
          columnNumber: 8, rowNumber: 5),
      "bishop2": ChessCharacterBishop(ConstantImages.svgWhiteBishop,
          columnNumber: 8, rowNumber: 6),
      "knight2": ChessCharacterKnight(ConstantImages.svgWhiteKnight,
          columnNumber: 8, rowNumber: 7),
      "rock2": ChessCharacterRock(ConstantImages.svgWhiteRock,
          columnNumber: 8, rowNumber: 8),
    };
  }

  SuperChessCharacter getCharacter(int col, int row) {
    for (SuperChessCharacter ch in characters.values) {
      if (ch.columnNumber == col && ch.rowNumber == row) {
        return ch;
      }
    }
    return ChessCharacterNone("photo");
  }
}

class PlayerBlack {
  Map<String, SuperChessCharacter> characters = {};
  PlayerBlack.initialize() {
    characters = {
      "pawn1": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          player: Player.black, columnNumber: 2, rowNumber: 8),
      "pawn2": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          player: Player.black, columnNumber: 2, rowNumber: 7),
      "pawn3": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          player: Player.black, columnNumber: 2, rowNumber: 6),
      "pawn4": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          player: Player.black, columnNumber: 2, rowNumber: 5),
      "pawn5": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          player: Player.black, columnNumber: 2, rowNumber: 4),
      "pawn6": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          player: Player.black, columnNumber: 2, rowNumber: 3),
      "pawn7": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          player: Player.black, columnNumber: 2, rowNumber: 2),
      "pawn8": ChessCharacterPawn(ConstantImages.svgWhitePawn,
          player: Player.black, columnNumber: 2, rowNumber: 1),
      "rock1": ChessCharacterRock(ConstantImages.svgWhiteRock,
          player: Player.black, columnNumber: 1, rowNumber: 8),
      "knight1": ChessCharacterKnight(ConstantImages.svgWhiteKnight,
          player: Player.black, columnNumber: 1, rowNumber: 7),
      "bishop1": ChessCharacterBishop(ConstantImages.svgWhiteBishop,
          player: Player.black, columnNumber: 1, rowNumber: 6),
      "queen": ChessCharacterQueen(ConstantImages.svgWhiteQueen,
          player: Player.black, columnNumber: 1, rowNumber: 5),
      "king": ChessCharacterKing(ConstantImages.svgWhiteKing,
          player: Player.black, columnNumber: 1, rowNumber: 4),
      "bishop2": ChessCharacterBishop(ConstantImages.svgWhiteBishop,
          player: Player.black, columnNumber: 1, rowNumber: 3),
      "knight2": ChessCharacterKnight(ConstantImages.svgWhiteKnight,
          player: Player.black, columnNumber: 1, rowNumber: 2),
      "rock2": ChessCharacterRock(ConstantImages.svgWhiteRock,
          player: Player.black, columnNumber: 1, rowNumber: 1),
    };
  }

  SuperChessCharacter getCharacter(int col, int row) {
    for (SuperChessCharacter ch in characters.values) {
      if (ch.columnNumber == col && ch.rowNumber == row) {
        return ch;
      }
    }
    return ChessCharacterNone("photo");
  }
}
