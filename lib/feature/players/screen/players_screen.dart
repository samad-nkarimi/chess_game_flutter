import 'dart:math';

import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/feature/players/widget/custom_input_field.dart';
import 'package:chess_flutter/models/user.dart';
import 'package:chess_flutter/repository/user_repo_impl.dart';
import 'package:chess_flutter/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayersScreen extends StatefulWidget {
  static const routeName = "/players_screen";
  PlayersScreen({Key? key}) : super(key: key);

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  List<User> users = [];

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
                      onPressed: () async {
                        users = await UserRepoImpl(UserService()).getUsers();
                        setState(() {});
                      },
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
          itemCount: users.length,
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
              child: Column(
                children: [
                  Text(users[index].name),
                  Text(users[index].score),
                ],
              ),
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
