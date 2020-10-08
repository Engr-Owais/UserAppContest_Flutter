class ContestModel {
  String username;
  String email;
  String imageUrl;
  String phone;

  ContestModel({this.username, this.email, this.imageUrl , this.phone});

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();

    data["username"] =username;
    data["email"] = email;
    data["imageUrl"] = imageUrl;
    data["phone"] = phone;

    return data;
  }

  ContestModel.fromJson(Map<String, dynamic> parsedJson) {
    username = parsedJson['username'];
    email = parsedJson['email'];
    imageUrl = parsedJson['imageUrl'];
    phone = parsedJson['phone'];
  }
}
