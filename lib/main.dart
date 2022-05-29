import 'dart:math' as math;

import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/constants/constant_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
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

  Color getBoxColor(int columnIndex, int rowIndex) {
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
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
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
              for (int columnIndex = 0; columnIndex < 8; columnIndex++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int rowIndex = 0; rowIndex < 8; rowIndex++)
                      Flexible(
                        flex: 1,
                        child: CWContainer(
                          color: getBoxColor(columnIndex, rowIndex),
                          w: squareLength / 9,
                          h: squareLength / 9,
                          pad: const [5, 5, 5, 5],
                          // shape: BoxShape.circle,
                          child: SvgPicture.asset(
                            svgWhitePawn,
                            color: Colors.white,
                          ),
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
