import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contest_user_app/Model/Contest_Model.dart';
import 'package:contest_user_app/Model/participateusermodel.dart';
import 'package:contest_user_app/varibles.dart';

class Database {
  Variables vari = Variables();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addContent(UserContestModel usercontestmodel) async {
    // print(contestModel.imageUrl);
    print(usercontestmodel.username);

    await _firestore
        .collection("contests")
        .doc(vari.getContestID())
        .collection('users')
        .add(usercontestmodel.toMap())
        .then((DocumentReference document) {
      // ignore: deprecated_member_use
      print(document.documentID);
      print("ASALAALALLALALAL ${vari.getContestID()}");
    }).catchError((e) {
      print(e);
    });
  }

  Stream<List<UserContestModel>> getUsers() {
    return _firestore
        .collection('contests')
        .doc(vari.getContestID())
        .collection('users').where("endDate",
            isGreaterThanOrEqualTo: 
                new DateTime.now().toUtc().millisecondsSinceEpoch)
        .snapshots()
        .map((_snapShot) => _snapShot.docs
            .map((document) => UserContestModel.fromJson({
                  "id": document.id,
                  "username": document.data()['username'],
                  "email": document.data()['email'],
                  "votes": document.data()['votes'],
                  "imageUrlUser": document.data()['imageUrlUser'],
                  "isWinner": document.data()['isWinner']
                }))
            .toList());
  }

  Stream<List<ContestModel>> getUserList() {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    print("dat");
    return _firestore
        .collection('contests')
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => ContestModel.fromJson({
                  "id": document.id,
                  "title": document.data()['title'],
                  "description": document.data()['description'],
                  "imageUrl": document.data()['imageUrl']
                }))
            .toList());
  }

  Future<void> updateVote(String contestId, String userId, int vote) async {
    await _firestore
        .collection('contests')
        .doc(contestId)
        .collection('users')
        .doc(userId)
        .update({'votes': vote + 1});
  }

  Stream<List<ContestModel>> getExpired() {
    return _firestore
        .collection('contests')
        .where("endDate",
            isLessThanOrEqualTo:
                new DateTime.now().toUtc().millisecondsSinceEpoch)
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => ContestModel.fromJson({
                  "id": document.id,
                  "title": document.data()['title'],
                  "description": document.data()['description'],
                  "imageUrl": document.data()['imageUrl']
                }))
            .toList());
  }

  Stream<List<UserContestModel>> getWinner() {
    return _firestore
        .collection('contests')
        .doc(vari.getContestID())
        .collection('users')
        .where("isWinner", isEqualTo: true)
        .snapshots()
        .map((_snapShot) => _snapShot.docs
            .map((document) => UserContestModel.fromJson({
                  "id": document.id,
                  "username": document.data()['username'],
                  "email": document.data()['email'],
                  "votes": document.data()['votes'],
                  "imageUrlUser": document.data()['imageUrlUser'],
                  "isWinner": document.data()['isWinner']
                }))
            .toList());
  }
}
