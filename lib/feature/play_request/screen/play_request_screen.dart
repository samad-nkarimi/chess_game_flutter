import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/feature/play_request/bloc/play_request_cubit.dart';
import 'package:chess_flutter/feature/play_request/bloc/play_request_state.dart';
import 'package:chess_flutter/models/play_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayRequestScreen extends StatefulWidget {
  static const routeName = "/request_plays_screen";
  const PlayRequestScreen({Key? key}) : super(key: key);

  @override
  State<PlayRequestScreen> createState() => _PlayRequestScreenState();
}

class _PlayRequestScreenState extends State<PlayRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CWText("requests")),
      body: BlocBuilder<PlayRequestCubit, PlayRequestState>(
        buildWhen: (previous, current) {
          return true;
        },
        builder: (context, state) {
          List<PlayRequest> requests = [];
          if (state is PlayRequestsListState) {
            requests = state.remotePlayRequest;
          }
          if (state is InitialPlayRequestState) {
            BlocProvider.of<PlayRequestCubit>(context).init();
          }
          return CWContainer(
            pad: const [10, 0, 10, 0],
            child: ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                return requestPlayItem(requests[index].username);
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
      mar: const [2, 15, 2, 15],
      pad: const [2, 15, 2, 15],
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
                BlocProvider.of<PlayRequestCubit>(context)
                    .acceptRemotePlayRequest(username);
                //TODO
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
                BlocProvider.of<PlayRequestCubit>(context)
                    .rejectRemotePlayRequest(username);
                //TODO
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
