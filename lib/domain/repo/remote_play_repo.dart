abstract class RemotePLayRepo {
  void sendPlayRequestTo(String requestUsername, String targetUsername);
  void acceptPlayRequestFrom(String requestUsername, String targetUsername);
  void rejectPlayRequestFrom(String requestUsername, String targetUsername);
}
