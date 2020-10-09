import 'package:cached_network_image/cached_network_image.dart';
import 'package:contest_user_app/Model/Contest_Model.dart';
import 'package:contest_user_app/Screens/ParticipationForm.dart';
import 'package:contest_user_app/Screens/Voting_Screen.dart';
import 'package:contest_user_app/dbhelper/db.dart';
import 'package:contest_user_app/varibles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vdialog/vdialog.dart';

class OnGoingContest extends StatefulWidget {
  @override
  _OnGoingContestState createState() => _OnGoingContestState();
}

class _OnGoingContestState extends State<OnGoingContest> {
  final Variables vari = Variables();
  final Database _firestore = Database();
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
              child: StreamBuilder<List<ContestModel>>(
                stream: _firestore.getUserList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ContestModel>> querySnapshot) {
                  if (querySnapshot.hasError) {
                    return Text("Error Loading Data ......");
                  }
                  if (querySnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final list = querySnapshot.data;
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) => list.length == 0
                            ? Text("No Data Found")
                            : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2, color: Colors.red),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15))),
                                  child: ListTile(
                                    isThreeLine: true,
                                    leading: CachedNetworkImage(
                                      imageUrl: list[index].imageUrl,
                                      imageBuilder: (context, imageProvider) =>
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 7),
                                            child: Container(
                                        height: 90,
                                        width: 60,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                            image: DecorationImage(
                                              alignment: Alignment.center,
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                        ),
                                      ),
                                          ),
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    title: Text(
                                      list[index].title == null
                                          ? ""
                                          : list[index].title,
                                      style: GoogleFonts.balooDa(fontSize: 30),
                                    ),
                                    subtitle: Text(
                                      list[index].description == null
                                          ? ""
                                          : list[index].description,
                                      style: GoogleFonts.workSans(fontSize: 15),
                                    ),
                                    onTap: () => {
                                      showVDialog(),
                                      vari.setContestID(list[index].id),
                                      print(list[index].id),
                                      print("GetIDD ${vari.getContestID()}")
                                    },
                                  ),
                                ),
                            ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showVDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) => CustomDialog(
        titleContainerWidget: customTitleText(),
        contentContainerWidget: customContentText(),
        customButtonOneWidget: customButtonOne(),
        customButtonTwoWidget: customButtonTwo(),
        showButtonOne: true,
        showButtonTwo: true,
        haveAnimation: true,
        showIcon: false,
        animationsType: mAnimations.fade,
        slideInTypes: SlideInTypes.SlideInLeft,
        animationMilliseconds: 500,
      ),
    );
  }

  Widget customTitleText() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        "SELECT YOUR OPTION",
        textAlign: TextAlign.end,
        style: GoogleFonts.abel(fontSize: 30),
      ),
    );
  }

  Widget customContentText() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Text(
        "WOULD YOU LIKE TO JOIN CONTEST OR YOU WANT TO VOTE",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Widget customButtonOne() {
    return Container(
      margin: EdgeInsets.only(right: 40),
      child: FlatButton(
        color: Colors.amber,
        onPressed: () {
          _buttonOne();
          // To close the dialog
        },
        child: Text(
          "PARTICIPATE",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget customButtonTwo() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: FlatButton(
        color: Colors.amber,
        onPressed: () => {
          _buttonTwo(),

          // To close the dialog
        },
        child: Text(
          "VOTE",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void _buttonOne() {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => FormParticipate()))
        .then((value) => Navigator.of(context).pop());
  }

  void _buttonTwo() => {
        Navigator.push(context,
                MaterialPageRoute(builder: (context) => VotingScreen()))
            .then((value) => Navigator.of(context).pop()),
      };
}
