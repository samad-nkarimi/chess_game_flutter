import 'package:chess_flutter/blocs/simple_bloc_observer.dart';
import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_elevated_button.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/domain/repo/auth_repo.dart';
import 'package:chess_flutter/domain/repo/remote_play_move_repo.dart';
import 'package:chess_flutter/domain/use_case/auth_register_use_case.dart';
import 'package:chess_flutter/domain/use_case/find_username_use_case.dart';
import 'package:chess_flutter/domain/use_case/play_request_use_case.dart';
import 'package:chess_flutter/domain/use_case/play_requests_storage_usa_case.dart';
import 'package:chess_flutter/domain/use_case/plays_storage_use_case.dart';
import 'package:chess_flutter/domain/use_case/remote_play_move_use_case.dart';
import 'package:chess_flutter/feature/auth/bloc/auth_cubit.dart';
import 'package:chess_flutter/feature/bottom_nav/screen/vav_screen.dart';
import 'package:chess_flutter/feature/chess/bloc/chess/chess_cubit.dart';
import 'package:chess_flutter/feature/chess/screen/chess_screen.dart';
import 'package:chess_flutter/feature/home/bloc/home_cubit.dart';
import 'package:chess_flutter/feature/home/screen/home_screen.dart';
import 'package:chess_flutter/feature/play_request/bloc/play_request_cubit.dart';
import 'package:chess_flutter/feature/play_request/screen/play_request_screen.dart';

import 'package:chess_flutter/repository/auth_repo_impl.dart';
import 'package:chess_flutter/repository/play_requests_storage_repo_impl.dart';
import 'package:chess_flutter/repository/plays_storage_repo_impl.dart';
import 'package:chess_flutter/repository/remote_play_move_repo_impl.dart';
import 'package:chess_flutter/repository/remote_play_repo_impl.dart';
import 'package:chess_flutter/repository/user_repo_impl.dart';
import 'package:chess_flutter/service/auth_service.dart';
import 'package:chess_flutter/service/remote_move_service.dart';
import 'package:chess_flutter/service/request_play_service.dart';
import 'package:chess_flutter/service/sse_service.dart';
import 'package:chess_flutter/service/user_service.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:chess_flutter/storage/chess_play_storage.dart';
import 'package:chess_flutter/storage/play_requests_storage.dart';
import 'package:chess_flutter/storage/remote_plays_storage.dart';
import 'package:chess_flutter/storage/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'feature/auth/screen/auth_screen.dart';
import 'feature/players/bloc/user_cubit.dart';
import 'feature/players/screen/players_screen.dart';

void main() async {
  ServiceLocator serviceLocator = ServiceLocator();
  await Hive.initFlutter();
  await Hive.deleteFromDisk();
  // PlayStorage().createBox();
  serviceLocator.setUsername(await UserStorage().getUsername());
  SSEService().subscribe();
  BlocOverrides.runZoned(
    () {
      runApp(
        MultiBlocProvider(
          providers: [
            // BlocProvider(create: (context) => ChessCubit()),
            BlocProvider(
              create: (context) => UserCubit(
                  findUsernameUseCase: FindUsernameUseCase(
                    UserRepoImpl(UserService()),
                  ),
                  playRequestUseCase: PlayRequestUseCase(
                    RemoteRequestPlayRepoImpl(RequestPlayService()),
                  ),
                  playsStorageUseCase: PlaysStorageUseCase(
                    PlaysStorageRepoImpl(RemotePlaysStorage()),
                  )),
            ),
            BlocProvider(
              create: (context) => AuthCubit(
                authRegisterUseCase: AuthRegisterUseCase(
                  AuthRepoImpl(
                    AuthService(),
                  ),
                ),
              ),
            ),
            BlocProvider(
              create: (context) => HomeCubit(
                  PlaysStorageUseCase(
                    PlaysStorageRepoImpl(RemotePlaysStorage()),
                  ),
                  PlayRequestsStorageUseCase(
                    PlayRequestStorageRepoImpl(PlayRequestsStorage()),
                  ),
                  PlayRequestUseCase(
                    RemoteRequestPlayRepoImpl(RequestPlayService()),
                  ))
                ..init(),
            ),
            BlocProvider(
              create: (context) => PlayRequestCubit(
                PlayRequestUseCase(RemoteRequestPlayRepoImpl(
                  RequestPlayService(),
                )),
                PlaysStorageUseCase(
                  PlaysStorageRepoImpl(RemotePlaysStorage()),
                ),
                PlayRequestsStorageUseCase(
                  PlayRequestStorageRepoImpl(PlayRequestsStorage()),
                ),
              ),
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'let\'s play chess',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      // home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const BottomNavScreen(),
        HomeScreen.routeNAme: (context) => const HomeScreen(),
        "/1": (context) => const PlayersScreen(),
        AuthScreen.routeName: (context) => const AuthScreen(),
        ChessScreen.routeName: (context) => ChessScreen(
            usecase: RemotePlayMoveUseCase(
                RemotePlayMoveRepoImpl(RemoteMoveService()))),
        PlayRequestScreen.routeName: (context) => const PlayRequestScreen(),
      },
    );
  }
}
