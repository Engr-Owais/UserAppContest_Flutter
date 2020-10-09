class UserContestModel {
  String username;
  String email;
  String id;
  String imageUrlUser;
  String phone;
  int votes;
  

  UserContestModel({this.username, this.email, this.imageUrlUser , this.phone , this.votes,this.id });

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();

    data["username"] =username;
    data["email"] = email;
    data["id"] =id;
    data["imageUrlUser"] = imageUrlUser;
    data["phone"] = phone;
    data["votes"] = votes;

    return data;
  }

  UserContestModel.fromJson(Map<String, dynamic> parsedJson) {
    username = parsedJson['username'];
    email = parsedJson['email'];
    id = parsedJson['id'];
    imageUrlUser = parsedJson['imageUrlUser'];
    phone = parsedJson['phone'];
    votes = parsedJson['votes'];
  }
}
