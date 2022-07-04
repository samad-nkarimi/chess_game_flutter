import 'package:hive/hive.dart';

class UserStorage {
  static final UserStorage _singleton = UserStorage._internal();
  factory UserStorage() {
    return _singleton;
  }
  UserStorage._internal();

  final String playsBox = "user_box";

  void createBox() async {
    await Hive.openBox<String>(playsBox);
    await Hive.close();
  }

  Future<Box> getBox() async {
    Box box = await Hive.openBox(playsBox);
    return box;
  }

  void saveUsername(String username) async {
    Box box = await getBox();
    await box.put("username", username);
    await box.close();
  }

  Future<String> getUsername() async {
    Box box = await getBox();
    String username = "mobile";
    try {
      username = await box.get("username");
    } catch (e) {}
    await box.close();
    return username;
  }
}
