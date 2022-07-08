import 'enums/auth_response_status.dart';

class AuthResponse {
  final AuthResponseStatus authResponseStatus;
  final String message;

  AuthResponse({
    required this.authResponseStatus,
    required this.message,
  });
}
