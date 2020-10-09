class ContestModel {
  String title;
  String description;
  String imageUrl;
  String id;

  ContestModel({this.title, this.description, this.imageUrl ,this.id});

  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();

    data["title"] = title;
    data["description"] = description;
    data["imageUrl"] = imageUrl;
    data["id"] = id;

    return data;
  }

  ContestModel.fromJson(Map<String, dynamic> parsedJson) {
    title = parsedJson['title'];
    description = parsedJson['description'];
    imageUrl = parsedJson['imageUrl'];
    id = parsedJson['id'];
  }
}
