import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contest_user_app/Model/User_Model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VotingList extends StatefulWidget {
  final String id;
  VotingList({this.id});
  @override
  _VotingListState createState() => _VotingListState();
}

class _VotingListState extends State<VotingList> {
  final contest = FirebaseFirestore.instance.collection('contests');

  @override
  Widget build(BuildContext context) {
    String contestid = widget.id.toString();
    contest.get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        contestid = doc.id;
        print(contestid);
      });
    });
    return Scaffold(
        appBar: AppBar(
          elevation: 3.0,
          title: Text(
            "VOTING",
            style: GoogleFonts.aclonica(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: _buildBody(context, contestid));
  }

  Widget _buildBody(BuildContext context, String id) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('contests')
          .doc(id)
          .collection('users')
          .snapshots(),
      builder: (context, snapshot) {
        print(snapshot.data);
        print("IDDDDDDDDDD$id");
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final usermodel = UserModel.fromSnapshot(data);

    return Padding(
      key: ValueKey(usermodel.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(usermodel.name),
          trailing: Text(usermodel.votes.toString()),
          onTap: () =>
              usermodel.reference.update({'votes': usermodel.votes + 1}),
        ),
      ),
    );
  }
}
