abstract class RemoteRequestPLayRepo {
  Future<bool> sendPlayRequestTo(String requestUsername, String targetUsername);
  Future<bool> acceptPlayRequestFrom(
      String requestUsername, String targetUsername);
  Future<bool> rejectPlayRequestFrom(
      String requestUsername, String targetUsername);
  Future<bool> cancellPlay(String requestUsername, String targetUsername);
}
