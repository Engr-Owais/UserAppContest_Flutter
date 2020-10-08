import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contest_user_app/Screens/Voting_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

class OnGoingContest extends StatefulWidget {
  @override
  _OnGoingContestState createState() => _OnGoingContestState();
}

class _OnGoingContestState extends State<OnGoingContest> {
  String contestName;
  String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text(
          "CONTESTS",
          style: GoogleFonts.aclonica(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("contests")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return Text("Error Loading Data ......");
                  }
                  if (querySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final list = querySnapshot.data.docs;
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5),
                            child: GradientCard(
                              gradient: Gradients.blush,
                              shadowColor: Gradients.tameer.colors.last
                                  .withOpacity(0.25),
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 30),
                                  isThreeLine: true,
                                  title: Text(
                                    list[index]["content"],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.balooDa(fontSize: 30),
                                  ),
                                  subtitle: Text(
                                    list[index]["description"],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.workSans(fontSize: 15),
                                  ),
                                  onTap: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VotingList(
                                                        id: list[index].id)))
                                      }),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
