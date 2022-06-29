import 'package:http/http.dart' as http;

class AuthService {
  var url = Uri.parse('https://example.com/whatsit/create');
  void register() async {
    var response = http.post(
      url,
      body: {
        'name': 'doodle',
        'email': 'blue',
        'password': 'blue',
      },
    );
  }
}
