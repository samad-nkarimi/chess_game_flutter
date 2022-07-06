abstract class PlayRequestStorageRepo{
   Future<bool> saveNewRequest(String username,String score);
   Future<bool> deleteRequest(String username);
   Future<void> fetchAllRequests();

}