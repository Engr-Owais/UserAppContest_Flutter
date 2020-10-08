class ParticipateModel {
  final String name;
  final String email;
  final String phone;

  ParticipateModel({
    this.name,
    this.email,
        this.phone,

  });

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
      };
}
