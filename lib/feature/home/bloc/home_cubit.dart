import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState(0));

  void addNewRemotePlay(String targetUsername) {
    // emit(NewRemotePlayHomeState(targetUsername));
    emit(PlaysListHomeState(1));
  }
}
