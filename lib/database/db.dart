import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseFire {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  Future<void> addContent(final ContestModel) async {
    _firestore
        .collection("contests")
        .add(ContestModel)
        .then((DocumentReference document) {
      // ignore: deprecated_member_use
      print(document.documentID);
    }).catchError((e) {
      print(e);
    });
  }
}
