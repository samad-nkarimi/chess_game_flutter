import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/feature/home/bloc/chess/chess_bloc.dart';
import 'package:chess_flutter/feature/home/bloc/chess/chess_state.dart';
import 'package:chess_flutter/models/board.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/chess_box.dart';
import 'package:chess_flutter/models/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double squareLength = 350; // min(width , height)
  // late final PlayerWhite playerWhite;
  // late final PlayerBlack playerBlack;
  // Map<int, SuperChessCharacter> singleChar = {};

  Color getDefaultBoxColor(int columnIndex, int rowIndex) {
    if (columnIndex % 2 == 0) {
      // even columns
      if (rowIndex % 2 == 0) {
        return Colors.amber;
      }
    } else {
      //odd columns
      if (rowIndex % 2 != 0) {
        return Colors.amber;
      }
    }
    return Colors.blue;
  }

  Color getBoxColor(ChessState state, int col, int row) {
    if (state is ChessInitialState) {
      return getDefaultBoxColor(col, row);
    }
    if (state is CharacterClickedState) {
      if (state.moveOptions.onGoingBoxes.isNotEmpty) {
        for (var box in state.moveOptions.onGoingBoxes) {
          if (box.isInCoordinate(col, row)) {
            return Colors.purple;
          }
        }
      }
      if (state.moveOptions.onShotingBoxes.isNotEmpty) {
        for (var box in state.moveOptions.onShotingBoxes) {
          if (box.isInCoordinate(col, row)) {
            return Colors.red;
          }
        }
      }
      if (state.moveOptions.clickedBox.isInCoordinate(col, row)) {
        return Colors.pink;
      }
    }
    return getDefaultBoxColor(col, row);
  }

  Gradient? getBoxGradient(ChessState state, int col, int row) {
    if (state is ChessInitialState) {
      return null;
    }
    if (state is CharacterClickedState) {
      if (state.moveOptions.onGoingBoxes.isNotEmpty) {
        for (var box in state.moveOptions.onGoingBoxes) {
          if (box.isInCoordinate(col, row)) {
            return const RadialGradient(
              colors: [Colors.yellow, Colors.deepPurple],
              center: Alignment.center,
            );
          }
        }
      }

      if (state.moveOptions.onShotingBoxes.isNotEmpty) {
        for (var box in state.moveOptions.onShotingBoxes) {
          if (box.isInCoordinate(col, row)) {
            return const RadialGradient(
              colors: [Colors.yellow, Colors.red],
              center: Alignment.center,
            );
          }
        }
      }

      if (state.moveOptions.clickedBox.isInCoordinate(col, row)) {
        return const RadialGradient(
          colors: [Colors.blue, Colors.deepPurple],
          center: Alignment.center,
        );
      }
      if (state.isKingInCheck && state.kingBox.isInCoordinate(col, row)) {
        return const RadialGradient(
          colors: [Colors.yellow, Colors.red],
          center: Alignment.center,
        );
      }
    }
    if (state is CharacterMovedState) {
      if (state.isKingInCheck && state.kingBox.isInCoordinate(col, row)) {
        return const RadialGradient(
          colors: [Colors.yellow, Colors.red],
          center: Alignment.center,
        );
      }
    }
    return null;
  }

  Widget getChessChar(int col, int row) {
    late SuperChessCharacter c;
    // c = ChessBoard().getcharacter(col, row);
    // if (c is ChessCharacterNone) {
    //   //an empty box
    //   return const SizedBox();
    // } else {
    //   return SvgPicture.asset(
    //     c.photoId,
    //     color: Colors.white,
    //     // // fit: BoxFit.fill,
    //   );
    // }
    //whites
    c = PlayerWhite().getCharacter(col, row);
    if (c is! ChessCharacterNone) {
      return SvgPicture.asset(
        c.photoId,
        color: Colors.white,
        // fit: BoxFit.fill,
      );
    }

    //blacks
    c = PlayerBlack().getCharacter(col, row);

    if (c is! ChessCharacterNone) {
      return SvgPicture.asset(
        c.photoId,
        color: Colors.black,
        // fit: BoxFit.fill,
      );
    } else {
      //an empty box
      return const SizedBox();
    }
  }

  void setBoard(int col, int row) {
    //form board
    late SuperChessCharacter c;
    //whites
    c = PlayerWhite().getCharacter(col, row);
    if (c is! ChessCharacterNone) {
      // singleChar[row] = c;
    } else {
      //blacks
      c = PlayerBlack().getCharacter(col, row);
      if (c is! ChessCharacterNone) {
        // singleChar[row] = c;
      }
    }

    if (c is! ChessCharacterNone) {
      ChessBoard().addToBoardMap(col, row, c);
    }
    // print(ChessBoard().boardMap);
  }

  @override
  void initState() {
    PlayerWhite().initialize();
    PlayerBlack().initialize();
    super.initState();
  }

  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    print(size.shortestSide);
    squareLength = size.shortestSide;

    // SuperChessCharacter p = ChessCharacterPawn(ConstantImages.svgBlackPawn);
    // SuperChessCharacter pp =
    //     ChessCharacterBishop(ConstantImages.svgBlackBishop);

    // PlayerWhite playerWhite = PlayerWhite.initialize();
    // print(playerWhite.pawns.pawn1.columnNumber);
    // var pa = PlayerWhite.initialize();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(
      //     child: CWText(
      //       "..C.H.E.S.S..",
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20,
      //     ),
      //   ),
      // ),
      body: Center(
        child: CWContainer(
          h: squareLength,
          w: squareLength,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int columnNumber = 1; columnNumber <= 8; columnNumber++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int rowNumber = 1; rowNumber <= 8; rowNumber++)
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            if (ChessBoard()
                                .hasCharacterAt(columnNumber, rowNumber)) {
                              // ChessBoard().getcharacter(columnNumber, rowNumber);
                              context
                                  .read<ChessCubit>()
                                  .characterClicked(columnNumber, rowNumber);
                            } else {
                              context
                                  .read<ChessCubit>()
                                  .boxClicked(columnNumber, rowNumber);
                            }
                          },
                          child: BlocBuilder<ChessCubit, ChessState>(
                              builder: (context, state) {
                            // setBoard(columnNumber, rowNumber);
                            if (columnNumber == 8 && rowNumber == 8) {
                              ChessBoard().createMap();
                            }
                            return CWContainer(
                                color:
                                    getDefaultBoxColor(columnNumber, rowNumber),
                                w: squareLength / 9,
                                h: squareLength / 9,
                                gradient: getBoxGradient(
                                    state, columnNumber, rowNumber),
                                pad: const [5, 10, 5, 10],
                                // shape: BoxShape.circle,
                                child: getChessChar(columnNumber, rowNumber));
                          }),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
