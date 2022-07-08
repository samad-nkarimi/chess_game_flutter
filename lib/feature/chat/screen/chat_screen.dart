import 'package:chess_flutter/domain/entity/message_entity.dart';
import 'package:chess_flutter/feature/chat/controller/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "/chat_screen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final scrollController = ScrollController();

  final List<Widget> msgs = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 480,
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    color: Colors.blue.shade100,
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      reverse: true,
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 10, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [...msgs],
                      ),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 40,
                          // width: 230,
                          child: TextField(
                            controller: controller,
                          ),
                        ),
                        Flexible(
                          flex: 8,
                          child: IconButton(
                            onPressed: () {
                              msgs.add(rightText("me", controller.value.text));
                              // socket.write(controller.value.text);
                              MessageEntity messageEntity = MessageEntity(
                                message: controller.value.text,
                                senderName: "sas",
                                receiverName: "sas",
                                isReceived: false,
                                isSeen: false,
                              );
                              BlocProvider.of<ChatCubit>(context)
                                  .sendMessage(messageEntity);
                              scrollController.jumpTo(0);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(2.0),
            //   child: Text("server response: $serverMsg"),
            // ),

            // ElevatedButton(
            //   onPressed: () {
            //     msgs.add(rightText(controller.value.text));
            //     socket.write(controller.value.text);
            //     setState(() {});
            //   },
            //   child: const Text("send message"),
            // ),
          ],
        ),
      ),
    ));
  }

  Widget rightText(String username, String text) {
    return baseText(username, text, Alignment.bottomRight, Colors.lightGreen);
  }

  Widget leftText(String username, String text) {
    return baseText(username, text, Alignment.bottomLeft, Colors.amber);
  }

  Widget baseText(String username, String text, Alignment alignment, color) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 5),
            const Icon(Icons.cloud_sync),
          ],
        ),
      ),
    );
  }
}
