import 'package:chess_flutter/config/network_url.dart';
import 'package:chess_flutter/models/register_credential.dart';
import 'package:http/http.dart' as http;

import '../models/auth_response.dart';
import '../models/enums/auth_response_status.dart';

class AuthService {
  var url = Uri.parse('http://$hostIp:3000/api/auth/register/');
  Future<AuthResponse> register(RegisterCredential registerCredential) async {
    http.Response response = await http.post(
      url,
      body: {
        'name': registerCredential.name,
        'email': registerCredential.email,
        'password': registerCredential.password,
      },
    );
    print(response);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode.toString().startsWith('2')) {
      return AuthResponse(
        authResponseStatus: AuthResponseStatus.succeed,
        message: response.body,
      );
    } else {
      return AuthResponse(
        authResponseStatus: AuthResponseStatus.failed,
        message: response.body,
      );
    }
  }
}
