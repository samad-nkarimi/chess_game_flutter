import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/feature/chess/screen/chess_screen.dart';
import 'package:chess_flutter/feature/home/bloc/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/cw_container.dart';
import '../../../common_widgets/cw_text.dart';
import '../../../domain/entity/remote_play_entity.dart';

class RemotePlayItemWidget extends StatelessWidget {
  final RemotePlayEntity remotePlay;
  const RemotePlayItemWidget({Key? key, required this.remotePlay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChessScreen.routeName, arguments: true);
      },
      child: CWContainer(
        w: double.infinity,
        mar: const [5, 5, 5, 5],
        brAll: 5,
        color: Colors.black38,
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
                color: Colors.green,
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
}
