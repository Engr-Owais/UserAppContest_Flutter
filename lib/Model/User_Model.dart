import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String email;
  final int phone;
  final int votes;
  final DocumentReference reference;

  UserModel.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        assert(map['email'] != null),
        assert(map['phone'] != null),
        // assert(map['imgUrl'] != null),
        name = map['name'],
        votes = map['votes'],
        phone = map['phone'],
        email = map['email'];
        // imgUrl = map['imgUrl'];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "UserModel<$name:$votes>";
}
