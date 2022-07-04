import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/common_widgets/cw_text.dart';
import 'package:chess_flutter/domain/entity/remote_play_entity.dart';
import 'package:chess_flutter/feature/home/bloc/home_cubit.dart';
import 'package:chess_flutter/feature/home/bloc/home_state.dart';
import 'package:chess_flutter/feature/home/screen/request_plays_screen.dart';
import 'package:chess_flutter/feature/home/widget/remote_play_item_widget.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const routeNAme = "/home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: CWText(
            "..C.H.E.S.S..",
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: CWContainer(
        color: Colors.black12,
        w: double.infinity,
        h: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CWContainer(
                h: 150,
                w: double.infinity,
                mar: const [10, 30, 10, 30],
                brAll: 5,
                color: Colors.black38,
                child: Stack(
                  children: [
                    const CWText("user"),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RequestPlaysScreen.routeName);
                        },
                        child: const CWContainer(
                          h: 40,
                          w: 40,
                          brAll: 30,
                          mar: [10, 10, 10, 10],
                          brColor: Colors.white,
                          child: Icon(
                            Icons.add,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                buildWhen: ((previous, current) {
                  if (current is PlaysListHomeState) {
                    return true;
                  }
                  if (current is InitialHomeState) {
                    return true;
                  }

                  return false;
                }),
                builder: (context, state) {
                  int playCount = 0;
                  List<RemotePlayEntity> remotePlays = [];
                  if (state is PlaysListHomeState) {
                    playCount = state.remotePlays.length;
                    remotePlays = state.remotePlays;
                  }
                  if (state is InitialHomeState) {
                    playCount = state.remotePlays.length;
                    remotePlays = state.remotePlays;
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: playCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          max(1, MediaQuery.of(context).size.width ~/ 150),
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      return RemotePlayItemWidget(
                          remotePlay: remotePlays[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
