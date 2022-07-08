import 'package:chess_flutter/common_widgets/cw_container.dart';
import 'package:chess_flutter/domain/entity/message_entity.dart';
import 'package:chess_flutter/feature/chat/controller/chat_cubit.dart';
import 'package:chess_flutter/feature/chat/controller/chat_state.dart';
import 'package:chess_flutter/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "/chat_screen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final scrollController = ScrollController();
  String competitorUsername = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String argument = ModalRoute.of(context)!.settings.arguments as String;
    competitorUsername = argument;
  }

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
                  BlocBuilder<ChatCubit, ChatState>(
                      buildWhen: (previous, current) {
                    if (current is NewMessageChatState) {
                      return true;
                    }
                    return false;
                  }, builder: (context, state) {
                    List<MessageEntity> messages = [];
                    if (state is NewMessageChatState) {
                      messages = state.messages;
                    }
                    if (state is MessageSentChatState) {
                      messages = state.messages;
                    }
                    print(state);
                    return Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.blue.shade100,
                        alignment: Alignment.bottomCenter,
                        child: ListView.builder(
                          reverse: true,
                          controller: scrollController,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            if (messages.reversed.toList()[index].fromMe) {
                              return rightText(
                                  messages.reversed.toList()[index]);
                            } else {
                              return leftText(
                                  messages.reversed.toList()[index]);
                            }
                          },
                        ),
                      ),
                    );
                  }),
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
                              // msgs.add(controller.value.text);
                              // socket.write(controller.value.text);
                              MessageEntity messageEntity = MessageEntity(
                                message: controller.value.text,
                                senderName: ServiceLocator().username,
                                receiverName: competitorUsername,
                                fromMe: true,
                                isReceived: false,
                                isSeen: false,
                              );
                              BlocProvider.of<ChatCubit>(context)
                                  .sendMessage(messageEntity);
                              scrollController.jumpTo(0);
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

  Widget rightText(MessageEntity message) {
    return baseText(message, Alignment.bottomRight, Colors.lightGreen);
  }

  Widget leftText(MessageEntity message) {
    return baseText(message, Alignment.bottomLeft, Colors.amber);
  }

  Widget baseText(MessageEntity message, Alignment alignment, color) {
    return Align(
      alignment: alignment,
      child: CWContainer(
        pad: const [6, 15, 6, 15],
        mar: const [2, 2, 2, 2],
        color: color,
        br: [15, 15, message.fromMe ? 1 : 15, message.fromMe ? 15 : 1],
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Text(
                message.message,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.clip,
                softWrap: true,
              ),
            ),
            if (message.fromMe) const SizedBox(width: 10),
            if (message.fromMe)
              FaIcon(
                message.isReceived
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.clock,
                size: 10,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
