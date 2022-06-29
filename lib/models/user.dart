class User {
  String name;
  String score;

  User({
    required this.name,
    required this.score,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        score = json['score'];

  static List<User> usersFromJson(List<dynamic> json) {
    List<User> users = [];
    for (var entry in json) {
      users.add(User.fromJson(entry));
    }
    return users;
  }
}
