import 'package:chess_flutter/config/network_url.dart';
import 'package:chess_flutter/models/credential_model.dart';
import 'package:chess_flutter/models/register_credential.dart';
import 'package:http/http.dart' as http;

import '../models/auth_response.dart';
import '../models/enums/auth_response_status.dart';

class AuthService {
  Future<AuthResponse> signUp(CredentialModel credential) async {
    var url = Uri.parse('http://$hostIp:3000/api/auth/register/');
    http.Response response = await http.post(
      url,
      body: {
        'name': credential.username,
        'email': credential.email,
        'password': credential.password,
      },
    );
    print(response.body);
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

  Future<AuthResponse> login(CredentialModel credential) async {
    var url = Uri.parse('http://$hostIp:3000/api/auth/login/');
    http.Response response = await http.post(
      url,
      body: {
        'email': credential.email,
        'password': credential.password,
      },
    );
    print(response.body);
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

  Future<AuthResponse> logout(CredentialModel credential) async {
    var url = Uri.parse('http://$hostIp:3000/api/auth/logout/');
    http.Response response = await http.post(
      url,
      body: {
        'email': credential.email,
      },
    );
    print(response.body);
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
