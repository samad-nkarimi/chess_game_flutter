import 'package:chess_flutter/domain/use_case/auth_register_use_case.dart';
import 'package:chess_flutter/feature/auth/bloc/auth_state.dart';
import 'package:chess_flutter/models/enums/auth_type.dart';
import 'package:chess_flutter/service/sse_service.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:chess_flutter/storage/user_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/auth_response.dart';
import '../../../models/enums/auth_response_status.dart';
import '../../../models/register_credential.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRegisterUseCase authRegisterUseCase;
  AuthCubit({required this.authRegisterUseCase})
      : super(InitialAuthState(AuthType.signup));

  void register(RegisterCredential registerCredential) async {
    // authRegisterUseCase.execute(registerCredential);
    // if (connectionStatus.hasConnection) {
    print("connecting...");
    emit(WatingForAuthState(registerCredential.authType));
    await Future.delayed(const Duration(seconds: 3));
    // String username = email.substring(0, email.indexOf('@')); //#change
    if (registerCredential.authType == AuthType.signup) {
      try {
        AuthResponse response =
            await authRegisterUseCase.execute(registerCredential);

        if (response.authResponseStatus == AuthResponseStatus.succeed) {
          // await ServerCrud().createUserDatabase();
          ServiceLocator().setUsername(registerCredential.name);
          UserStorage().saveUsername(registerCredential.name);
          SSEService().subscribe();
          emit(AuthSucceedState());
        } else {
          print("failed with statusCode: $response");
          emit(AuthErrorState(
            response.message,
            DateTime.now().millisecondsSinceEpoch.toString(),
          ));
        }
      } catch (error) {
        emit(AuthErrorState(
          error.toString(),
          DateTime.now().millisecondsSinceEpoch.toString(),
        ));
      }
    } else {
      //login
      try {
        AuthResponse response =
            await authRegisterUseCase.execute(registerCredential);

        if (response.authResponseStatus == AuthResponseStatus.succeed) {
          // after this we should go to home page as a logged in user
          // Navigator.pushReplacementNamed(context, '/');
          // String data =
          //     await ServerCrud().getDataFromServer(registerCredential.name);

          // print("from server: $data");
          emit(AuthSucceedState());
        } else {
          print("failed with statusCode: $response");
          emit(AuthErrorState(
            response.message,
            DateTime.now().millisecondsSinceEpoch.toString(),
          ));
        }
      } catch (error) {
        emit(AuthErrorState(
          error.toString(),
          DateTime.now().millisecondsSinceEpoch.toString(),
        ));
      }
    }
  }

  void authTypePressedEvent(AuthType authType) {
    emit(AuthTypeChangedState(authType));
  }
}
