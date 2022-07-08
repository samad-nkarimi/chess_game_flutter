import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/cw_container.dart';
import '../../../common_widgets/cw_elevated_button.dart';
import '../../../common_widgets/cw_text.dart';
import '../../../service_locator.dart';
import '../bloc/user_cubit.dart';

class PlayerItemWidget extends StatelessWidget {
  final String username;
  final String score;
  const PlayerItemWidget(
      {Key? key, required this.username, required this.score})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CWContainer(
      h: 50,
      mar: const [1, 10, 1, 10],
      pad: const [5, 20, 5, 20],
      w: double.infinity,
      brAll: 5,
      color: Colors.amber.shade700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CWText(
                "name: $username",
                color: Colors.white,
                fontSize: 18,
              ),
              CWText(
                "score: $score",
                color: Colors.white60,
                fontSize: 14,
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          CWElevatedButton(
            onPressed: () {
              BlocProvider.of<UserCubit>(context).sendPlayRequestTo(
                ServiceLocator().username,
                username,
                score,
              );
            },
            vPadding: 20,
            hPadding: 20,
            bRadius: 5,
            primary: Colors.green,
            onPrimary: Colors.white,
            child: const CWText(
              "request",
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
