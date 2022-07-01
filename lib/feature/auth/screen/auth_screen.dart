import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/feature/auth/bloc/auth_cubit.dart';
import 'package:chess_flutter/models/enums/auth_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/cw_loading_widget.dart';
import '../bloc/auth_state.dart';
import '../widget/auth_content_widget.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = "/auth_screen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isWating = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isWating) {
          isWating = false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthErrorState) {
                      if (isWating) {
                        isWating = false;
                        Navigator.pop(context);
                      }
                      print("error: ${state.message}");
                    }
                    if (state is WatingForAuthState) {
                      // showAlertDialog("wating");
                      isWating = true;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (c) {
                          return const CWLoadingWidget();
                        },
                      );
                    }
                    if (state is AuthSucceedState) {
                      if (isWating) {
                        isWating = false;
                        Navigator.pop(context);
                      }
                      print("wellcome");
                      Navigator.pop(context);
                    }
                  },
                  buildWhen: (pre, cur) {
                    if (cur is InitialAuthState ||
                        cur is AuthTypeChangedState) {
                      return true;
                    }
                    return false;
                  },
                  builder: (context, state) {
                    if (state is InitialAuthState) {
                      return AuthContentWidget(authType: state.authType);
                    } else if (state is AuthTypeChangedState) {
                      return AuthContentWidget(authType: state.authType);
                    } else {
                      return const AuthContentWidget(authType: AuthType.login);
                    }
                  },
                ),
              ),
              const CWContainer(
                  h: 60, w: double.infinity, child: Text("authentication")),
            ],
          ),
        ),
      ),
    );
  }
}
