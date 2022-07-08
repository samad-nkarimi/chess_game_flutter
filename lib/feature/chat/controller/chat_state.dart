import 'package:chess_flutter/domain/entity/message_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {}

class InitialChatState extends ChatState {
  @override
  List<Object?> get props => [];
}

class NewMessageChatState extends ChatState {
  final List<MessageEntity> messages;
  final String id;

  NewMessageChatState(this.messages, this.id);
  @override
  List<Object?> get props => [messages, id];
}

class MessageSentChatState extends ChatState {
  final List<MessageEntity> messages;
  final String id;

  MessageSentChatState(this.messages, this.id);
  @override
  List<Object?> get props => [messages, id];
}

  // @override
  // bool operator ==(Object other) =>
  //     other is NewMessageChatState &&
  //     other.messages == messages &&
  //     other.messages.length == messages.length;
  // @override
  // int get hashCode => hashValues(messages, messages.length);
