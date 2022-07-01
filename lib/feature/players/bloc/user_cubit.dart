import 'package:chess_flutter/domain/use_case/auth_register_use_case.dart';
import 'package:chess_flutter/domain/use_case/find_username_use_case.dart';
import 'package:chess_flutter/feature/players/bloc/user_state.dart';
import 'package:chess_flutter/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/register_credential.dart';

class UserCubit extends Cubit<UserState> {
  final FindUsernameUseCase findUsernameUseCase;
  UserCubit({required this.findUsernameUseCase}) : super(InitialUserState());

  void searchFeedChanged(String feed) async {
    print(feed);
    emit(SearchingUserState());
    await Future.delayed(Duration(seconds: 2));
    try {
      List<User> users = await findUsernameUseCase.execute(feed);
      emit(ResultUserState(users));
    } catch (e) {
      emit(ErrorUserState());
    }
  }
}
