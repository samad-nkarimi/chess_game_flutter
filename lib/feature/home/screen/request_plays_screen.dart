import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/feature/home/bloc/home_cubit.dart';
import 'package:chess_flutter/feature/home/bloc/home_state.dart';
import 'package:chess_flutter/feature/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestPlaysScreen extends StatefulWidget {
  static const routeName = "/request_plays_screen";
  const RequestPlaysScreen({Key? key}) : super(key: key);

  @override
  State<RequestPlaysScreen> createState() => _RequestPlaysScreenState();
}

class _RequestPlaysScreenState extends State<RequestPlaysScreen> {
  List<String> requestPlays = [
    "samad",
    "maria",
    "hassan",
    "pizza",
    "hamburger"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CWText("requests")),
      body: BlocBuilder<HomeCubit, HomeState>(
        
        buildWhen: (previous, current) {
          if (current is PlayRequestsHomeState) {
            return true;
          }

          return false;
        },
        builder: (context, state) {
          print(state);
          List<String> requests = [];
          if (state is PlayRequestsHomeState) {
            requests = state.remotePlayRequest;
          } 
          return CWContainer(
            pad: const [10, 0, 10, 0],
            child: ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return requestPlayItem(requests[index]);
              },
            ),
          );
        },
      ),
    );
  }

  Widget requestPlayItem(String username) {
    return CWContainer(
      h: 60,
      w: double.infinity,
      mar: [2, 15, 2, 15],
      pad: [2, 15, 2, 15],
      brAll: 5,
      al: Alignment.centerLeft,
      brColor: Colors.orange.shade800,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CWText(
                username,
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              const CWText(
                "time: 12/12/4",
                fontSize: 10,
                color: Colors.black45,
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CWElevatedButton(
              onPressed: () {
                BlocProvider.of<HomeCubit>(context).acceptRemotePlay(username);
                //TODO
                setState(() {
                  requestPlays.remove(username);
                });
              },
              primary: Colors.green,
              bRadius: 5,
              child: const CWText(
                "accept",
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CWElevatedButton(
              onPressed: () {
                BlocProvider.of<HomeCubit>(context).rejectRemotePlay(username);
                //TODO
                setState(() {
                  requestPlays.remove(username);
                });
              },
              primary: Colors.orange,
              bRadius: 5,
              child: const CWText(
                "rejects",
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
