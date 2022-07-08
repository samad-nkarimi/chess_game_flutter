import 'package:chess_flutter/domain/entity/message_entity.dart';
import 'package:chess_flutter/domain/repo/chat_repo.dart';
import 'package:chess_flutter/service/chat_service.dart';

class ChatRepoIml extends ChatRepo {
  final ChatService chatService;

  ChatRepoIml(this.chatService);
  @override
  Future<bool> sendMessage(MessageEntity messageEntity) async {
    return await chatService.sendMessage(messageEntity);
  }
}
