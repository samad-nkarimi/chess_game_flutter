import 'package:chess_flutter/blocs/chess/chess_bloc.dart';
import 'package:chess_flutter/blocs/chess/chess_state.dart';
import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/constants/constant_images.dart';
import 'package:chess_flutter/models/characters/abstract_character.dart';
import 'package:chess_flutter/models/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ChessCubit()),
          ],
          child: const MyApp(),
        ),
      );
    },
    // blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'let\'s play chess',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final double squareLength = 350; // min(width , height)
  late final PlayerWhite playerWhite;
  late final PlayerBlack playerBlack;

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
      if (state.onGoingBoxes.isNotEmpty) {
        for (var box in state.onGoingBoxes) {
          if (box.isInCoordinate(col, row)) {
            return Colors.purple;
          }
        }
      }
      if (state.onShotingBoxes.isNotEmpty) {
        for (var box in state.onShotingBoxes) {
          if (box.isInCoordinate(col, row)) {
            return Colors.red;
          }
        }
      }
      if (state.clickedBox.isInCoordinate(col, row)) {
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
      if (state.onGoingBoxes.isNotEmpty) {
        for (var box in state.onGoingBoxes) {
          if (box.isInCoordinate(col, row)) {
            return const RadialGradient(
              colors: [Colors.yellow, Colors.deepPurple],
              center: Alignment.center,
            );
          }
        }
      }
      if (state.onShotingBoxes.isNotEmpty) {
        for (var box in state.onShotingBoxes) {
          if (box.isInCoordinate(col, row)) {
            return const RadialGradient(
              colors: [Colors.yellow, Colors.red],
              center: Alignment.center,
            );
          }
        }
      }
      if (state.clickedBox.isInCoordinate(col, row)) {
        return const RadialGradient(
          colors: [Colors.blue, Colors.deepPurple],
          center: Alignment.center,
        );
      }
    }
    return null;
  }

  Widget getChessChar(int col, int row) {
    late var c;
    //whites
    c = playerWhite.getCharacter(col, row);
    if (c is! ChessCharacterNone) {
      return SvgPicture.asset(
        c.photoId,
        color: Colors.white,
        fit: BoxFit.fill,
      );
    }

    //blacks
    c = playerBlack.getCharacter(col, row);

    if (c is! ChessCharacterNone) {
      return SvgPicture.asset(
        c.photoId,
        color: Colors.black,
        fit: BoxFit.fill,
      );
    } else {
      //an empty box
      return const SizedBox();
    }
  }

  @override
  void initState() {
    playerWhite = PlayerWhite.initialize();
    playerBlack = PlayerBlack.initialize();
    super.initState();
  }

  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    SuperChessCharacter p = ChessCharacterPawn(ConstantImages.svgBlackPawn);
    SuperChessCharacter pp =
        ChessCharacterBishop(ConstantImages.svgBlackBishop);

    // PlayerWhite playerWhite = PlayerWhite.initialize();
    // print(playerWhite.pawns.pawn1.columnNumber);
    // var pa = PlayerWhite.initialize();

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
                            context
                                .read<ChessCubit>()
                                .characterClicked(columnNumber, rowNumber);
                          },
                          child: BlocBuilder<ChessCubit, ChessState>(
                              builder: (context, state) {
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
