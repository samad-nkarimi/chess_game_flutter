import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/feature/players/widget/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayersScreen extends StatelessWidget {
  static const routeName = "/players_screen";
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CWContainer(
        h: double.infinity,
        w: double.infinity,
        color: Colors.blueGrey,
        child: Column(
          children: [
            CWContainer(
              h: 60,
              w: double.infinity,
              pad: [5, 20, 5, 20],
              color: Colors.green,
              child: CustomInputField(),
            )
          ],
        ),
      ),
    );
  }
}
