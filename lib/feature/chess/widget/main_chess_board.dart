import 'dart:ui';

import 'package:chess_flutter/feature/chess/bloc/chess/chess_cubit.dart';
import 'package:chess_flutter/feature/chess/bloc/chess/chess_state.dart';
import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/chess_character.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common_widgets/cw_container.dart';

class MainChessBoard extends StatelessWidget {
  final ChessState chessState;
  final double squareLength;
  final Player playerTurn;
  final bool isOnline;
  const MainChessBoard({
    Key? key,
    required this.chessState,
    required this.squareLength,
    required this.playerTurn,
    required this.isOnline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWContainer(
      color: const Color.fromARGB(255, 177, 145, 5),
      h: squareLength,
      w: squareLength,
      mar: const [10, 10, 10, 10],
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
                        if (playerTurn != Player.white) {
                          return;
                        }
                        if (ChessBoard()
                            .hasCharacterAt(columnNumber, rowNumber)) {
                          context.read<ChessCubit>().characterClicked(
                              columnNumber, rowNumber, false, isOnline);
                        } else {
                          context.read<ChessCubit>().boxClicked(
                              columnNumber, rowNumber, false, isOnline);
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
                                    columnNumber, rowNumber),
                                blendMode: BlendMode.difference,
                                brAll: 10,
                                // brWidth: 1,
                                // brColor: Colors.white,
                                // mar: [1, 1, 1, 1],
                                w: squareLength / 8.3,
                                h: squareLength / 8.3,
                                gradient: getBoxGradient(
                                    chessState, columnNumber, rowNumber),
                                pad: const [5, 5, 5, 5],
                                // shape: BoxShape.circle,
                                child: getChessChar(columnNumber, rowNumber)),
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
  }

  Widget getChessChar(int col, int row) {
    ChessCharacter c = ChessBoard().getcharacter(col, row);
    // print(c);
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

  //white and black colors
  Color getBackgroundBoxColor(int columnIndex, int rowIndex) {
    // even columns
    if (columnIndex % 2 == 0) {
      if (rowIndex % 2 == 0) {
        return const Color.fromARGB(255, 118, 236, 191);
      }
    }
    //odd columns
    else {
      if (rowIndex % 2 != 0) {
        return const Color.fromARGB(255, 118, 236, 191);
      }
    }
    return const Color.fromARGB(255, 110, 6, 6);
  }

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
}
