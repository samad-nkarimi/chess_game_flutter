import 'dart:io';

import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/constants/constant_images.dart';
import 'package:chess_flutter/feature/chess/bloc/chess/chess_cubit.dart';
import 'package:chess_flutter/feature/chess/bloc/chess/chess_state.dart';
import 'package:chess_flutter/models/enums/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common_widgets/cw_container.dart';

class CompetitetitleWidget extends StatelessWidget {
  final String myUsername;
  final String competitorUsername;
  const CompetitetitleWidget({
    Key? key,
    required this.myUsername,
    required this.competitorUsername,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWContainer(
      h: 70,
      w: 300,
      pad: const [5, 15, 5, 15],
      color: Colors.amber,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                SvgPicture.asset(
                  ConstantImages.svgWhitePawn,
                  color: Colors.black,
                  width: 30,
                  height: 30,
                ),
                CWText(competitorUsername),
              ],
            ),
          ),
          BlocBuilder<ChessCubit, ChessState>(
            buildWhen: (previous, current) {
              if (current is PlayerTurnedState) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              Player playerTurn = Player.white;
              if (state is PlayerTurnedState) {
                playerTurn = state.playerTurn;
              }
              return CWContainer(
                w: 30,
                h: 30,
                color:
                    playerTurn == Player.white ? Colors.white : Colors.black54,
                brAll: 50,
                brColor: Colors.green,
                brWidth: 3,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                CWText(myUsername),
                SvgPicture.asset(
                  ConstantImages.svgWhitePawn,
                  color: Colors.white,
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
