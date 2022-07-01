import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/feature/home/screen/home_screen.dart';
import 'package:chess_flutter/feature/players/screen/players_screen.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  static const routeName = "/bottom_nav_screen";
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedIndex == 0 ? const HomeScreen() : const PlayersScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: const CWContainer(
                h: 50,
                br: [30, 30, 0, 0],
                color: Colors.green,
                al: Alignment.center,
                child: CWText(
                  "home",
                  color: Colors.white,
                  fontSize: 22,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: const CWContainer(
                h: 50,
                br: [30, 30, 0, 0],
                color: Colors.orange,
                al: Alignment.center,
                child: CWText(
                  "users",
                  color: Colors.white,
                  fontSize: 22,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
