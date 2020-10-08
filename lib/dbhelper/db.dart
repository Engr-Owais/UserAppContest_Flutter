import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contest_user_app/Model/Contest_Model.dart';

class Database{

Stream<List<ContestModel>> getUserList() {

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    print("dat");
    return _firestore.collection('contests').snapshots().map((snapShot) =>
        snapShot.docs
            .map((document) => ContestModel.fromJson(document.data()))
            .toList());
  }
}