import 'package:chess_flutter/domain/entity/message_entity.dart';

abstract class ChatRepo {
  Future<bool> sendMessage(MessageEntity messageEntity);
}
