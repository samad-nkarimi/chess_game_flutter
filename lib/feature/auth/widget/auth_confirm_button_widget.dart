import 'package:chess_flutter/feature/auth/bloc/auth_cubit.dart';
import 'package:chess_flutter/models/enums/auth_type.dart';
import 'package:chess_flutter/models/register_credential.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/cw_elevated_button.dart';

class AuthConfirmButtonWidget extends StatefulWidget {
  final AuthType authType;
  final bool isFormValid;
  final RegisterCredential registerCredential;
  const AuthConfirmButtonWidget({
    Key? key,
    this.authType = AuthType.signup,
    required this.isFormValid,
    required this.registerCredential,
  }) : super(key: key);

  @override
  State<AuthConfirmButtonWidget> createState() =>
      _AuthConfirmButtonWidgetState();
}

class _AuthConfirmButtonWidgetState extends State<AuthConfirmButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return CWElevatedButton(
      primary: Colors.green,
      onPrimary: Colors.white,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(50),
      // ),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Text(widget.authType.name),
      ),
      onPressed: () async {
        print("start...");

        if (widget.isFormValid) {
          print("form is validate");
          BlocProvider.of<AuthCubit>(context)
              .register(widget.registerCredential);

          // .add(ConfirmButtonPressedEvent(
          //   AuthCredentials(
          //     username: emailWrapper.value,
          //     email: emailWrapper.value,
          //     password: passwordWrapper.value,
          //     authType: widget.authType,
          //   ),
          // ));
          print("sent to bloc");
        } else {
          //tell bloc the errors
          print("form is not validate");
        }
      },
    );
  }

  Future showAlertDialog(String response) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Center(child: Text("error")),
          content: Text(
            response,
          ),
          actions: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context)
                        .authTypePressedEvent(AuthType.login);
                    Navigator.pop(ctx);
                  },
                  child: const Text("login"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("sign up"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
