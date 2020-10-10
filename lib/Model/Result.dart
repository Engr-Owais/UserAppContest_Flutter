class ResultModel {
  String content;
  String imageUrl;
  String username;
  String imageUrlUser;
  int votes;
  bool isWinner;

  ResultModel(
      {this.content,
      this.imageUrl,
      this.votes,
      this.imageUrlUser,
      this.isWinner,
      this.username});

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();

    data["title"] = content;

    data["imageUrl"] = imageUrl;

    data["username"] = username;

    data["imageUrlUser"] = imageUrlUser;

    data["votes"] = votes;
    data["isWinner"] = isWinner;

    return data;
  }

  ResultModel.fromJson(Map<String, dynamic> parsedJson) {
    content = parsedJson['title'];

    imageUrl = parsedJson['imageUrl'];
    username = parsedJson['username'];

    imageUrlUser = parsedJson['imageUrlUser'];
    isWinner = parsedJson['isWinner'];

    votes = parsedJson['votes'];
  }
}
