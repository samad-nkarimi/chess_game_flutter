abstract class AuthRepo {
  String register(String email, String name, String password);
  String login(String email, String password);
  void logout();
}
