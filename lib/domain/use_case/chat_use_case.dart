import 'package:chess_flutter/domain/entity/message_entity.dart';
import 'package:chess_flutter/domain/repo/chat_repo.dart';

class ChatUseCase {
  final ChatRepo chatRepo;

  ChatUseCase(this.chatRepo);
  Future<bool> sendMessage(MessageEntity messageEntity) async {
    return await chatRepo.sendMessage(messageEntity);
  }

  Future<bool> deleteMessage(MessageEntity messageEntity) async {
    return await chatRepo.deleteMessage(messageEntity);
  }
}
