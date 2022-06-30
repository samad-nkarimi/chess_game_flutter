import 'package:chess_flutter/domain/use_case/auth_register_use_case.dart';
import 'package:chess_flutter/feature/players/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/register_credential.dart';

class UserCubit extends Cubit<UserState> {
  final AuthRegisterUseCase authRegisterUseCase;
  UserCubit({required this.authRegisterUseCase}) : super(InitialUserState());

  void register(RegisterCredential registerCredential) {
    authRegisterUseCase.execute(registerCredential);
  }
}
