import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/feature/chess/screen/chess_screen.dart';
import 'package:chess_flutter/feature/home/bloc/home_cubit.dart';
import 'package:chess_flutter/models/enums/remote_play_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/cw_container.dart';
import '../../../common_widgets/cw_text.dart';
import '../../../domain/entity/remote_play_entity.dart';

class ChessArguments {
  final bool isOnline;
  final RemotePlayEntity entity;

  ChessArguments(this.isOnline, this.entity);
}

class RemotePlayItemWidget extends StatelessWidget {
  final RemotePlayEntity remotePlay;
  const RemotePlayItemWidget({Key? key, required this.remotePlay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (remotePlay.status) {
          case RemotePlayStatus.active:
          case RemotePlayStatus.cancelled:
          case RemotePlayStatus.finished:
            Navigator.pushNamed(context, ChessScreen.routeName,
                arguments: ChessArguments(true, remotePlay));
            break;
          default:
        }
      },
      child: CWContainer(
        w: double.infinity,
        mar: const [5, 5, 5, 5],
        brAll: 5,
        color: Colors.white70,
        child: ClipRRect(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CWContainer(
                      h: 50,
                      color: Colors.black12,
                      al: Alignment.center,
                      br: [5, 5, 0, 0],
                      child: Column(
                        children: [
                          CWText(
                            remotePlay.targetUsername,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          CWText(
                            remotePlay.targetScore,
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CWContainer(
                    h: 50,
                    w: 30,
                    color: Colors.black12,
                    child: CWElevatedButton(
                      onPressed: () {
                        BlocProvider.of<HomeCubit>(context)
                            .deleteRemotePlay(remotePlay.targetUsername);
                      },
                      primary: Colors.red,
                      bRadius: 5,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              CWContainer(
                h: 30,
                br: [0, 0, 5, 5],
                color: getStatusColor(remotePlay.status),
                al: Alignment.center,
                child: CWText(
                  remotePlay.status.name,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getStatusColor(RemotePlayStatus status) {
    switch (status) {
      case RemotePlayStatus.active:
        return Colors.green;
      case RemotePlayStatus.wating:
        return Colors.orange;
      case RemotePlayStatus.finished:
        return Colors.blue;
      case RemotePlayStatus.cancelled:
        return Colors.yellow;
      case RemotePlayStatus.rejected:
        return Colors.red;

      default:
        return Colors.orange;
    }
  }
}
