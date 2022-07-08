class PlayRequest {
  String username;
  String score;

  PlayRequest(this.username, this.score);

  PlayRequest.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        score = json["score"];
}
