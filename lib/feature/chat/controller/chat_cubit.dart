import 'package:chess_flutter/domain/entity/message_entity.dart';
import 'package:chess_flutter/domain/use_case/chat_use_case.dart';
import 'package:chess_flutter/feature/chat/controller/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCase chatUseCase;
  List<MessageEntity> messages = [];
  ChatCubit(this.chatUseCase) : super(InitialChatState());

  void sendMessage(MessageEntity messageEntity) async {
    //add to screen
    messages.add(messageEntity);

    emit(NewMessageChatState(
        messages, DateTime.now().millisecondsSinceEpoch.toString()));

    //send to server
    bool isSent = await chatUseCase.sendMessage(messageEntity);
    if (isSent) {
      await Future.delayed(const Duration(seconds: 2));
      //send tick
      messages = messages.map((msg) {
        msg.isReceived = true;
        return msg;
      }).toList();
      emit(NewMessageChatState(
          messages, DateTime.now().millisecondsSinceEpoch.toString()));
    }
    //if succeed, give it a tick
  }

  void messageFromServer(String text, String sender) async {
    MessageEntity messageEntity = MessageEntity(
      senderName: sender,
      receiverName: "me",
      message: text,
      fromMe: false,
    );
    messages.add(messageEntity);
    emit(NewMessageChatState(
        messages, DateTime.now().millisecondsSinceEpoch.toString()));
  }
}
