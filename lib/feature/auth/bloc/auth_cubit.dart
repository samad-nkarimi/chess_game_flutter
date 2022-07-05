import 'package:chess_flutter/domain/entity/credential_entity.dart';
import 'package:chess_flutter/domain/use_case/auth_register_use_case.dart';
import 'package:chess_flutter/feature/auth/bloc/auth_state.dart';
import 'package:chess_flutter/feature/auth/widget/auth_input_field.dart';
import 'package:chess_flutter/models/enums/auth_filed_type.dart';
import 'package:chess_flutter/models/enums/auth_type.dart';
import 'package:chess_flutter/service/sse_service.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:chess_flutter/storage/user_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/auth_response.dart';
import '../../../models/enums/auth_response_status.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRegisterUseCase authRegisterUseCase;
  AuthCubit({required this.authRegisterUseCase})
      : super(InitialAuthState(AuthType.signup));

  void formContentChanged(AuthFiledType filed, CredentialEntity entity) {
    bool isFiledValid =
        authRegisterUseCase.singleFiledValidationFor(filed, entity);
    print(isFiledValid);
    emit(FiledValidationAuthState(
        filed, isFiledValid, DateTime.now().millisecondsSinceEpoch.toString()));
    Future.delayed(Duration.zero);
    bool isFormValid =
        authRegisterUseCase.credentialValidationForSignUp(entity);
    emit(FormValidationAuthState(
        isFormValid, DateTime.now().millisecondsSinceEpoch.toString()));
  }

  void signUp(CredentialEntity entity) async {
    try {
      AuthResponse response = await authRegisterUseCase.signUp(entity);

      if (response.authResponseStatus == AuthResponseStatus.succeed) {
        // await ServerCrud().createUserDatabase();
        ServiceLocator().setUsername(entity.username);
        UserStorage().saveUsername(entity.username);
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
  }

  void login(CredentialEntity entity) async {
    try {
      AuthResponse response = await authRegisterUseCase.login(entity);

      if (response.authResponseStatus == AuthResponseStatus.succeed) {
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

  void authTypePressedEvent(AuthType authType, CredentialEntity entity) {
    emit(AuthTypeChangedState(authType));
    Future.delayed(Duration.zero);
    bool isFormValid = false;
    if (authType == AuthType.signup) {
      isFormValid = authRegisterUseCase.credentialValidationForSignUp(entity);
    } else {
      isFormValid = authRegisterUseCase.credentialValidationForLogin(entity);
    }
    emit(FormValidationAuthState(
        isFormValid, DateTime.now().millisecondsSinceEpoch.toString()));
  }
}
