class SuperChessCharacter {
  int columnNumber = 1; //not index!
  int rowNumber = 1; //not index!
  bool isInGame = true;
  final String photoId;

  SuperChessCharacter(this.photoId,
      {this.columnNumber = 1, this.rowNumber = 1});
}

class ChessCharacterNone extends SuperChessCharacter {
  ChessCharacterNone(super.photoId, {super.columnNumber, super.rowNumber});
}

class ChessCharacterPawn extends SuperChessCharacter {
  ChessCharacterPawn(super.photoId, {super.columnNumber, super.rowNumber});
}

class ChessCharacterRock extends SuperChessCharacter {
  ChessCharacterRock(super.photoId, {super.columnNumber, super.rowNumber});
}

class ChessCharacterBishop extends SuperChessCharacter {
  ChessCharacterBishop(super.photoId, {super.columnNumber, super.rowNumber});
}

class ChessCharacterKnight extends SuperChessCharacter {
  ChessCharacterKnight(super.photoId, {super.columnNumber, super.rowNumber});
}

class ChessCharacterKing extends SuperChessCharacter {
  ChessCharacterKing(super.photoId, {super.columnNumber, super.rowNumber});
}

class ChessCharacterQueen extends SuperChessCharacter {
  ChessCharacterQueen(super.photoId, {super.columnNumber, super.rowNumber});
}
