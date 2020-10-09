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
          "CONTESTS RUNNING",
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
                      ConnectionState.none) {
                    return Center(child: CircularProgressIndicator(strokeWidth: 5,));
                  } else {
                    final list = querySnapshot.data;
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) => list.length == 0
                          ? Text("No Data Found")
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: CachedNetworkImage(
                                          imageUrl: list[index].imageUrl,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 300,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                              shape: BoxShape.rectangle,
                                              image: DecorationImage(
                                                alignment: Alignment.center,
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.red,
                                                    BlendMode.colorBurn),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.red,
                                      thickness: 2,
                                      height: 2,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        selected: true,
                                        isThreeLine: true,
                                        // leading: CachedNetworkImage(
                                        //   imageUrl: list[index].imageUrl,
                                        //   imageBuilder:
                                        //       (context, imageProvider) =>
                                        //           Padding(
                                        //     padding: const EdgeInsets.only(
                                        //         bottom: 7),
                                        //     child: Container(
                                        //       height: 90,
                                        //       width: 60,
                                        //       decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.circular(30),
                                        //         image: DecorationImage(
                                        //           alignment: Alignment.center,
                                        //           image: imageProvider,
                                        //           fit: BoxFit.cover,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   placeholder: (context, url) =>
                                        //       CircularProgressIndicator(),
                                        //   errorWidget: (context, url, error) =>
                                        //       Icon(Icons.error),
                                        // ),
                                        title: Text(
                                          list[index].title == null
                                              ? ""
                                              : list[index].title,
                                          style: GoogleFonts.acme(
                                              fontSize: 30,
                                              color: Colors.black,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          list[index].description == null
                                              ? ""
                                              : list[index].description,
                                          style: GoogleFonts.asar(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        onTap: () => {
                                          _showDialogBoth(),
                                          vari.setContestID(list[index].id),
                                          print(list[index].id),
                                          print("GetIDD ${vari.getContestID()}")
                                        },
                                        trailing: Icon(Icons.arrow_forward_ios),
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                    side:
                                        BorderSide(width: 2, color: Colors.red),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                              ),
                            ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogBoth() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("SELECT YOUR OPTION"),
            content: Text("WOULD YOU LIKE TO JOIN CONTEST OR YOU WANT TO VOTE"),
            actions: [
              new FlatButton(
                  onPressed: () => _buttonOne(), child: Text("PARTICIPATE")),
              FlatButton(onPressed: () => _buttonTwo(), child: Text("VOTE"))
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          );
        });
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
