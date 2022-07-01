import 'dart:math' as math;
import 'dart:ui';
import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/feature/chess/bloc/chess/chess_cubit.dart';
import 'package:chess_flutter/feature/chess/bloc/chess/chess_state.dart';

import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/chess_character.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/chess_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChessScreen extends StatefulWidget {
  static const routeName = "/chess_screen";
  const ChessScreen({Key? key}) : super(key: key);

  @override
  State<ChessScreen> createState() => _ChessScreenState();
}

class _ChessScreenState extends State<ChessScreen> {
  double squareLength = 350; // min(width , height)

  //white and black colors
  Color getBackgroundBoxColor(int columnIndex, int rowIndex) {
    // even columns
    if (columnIndex % 2 == 0) {
      if (rowIndex % 2 == 0) {
        return Color.fromARGB(255, 118, 236, 191);
      }
    }
    //odd columns
    else {
      if (rowIndex % 2 != 0) {
        return const Color.fromARGB(255, 118, 236, 191);
      }
    }
    return Color.fromARGB(255, 110, 6, 6);
  }

  // Color getBoxColor(ChessState state, int col, int row) {
  //   if (state is ChessInitialState) {
  //     return getBackgroundBoxColor(col, row);
  //   }
  //   if (state is CharacterClickedState) {
  //     if (state.moveOptions.onGoingBoxes.isNotEmpty) {
  //       for (var box in state.moveOptions.onGoingBoxes) {
  //         if (box.isInCoordinate(col, row)) {
  //           return Colors.purple;
  //         }
  //       }
  //     }
  //     if (state.moveOptions.onShotingBoxes.isNotEmpty) {
  //       for (var box in state.moveOptions.onShotingBoxes) {
  //         if (box.isInCoordinate(col, row)) {
  //           return Colors.red;
  //         }
  //       }
  //     }
  //     if (state.moveOptions.clickedBox.isInCoordinate(col, row)) {
  //       return Colors.pink;
  //     }
  //   }
  //   return getBackgroundBoxColor(col, row);
  // }

  //the color based on character moves
  Gradient? getBoxGradient(ChessState state, int col, int row) {
    //no color yet
    if (state is ChessInitialState) {
      return null;
    }
    if (state is CharacterClickedState) {
      //ongoing boxes
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

      //onShotting boxes
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

      //clicked character
      if (state.moveOptions.clickedBox.isInCoordinate(col, row)) {
        return const RadialGradient(
          colors: [Colors.blue, Colors.deepPurple],
          center: Alignment.center,
        );
      }

      //king if is in check
      if (state.isKingInCheck && state.kingBox.isInCoordinate(col, row)) {
        return const RadialGradient(
          colors: [
            Color.fromARGB(255, 250, 103, 255),
            Color.fromARGB(255, 219, 22, 8)
          ],
          center: Alignment.center,
        );
      }
    }
    if (state is CharacterMovedState) {
      //king if is in check
      if (state.isKingInCheck && state.kingBox.isInCoordinate(col, row)) {
        return const RadialGradient(
          colors: [
            Color.fromARGB(255, 250, 103, 255),
            Color.fromARGB(255, 219, 22, 8)
          ],
          center: Alignment.center,
        );
      }
      //the box, character moved from
      if (state.moveFrom.isInCoordinate(col, row)) {
        return const RadialGradient(
          colors: [
            Color.fromARGB(255, 50, 170, 240),
            Color.fromARGB(255, 50, 170, 240),
            // Color.fromARGB(120, 231, 255, 92)
          ],
          center: Alignment.center,
        );
      }
      //the box, character moved to
      if (state.moveTo.isInCoordinate(col, row)) {
        return const RadialGradient(
          colors: [
            Color.fromARGB(255, 50, 170, 240),
            Color.fromARGB(255, 50, 170, 240),
            // Color.fromARGB(115, 231, 255, 92)
          ],
          center: Alignment.center,
        );
      }
    }

    //a regular box
    return null;
  }

  Widget getChessChar(int col, int row) {
    ChessCharacter c = ChessBoard().getcharacter(col, row);
    print(c);
    if (c.isNone) {
      //an empty box
      return const SizedBox();
    } else {
      return SvgPicture.asset(c.photoId,
          color: c.player == Player.white ? Colors.white : Colors.amber
          // // fit: BoxFit.fill,
          );
    }
    // //whites
    // c = PlayerWhite().getCharacter(col, row);
    // if (c is! ChessCharacterNone) {
    //   return SvgPicture.asset(
    //     c.photoId,
    //     color: Colors.white,
    //     // fit: BoxFit.fill,
    //   );
    // }

    // //blacks
    // c = PlayerBlack().getCharacter(col, row);

    // if (c is! ChessCharacterNone) {
    //   return SvgPicture.asset(
    //     c.photoId,
    //     color: Colors.black,
    //     // fit: BoxFit.fill,
    //   );
    // } else {
    //   //an empty box
    //   return const SizedBox();
    // }
  }

