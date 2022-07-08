import 'package:chess_flutter/domain/entity/message_entity.dart';
import 'package:chess_flutter/domain/use_case/chat_use_case.dart';
import 'package:chess_flutter/feature/chat/controller/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatUseCase chatUseCase;
  ChatCubit(this.chatUseCase) : super(InitialChatState());

  void sendMessage(MessageEntity messageEntity) async {
    //add to screen

    //send to server
    bool isSent = await chatUseCase.sendMessage(messageEntity);
    if (isSent) {
      //send tick
    }
    //if succeed, give it a tick
  }
}
