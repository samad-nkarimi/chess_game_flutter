import 'dart:math' as math;
import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/domain/use_case/remote_play_move_use_case.dart';
import 'package:chess_flutter/feature/chess/bloc/chess/chess_cubit.dart';
import 'package:chess_flutter/feature/chess/bloc/chess/chess_state.dart';
import 'package:chess_flutter/feature/chess/widget/main_chess_board.dart';
import 'package:chess_flutter/feature/home/widget/remote_play_item_widget.dart';

import 'package:chess_flutter/models/chess_board.dart';
import 'package:chess_flutter/models/chess_character.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:chess_flutter/models/chess_player.dart';
import 'package:chess_flutter/models/enums/remote_play_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widget/competite_title_widget.dart';

class ChessScreen extends StatefulWidget {
  static const routeName = "/chess_screen";
  final RemotePlayMoveUseCase? usecase;

  const ChessScreen({
    Key? key,
    this.usecase,
  }) : super(key: key);

  @override
  State<ChessScreen> createState() => _ChessScreenState();
}

class _ChessScreenState extends State<ChessScreen> {
  double squareLength = 350; // min(width , height)
  Player playerTurn = Player.white;
  bool isOnline = false;
  RemotePlayEntity entity = RemotePlayEntity(
    "offline",
    "0",
    RemotePlayStatus.active,
    DateTime.now(),
    true,
  );

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

    print("www: ${PlayerWhite().getCharacter(1, 1)}");

    // PlayerWhite().testinitialize();
    // PlayerBlack().testinitialize();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      ChessArguments arguments =
          ModalRoute.of(context)!.settings.arguments as ChessArguments;
      isOnline = arguments.isOnline;
      entity = arguments.entity;
      print("online: $isOnline");
    } catch (e) {
      print(e);
    }
  }

  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    squareLength = size.shortestSide - 20;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: CWText(
            "..C.H.E.S.S..",
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ChessCubit(widget.usecase!)
          ..init(isOnline, entity.amIHost, entity.targetUsername),
        child: Stack(
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
                        CompetitetitleWidget(
                            myUsername: "my name",
                            competitorUsername: entity.targetUsername),
                        // outCharsWidget(Player.white),
                        // outCharsWidget(Player.black),
                        BlocBuilder<ChessCubit, ChessState>(
                          buildWhen: (previous, current) {
                            if (current is CharacterShottedState) {
                              return false;
                            }
                            if (current is PlayerTurnedState) {
                              return false;
                            }
                            return true;
                          },
                          builder: (context, state) {
                            // setBoard(columnNumber, rowNumber);

                            if (state is CharacterMovedState && isOnline) {
                              playerTurn = state.player == Player.white
                                  ? Player.black
                                  : Player.white;
                            }
                            print("state: $state");

                            ChessBoard().createMap();

                            if (state is PlayerWonState) {
                              print("winner ==> ${state.winner}");
                            }
                            return MainChessBoard(
                              chessState: state,
                              squareLength: squareLength,
                              playerTurn: playerTurn,
                              isOnline: isOnline,
                              amIHost: entity.amIHost,
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
      ),
    );
  }
}
