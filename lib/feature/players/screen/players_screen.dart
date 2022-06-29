import 'dart:math';

import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/feature/players/widget/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayersScreen extends StatelessWidget {
  static const routeName = "/players_screen";
  const PlayersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: PreferredSize(
          child: CWContainer(
            h: 60,
            w: double.infinity,
            pad: [5, 20, 5, 20],
            color: Colors.green,
            child: Row(
              children: [
                Flexible(
                  flex: 10,
                  child: CustomInputField(),
                ),
                Flexible(
                  flex: 3,
                  child: Center(
                    child: CWElevatedButton(
                      onPressed: () {},
                      child: CWText("fetch all"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size(double.infinity, 60)),
      body: CWContainer(
        h: double.infinity,
        w: double.infinity,
        color: Colors.blueGrey,
        child: SingleChildScrollView(
            child: GridView.builder(
          itemCount: 50,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: max(1, MediaQuery.of(context).size.width ~/ 300),
            childAspectRatio: 5,
          ),
          itemBuilder: (context, index) {
            return CWContainer(
              h: 50,
              mar: [1, 10, 1, 10],
              pad: [5, 20, 5, 20],
              w: double.infinity,
              brAll: 5,
              color: Colors.white24,
              child: Text(index.toString()),
            );
          },
        )),
      ),
    );
  }
}


//  ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             itemCount: 20,
//             padding: EdgeInsets.symmetric(vertical: 10),
//             itemBuilder: (context, index) {
//               return CWContainer(
//                 h: 50,
//                 mar: [1, 10, 1, 10],
//                 w: double.infinity,
//                 brAll: 5,
//                 color: Colors.white24,
//               );
//             },
//           ),
