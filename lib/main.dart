import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/feature/home/bloc/chess/chess_cubit.dart';
import 'package:chess_flutter/feature/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'feature/players/screen/players_screen.dart';

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
      // home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/0": (context) => const HomeScreen(),
        "/": (context) => PlayersScreen(),
      },
    );
  }
}
