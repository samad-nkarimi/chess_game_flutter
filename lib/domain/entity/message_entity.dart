import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String senderName;
  final String receiverName;
  final String message;
  final bool fromMe;
  bool isReceived;
  bool isSeen;

  MessageEntity({
    required this.fromMe,
    required this.senderName,
    required this.receiverName,
    required this.message,
    this.isReceived = false,
    this.isSeen = false,
  });
  @override
  List<Object?> get props =>
      [senderName, receiverName, message, isReceived, isSeen];
}
