import 'package:chess_flutter/config/network_url.dart';
import 'package:chess_flutter/domain/entity/message_entity.dart';

import 'package:http/http.dart' as http;

class ChatService {
  Future<bool> sendMessage(MessageEntity messageEntity) async {
    var url = Uri.parse('http://$hostIp:3000/api/chat/new_message');
    http.Response response = await http.post(
      url,
      body: {
        'sender': messageEntity.senderName,
        'receiver': messageEntity.receiverName,
        'message': messageEntity.message,
      },
    );
    print(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteMessage(MessageEntity messageEntity) async {
    var url = Uri.parse('http://$hostIp:3000/api/chat/delete_message');
    http.Response response = await http.post(
      url,
      body: {
        'sender': messageEntity.senderName,
        'receiver': messageEntity.receiverName,
        'message': messageEntity.message,
      },
    );
    print(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      return true;
    } else {
      return false;
    }
  }
}
