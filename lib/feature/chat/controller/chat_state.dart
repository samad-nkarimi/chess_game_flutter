import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {}

class InitialChatState extends ChatState {
  @override
  List<Object?> get props => [];
}
