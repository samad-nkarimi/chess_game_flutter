import 'dart:math';

import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/common_widgets/cw_loading_widget.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/feature/auth/screen/auth_screen.dart';
import 'package:chess_flutter/feature/players/bloc/user_cubit.dart';
import 'package:chess_flutter/feature/players/bloc/user_state.dart';
import 'package:chess_flutter/feature/players/widget/user_search_field.dart';
import 'package:chess_flutter/models/user.dart';
import 'package:chess_flutter/repository/user_repo_impl.dart';
import 'package:chess_flutter/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayersScreen extends StatefulWidget {
  static const routeName = "/players_screen";
  const PlayersScreen({Key? key}) : super(key: key);

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
        preferredSize: const Size(double.infinity, 60),
        child: CWContainer(
          h: 60,
          w: double.infinity,
          pad: const [5, 20, 5, 20],
          color: Colors.green,
          child: Row(
            children: [
              const Flexible(
                flex: 10,
                child: UserSearchField(),
              ),
              Flexible(
                flex: 3,
                child: Center(
                  child: CWElevatedButton(
                    onPressed: () async {
                      users = await UserRepoImpl(UserService()).getUsers();
                      setState(() {});
                    },
                    child: const CWText("fetch all"),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Center(
                  child: CWElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, AuthScreen.routeName);
                    },
                    child: const CWText("register"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<UserCubit, UserState>(listener: (context, state) {
        if (state is SearchingUserState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (c) {
              return const CWLoadingWidget();
            },
          );
        } else if (state is ErrorUserState) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return CWContainer(
          h: double.infinity,
          w: double.infinity,
          color: Colors.blueGrey,
          child: SingleChildScrollView(
              child: GridView.builder(
            itemCount: state.users.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: max(1, MediaQuery.of(context).size.width ~/ 300),
              childAspectRatio: 5,
            ),
            itemBuilder: (context, index) {
              return CWContainer(
                h: 50,
                mar: const [1, 10, 1, 10],
                pad: const [5, 20, 5, 20],
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
        );
      }),
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