  // void setBoard(int col, int row) {
  //   //form board
  //   late SuperChessCharacter c;
  //   //whites
  //   c = PlayerWhite().getCharacter(col, row);
  //   if (c is! ChessCharacterNone) {
  //     // singleChar[row] = c;
  //   } else {
  //     //blacks
  //     c = PlayerBlack().getCharacter(col, row);
  //     if (c is! ChessCharacterNone) {
  //       // singleChar[row] = c;
  //     }
  //   }

  //   if (c is! ChessCharacterNone) {
  //     ChessBoard().addToBoardMap(col, row, c);
  //   }
  // }

  Widget outCharsWidget(Player player) {
    return BlocBuilder<ChessCubit, ChessState>(
      buildWhen: (previous, current) {
        if (current is CharacterShottedState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is CharacterShottedState) {
          List<ChessCharacter> outChars = state.outCharsBlack;
          Color color = Colors.black;
          if (player == Player.white) {
            outChars = state.outCharsWhite;
            color = Colors.white;
          }

          return CWContainer(
            w: squareLength,
            h: 80,
            // mar: const [50, 0, 50, 0],
            color: Colors.grey,
            child: Column(
              children: [
                for (int j = 0; j <= outChars.length ~/ 8; j++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0;
                          i < math.min(outChars.length - j * 8, 8);
                          i++)
                        CWContainer(
                          w: squareLength / 12,
                          h: squareLength / 12,
                          child: SvgPicture.asset(
                            outChars[j * 8 + i].photoId,
                            color: color,
                            // fit: BoxFit.fill,
                          ),
                        )
                    ],
                  ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  void initState() {
    PlayerWhite().initialize();
    PlayerBlack().initialize();
    // PlayerWhite().testinitialize();
    // PlayerBlack().testinitialize();

    super.initState();
  }

  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    squareLength = size.shortestSide - 20;

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
      body: Stack(
        children: [
          // for (int i = 0; i < 30; i++)
          //   for (int j = 0; j < 15; j++)
          //     Container(
          //       height: 50,
          //       width: 50,
          //       margin: EdgeInsets.only(left: 50.0 * i, top: 50.0 * j),
          //       child: SvgPicture.asset(
          //         "assets/images/svg/bg_pattern.svg",
          //         height: 50,
          //         width: 50,
          //       ),
          //     ),
          Container(
            color: Colors.white10,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // outCharsWidget(Player.white),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // outCharsWidget(Player.white),
                      // outCharsWidget(Player.black),
                      BlocBuilder<ChessCubit, ChessState>(
                        buildWhen: (previous, current) {
                          if (current is! CharacterShottedState) {
                            return true;
                          }
                          return false;
                        },
                        builder: (context, state) {
                          // setBoard(columnNumber, rowNumber);

                          ChessBoard().createMap();

                          if (state is PlayerWonState) {
                            print("winner ==> ${state.winner}");
                          }
                          return CWContainer(
                            color: Color.fromARGB(255, 177, 145, 5),
                            h: squareLength,
                            w: squareLength,
                            mar: const [10, 10, 10, 10],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int columnNumber = 1;
                                    columnNumber <= 8;
                                    columnNumber++)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (int rowNumber = 1;
                                          rowNumber <= 8;
                                          rowNumber++)
                                        Flexible(
                                          flex: 1,
                                          child: InkWell(
                                            onTap: () {
                                              if (ChessBoard().hasCharacterAt(
                                                  columnNumber, rowNumber)) {
                                                context
                                                    .read<ChessCubit>()
                                                    .characterClicked(
                                                        columnNumber,
                                                        rowNumber);
                                              } else {
                                                context
                                                    .read<ChessCubit>()
                                                    .boxClicked(columnNumber,
                                                        rowNumber);
                                              }
                                            },
                                            child: ClipRRect(
                                              clipBehavior: Clip.antiAlias,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 0.2,
                                                  sigmaY: 0.2,
                                                  tileMode: TileMode.mirror,
                                                ),
                                                child: ClipRRect(
                                                  clipBehavior: Clip.antiAlias,
                                                  child: CWContainer(
                                                      color: getBackgroundBoxColor(
                                                          columnNumber,
                                                          rowNumber),
                                                      blendMode:
                                                          BlendMode.difference,
                                                      brAll: 10,
                                                      // brWidth: 1,
                                                      // brColor: Colors.white,
                                                      // mar: [1, 1, 1, 1],
                                                      w: squareLength / 8.3,
                                                      h: squareLength / 8.3,
                                                      gradient: getBoxGradient(
                                                          state,
                                                          columnNumber,
                                                          rowNumber),
                                                      pad: const [5, 5, 5, 5],
                                                      // shape: BoxShape.circle,
                                                      child: getChessChar(
                                                          columnNumber,
                                                          rowNumber)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  // outCharsWidget(Player.black),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
